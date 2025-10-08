import 'package:collection/collection.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/client_manager.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linagora_design_flutter/cozy_config_manager/cozy_config_manager.dart';
import 'package:matrix/matrix.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/background_push.dart';
import 'widgets/twake_app.dart';
import 'widgets/lock_screen.dart';

/// ============================================================================
/// UYGULAMA BAŞLATMA NOKTASI - main() fonksiyonu
/// ============================================================================
/// Bu fonksiyon Flutter uygulamasının giriş noktasıdır.
/// Uygulama başlatma süreci şu adımları takip eder:
/// 1. Flutter binding'lerini başlat
/// 2. Platform ayarlarını yapılandır
/// 3. Veritabanı (Hive) başlat
/// 4. Dependency injection (GetIt) kur
/// 5. Matrix client'ları yükle
/// 6. Background/foreground modunu belirle
/// 7. GUI'yi başlat
void main() async {
  // ============================================================================
  // ADIM 1: Flutter Binding'lerini Başlat
  // ============================================================================
  // Background push notification'lar için Flutter'ın internal bileşenlerine
  // erken erişim gerekiyor. Bu yüzden widget binding'lerini başlatıyoruz.
  WidgetsFlutterBinding.ensureInitialized();
  
  // ============================================================================
  // ADIM 2: Platform Ayarlarını Yapılandır
  // ============================================================================
  // Sadece dikey (portrait) yönelimi destekle
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  // Media kit'i başlat (video/audio oynatma için)
  MediaKit.ensureInitialized();
  
  // GoRouter URL yansıtma ayarını etkinleştir
  GoRouter.optionURLReflectsImperativeAPIs = true;
  
  // ============================================================================
  // ADIM 3: Veritabanı (Hive) Başlat
  // ============================================================================
  // Linux için özel dizin, diğer platformlar için Flutter'ın varsayılan dizini
  if (PlatformInfos.isLinux) {
    Hive.init((await getApplicationSupportDirectory()).path);
  } else {
    await Hive.initFlutter();
  }

  // ============================================================================
  // ADIM 4: Dependency Injection (GetIt) Kurulumu
  // ============================================================================
  // Tüm servislerin ve dependency'lerin kayıt edildiği merkezi sistem
  GetItInitializer().setUp();

  // ============================================================================
  // ADIM 5: Matrix Client'larını Yükle ve Hazırla
  // ============================================================================
  // iOS hariç tüm platformlarda native renkleri kullan
  Logs().nativeColors = !PlatformInfos.isIOS;
  
  // Kayıtlı Matrix client'larını getir
  final clients = await ClientManager.getClients();
  
  // İlk client'ı önceden yükle (performans için)
  final firstClient = clients.firstOrNull;
  
  // Web hariç tüm platformlarda collection silme özelliğini etkinleştir
  firstClient?.isSupportDeleteCollections = !PlatformInfos.isWeb;
  
  // Client'ın odalarını ve hesap verilerini yükle
  await firstClient?.roomsLoading;
  await firstClient?.accountDataLoading;

  // ============================================================================
  // ADIM 6: Background/Foreground Modunu Belirle
  // ============================================================================
  // Android'de uygulama detached (ayrılmış) modda başlarsa, bu background
  // push notification işleme modu demektir. GUI başlatmadan sadece
  // notification'ları işle.
  if (PlatformInfos.isAndroid &&
      AppLifecycleState.detached == WidgetsBinding.instance.lifecycleState) {
    // Background modda sadece push notification'ları işle
    BackgroundPush.clientOnly(clients.first);
    
    // Uygulama detached moddan çıktığında GUI'yi başlatmak için observer ekle
    WidgetsBinding.instance.addObserver(AppStarter(clients));
    
    Logs().i(
      '${AppConfig.applicationName} started in background-fetch mode. No GUI will be created unless the app is no longer detached.',
    );
    return; // GUI başlatma, sadece notification işleme
  }

  // ============================================================================
  // ADIM 7: Web Platform Özel Ayarları
  // ============================================================================
  if (PlatformInfos.isWeb) {
    CozyConfigManager().injectCozyScript(AppConfig.cozyExternalBridgeVersion);
  }

  // ============================================================================
  // ADIM 8: GUI'yi Başlat (Foreground Modu)
  // ============================================================================
  Logs().i(
    '${AppConfig.applicationName} started in foreground mode. Rendering GUI...',
  );
  await startGui(clients);
}

/// ============================================================================
/// GUI BAŞLATMA FONKSİYONU - startGui()
/// ============================================================================
/// Bu fonksiyon Flutter uygulamasının GUI'sini başlatır.
/// İşlem sırası:
/// 1. Mobil cihazlarda app lock PIN'ini kontrol et
/// 2. App lock varsa TwakeApp'i AppLock ile sar
/// 3. App lock yoksa doğrudan TwakeApp'i başlat
/// 4. runApp() ile Flutter widget tree'sini başlat
Future<void> startGui(List<Client> clients) async {
  // ============================================================================
  // ADIM 1: App Lock PIN'ini Kontrol Et (Sadece Mobil)
  // ============================================================================
  // Mobil cihazlarda güvenlik için app lock PIN'i kontrol et
  String? pin;
  if (PlatformInfos.isMobile) {
    try {
      // Güvenli depolamadan PIN'i oku
      pin = await const FlutterSecureStorage().read(key: SettingKeys.appLockKey);
    } catch (e, s) {
      // PIN okuma hatası durumunda log'la ama uygulamayı durdurma
      Logs().d('Unable to read PIN from Secure storage', e, s);
    }
  }

  // ============================================================================
  // ADIM 2: Uygulamayı Başlat (App Lock ile veya doğrudan)
  // ============================================================================
  // Mobil cihazlarda app lock varsa TwakeApp'i AppLock ile sar
  // Diğer platformlarda doğrudan TwakeApp'i başlat
  // (Çünkü diğer platformlarda AppLock routing sorunlarına neden oluyor)
  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) => TwakeApp(clients: clients), // Ana uygulama widget'ı
            lockScreen: const LockScreen(), // Kilit ekranı widget'ı
            enabled: pin?.isNotEmpty ?? false, // PIN varsa app lock'u etkinleştir
          )
        : TwakeApp(clients: clients), // Desktop/web için doğrudan ana uygulama
  );
}

/// ============================================================================
/// UYGULAMA YAŞAM DÖNGÜSÜ İZLEYİCİSİ - AppStarter
/// ============================================================================
/// Bu sınıf Android'de background moddan foreground moda geçişi izler.
/// 
/// ÇALIŞMA PRENSİBİ:
/// 1. Uygulama background'da push notification işlerken GUI başlatılmaz
/// 2. Kullanıcı uygulamayı açtığında (detached moddan çıktığında) GUI başlatılır
/// 3. GUI sadece bir kez başlatılır (guiStarted flag'i ile kontrol edilir)
class AppStarter with WidgetsBindingObserver {
  final List<Client> clients; // Matrix client'ları
  bool guiStarted = false; // GUI'nin başlatılıp başlatılmadığını takip eder

  AppStarter(this.clients);

  /// ============================================================================
  /// UYGULAMA YAŞAM DÖNGÜSÜ DEĞİŞİKLİK İZLEYİCİSİ
  /// ============================================================================
  /// Bu metod uygulamanın yaşam döngüsü değişikliklerini izler.
  /// Background'dan foreground'a geçişte GUI'yi başlatır.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // GUI zaten başlatıldıysa tekrar başlatma
    if (guiStarted) return;
    
    // Hala detached modda ise GUI başlatma
    if (state == AppLifecycleState.detached) return;

    // Detached moddan çıktığında GUI'yi başlat
    Logs().i(
      '${AppConfig.applicationName} switches from the detached background-fetch mode to ${state.name} mode. Rendering GUI...',
    );
    startGui(clients);
    
    // GUI'nin sadece bir kez başlatılmasını garanti et
    guiStarted = true;
  }
}
