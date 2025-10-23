/// ============================================================================
/// FEATURE FLAGS - Özellik Açma/Kapama Kontrolleri
/// ============================================================================
/// Bu sınıf uygulamanın hangi özelliklerinin aktif olduğunu kontrol eder.
/// Landing screen ve multi-homeserver gibi özellikleri devre dışı bırakmak için
/// kullanılır.
class FeatureFlags {
  /// Landing ekranını göster (Sign in / Create Dedi ID / Use your company server)
  /// 
  /// false olduğunda:
  /// - Landing ekranı bypass edilir
  /// - Unauthenticated kullanıcılar direkt /phone-input'a yönlendirilir
  /// - "Use your company server" butonu gizlenir
  static const bool enableLanding = false;

  /// Multi-homeserver desteğini etkinleştir
  /// 
  /// false olduğunda:
  /// - Sadece dedim.com.tr homeserver'ı kullanılır
  /// - Kullanıcı kendi homeserver'ını seçemez
  /// - Homeserver picker ekranı gösterilmez
  static const bool enableMultiHomeserver = false;

  /// Debug mod: Redirect ve auth state log'larını göster
  /// 
  /// true olduğunda:
  /// - [BOOT], [REDIRECT], [BUILD] log'ları konsola basılır
  /// - Router debug diagnostics aktiftir
  /// - Auth state değişiklikleri takip edilir
  static const bool enableDebugLogs = true;
}
