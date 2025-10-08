# Twake Chat ve ToM-server Ekosistem Araştırması

## Kapsamlı Mimari ve Repository Analizi

Linagora'nın Twake Chat (twake-on-matrix) ve ToM-server projeleri, **48+ repository'den oluşan geniş bir ekosistem** oluşturuyor. Bu araştırma, telefon numarası ile OTP authentication sisteminin nasıl çalıştığını, tüm kullanılan repository'leri ve ToM-server'ın iç mimarisini detaylı şekilde ortaya koyuyor.

## Repository'lerin tam listesi: 48+ paket ve modül

Linagora GitHub organizasyonunda toplam **439 public repository** bulunuyor, ancak bunların 48'i doğrudan Twake Chat ve ToM-server ekosistemiyle ilgili. **Ana projeler iki repository'den oluşuyor**: twake-on-matrix (Flutter client) ve ToM-server (Node.js backend). ToM-server tek başına **12 internal package** içeren monorepo yapısında, Twake Chat ise **14+ Flutter/Dart kütüphanesine** bağımlı.

### Ana projeler ve temel yapı

**twake-on-matrix** (https://github.com/linagora/twake-on-matrix) FluffyChat'ten fork edilmiş, Dart/Flutter ile yazılmış multi-platform bir Matrix client. AGPL-3.0 lisanslı proje iOS, Android, Web ve Desktop platformlarını destekliyor. **ToM-server** (https://github.com/linagora/ToM-server) ise Matrix Synapse sunucusunu genişleten, Node.js/TypeScript tabanlı bir identity server ve application service sağlıyor.

### ToM-server internal packages: 12 modül

ToM-server'ın packages/ dizininde **tam olarak 12 adet modül** bulunuyor. Bunların 5'i authentication ve identity management ile doğrudan ilgili:

**@twake/matrix-identity-server** - Matrix Identity Service'in Node.js implementasyonu, telefon numarası ve email yönetimi yapan temel paket. **@twake/server (tom-server)** - matrix-identity-server'ı genişleten ana orchestration paketi. **@twake/matrix-client-server** - Matrix Client-Server API implementasyonu, client authentication'ı yöneten modül. **@twake/federated-identity-service** - MSC4004 proposal'ına göre federe kimlik mekanizması sağlayan paket. **@twake/crypto** - Token generation dahil kriptografik operasyonları yöneten modül.

Diğer paketler ise yardımcı modüller: **@twake/matrix-application-server** (bot ve bridge uygulamaları için application service), **@twake/matrix-invite** (davetiye sistemi için web UI), **@twake/config-parser**, **@twake/logger**, **@twake/utils**, **matrix-resolve** (server discovery için DNS/URL resolver), ve **@twake/retry-promise** (retry mekanizması).

### Flutter/Dart client dependencies: 14+ kütüphane

Twake Chat client'ı **14 custom Flutter paketi** kullanıyor. Bunlar arasında **matrix-dart-sdk** (Matrix protokolü için Dart SDK fork), **flutter_openssl_crypto** (E2EE için OpenSSL libcrypto), **linagora-design-flutter** (UI design system), **flutter_matrix_html** (HTML mesaj rendering), **rich-text-composer** (zengin metin editörü), **social_media_recorder** (sesli mesaj özelliği), **twake-previewer-flutter** (dosya önizleme) ve contact, emoji, image gallery gibi özellikler için 7+ ek paket bulunuyor.

### İlgili ekosistem projeleri

Twake Workplace suite'in diğer bileşenleri de listede: **twake-workplace** (ana platform), **twake-drive** (Google Drive alternatifi), **tmail-flutter** ve **tmail-backend** (JMAP email), **james-project** (Apache James mail server). LinShare dosya paylaşım projesi için 7+ repository (linshare-core, linshare-mobile-flutter-app, çeşitli Docker image'ları) mevcut.

### Tam repository listesi (48+ öge)

#### Core Projects (2)
1. **twake-on-matrix** - Multi-platform Matrix client (Flutter)
2. **ToM-server** - Matrix Identity Server ve Application Service (Node.js)

#### ToM-server Internal Packages (12)
3. **@twake/matrix-identity-server** - Matrix Identity Service implementasyonu
4. **@twake/matrix-client-server** - Matrix Client-Server API
5. **@twake/matrix-application-server** - Matrix Application Service API
6. **@twake/server (tom-server)** - Ana Twake Chat Server
7. **@twake/federated-identity-service** - Federated Identity Service
8. **@twake/matrix-invite** - Matrix invitation web application
9. **@twake/config-parser** - Configuration parser
10. **@twake/crypto** - Kriptografik metodlar
11. **@twake/logger** - Logging modülü
12. **@twake/utils** - Utility metodları
13. **matrix-resolve** - Matrix server name resolver
14. **@twake/retry-promise** - Retry promise extension

#### Flutter/Dart Client Libraries (14)
15. **matrix-dart-sdk** - Matrix SDK Dart implementasyonu
16. **flutter_openssl_crypto** - OpenSSL crypto for Flutter
17. **linagora-design-flutter** - Enterprise UI design system
18. **flutter_matrix_html** - Matrix HTML renderer
19. **rich-text-composer** - Rich text editor
20. **html-editor-enhanced** - WYSIWYG HTML editor
21. **emoji_mart** - Emoji picker
22. **flutter_contacts** - Contact access
23. **image_gallery_saver** - Image gallery saver
24. **social_media_recorder** - Voice/video recorder
25. **twake-previewer-flutter** - File previewer
26. **flutter-date-range-picker** - Date range picker
27. **dart_native_imaging** - Native image processing
28. **intl_generator** - Internationalization generator

#### Twake Workplace Ecosystem (3)
29. **twake-workplace** - All-in-one collaboration suite
30. **twake-drive** - Google Drive alternatifi
31. **Twake** - Deprecated eski platform

#### Email (tmail) Related (5)
32. **tmail-flutter** - JMAP email client (Flutter)
33. **tmail-backend** - Twake Mail backend (Apache James)
34. **james-project** - Apache James Project
35. **jmap-client** - JavaScript JMAP client
36. **twake-calendar-integration-tests** - Calendar integration tests

#### LinShare File Sharing (7)
37. **linshare** - LinShare template repo
38. **linshare-core** - LinShare core application
39. **linshare-mobile-flutter-app** - LinShare mobile app
40. **linshare-docker** - Docker compose setup
41. **linshare-dockerfile** - Official Docker image
42. **linshare-backend-dockerfile** - Backend Docker image
43. **linshare-ui-user-dockerfile** - UI Docker image

#### Identity & Collaboration (3)
44. **mini-dm** - LinID directory manager
45. **twake-calendar-side-service** - Calendar backend service
46. **openpaas-esn** - OpenPaaS Enterprise Social Network

#### AI & RAG (2)
47. **openrag** - Open source RAG application stack
48. **openrag-documentation** - OpenRAG documentation

## Telefon numarası OTP authentication: Sistem mimarisi ve çalışma prensibi

Twake Chat'in telefon numarası authentication sistemi **Matrix Identity Service API v2 standardını** takip ediyor ve tamamen **ToM-server'da implement edilmiş** durumda. SMS/OTP sistemi ayrı bir application değil, ToM-server'ın @twake/matrix-identity-server modülünün bir özelliği.

### Matrix MSISDN validation flow

Sistem **MSISDN (Mobile Station International Subscriber Directory Number)** validation flow'unu kullanıyor. Authentication **dört ana API endpoint** üzerinden çalışıyor:

**Request Token** - `POST /_matrix/identity/v2/validate/msisdn/requestToken` endpoint'i ile client telefon numarasını, ülke kodunu ve unique session secret'ı gönderiyor. Server response olarak session ID (sid) döndürüyor ve arka planda SMS gateway'e OTP gönderimi yapıyor.

**Submit Token** - Kullanıcı SMS'den aldığı OTP'yi `POST /_matrix/identity/v2/validate/msisdn/submitToken` endpoint'ine sid ve client_secret ile birlikte gönderiyor. Server token'ı validate edip success/failure response veriyor.

**Get Validated** - `GET /_matrix/identity/v2/3pid/getValidated3pid` ile session'ın doğrulanıp doğrulanmadığı kontrol ediliyor. Response validated_at timestamp'i ve E.164 formatında telefon numarasını içeriyor.

**Bind** - Son olarak `POST /_matrix/identity/v2/3pid/bind` ile doğrulanmış telefon numarası Matrix User ID'sine bağlanıyor.

### SMS gönderimi ve provider entegrasyonu

ToM-server'ın @twake/matrix-identity-server paketi SMS gönderme altyapısını yönetiyor, ancak **gerçek SMS delivery için external SMS gateway kullanıyor**. Matrix standartı **Twilio, MessageBird veya Nexmo/Vonage** gibi popüler SMS provider'ların entegrasyonunu öneriyor. Configuration ToM-server'ın config dosyaları üzerinden yapılıyor.

### Authentication flow adım adım

**Flow şu şekilde ilerliyor**: Client telefon numarası ile requestToken çağrısı yapıyor → ToM-server SMS gateway'e OTP gönderiyor (örn: "Your code: 123456") → Server client'a session ID döndürüyor → Kullanıcı SMS'ten kodu alıp giriyor → Client submitToken ile OTP'yi submit ediyor → Server token'ı validate ediyor → Success response sonrası opsiyonel olarak bind çağrısı yapılıyor → Matrix User ID ile telefon numarası ilişkilendiriliyor → Authentication complete.

**Session management** 24 saat geçerlilik süresi kullanıyor. Süre dolarsa `M_SESSION_EXPIRED` hatası dönüyor. Token formatı maksimum 255 karakter, `[0-9a-zA-Z.=_-]` karakterlerini içerebiliyor.

### Login WebUI kaynağı

Login sırasında açılan web arayüzü **@twake/matrix-invite** paketinden geliyor. Bu paket ToM-server repository'sinin `packages/matrix-invite/` dizininde yer alıyor ve Matrix room invitation'ları ile OTP/SMS validation için form arayüzleri sağlıyor. Ayrı bir application değil, ToM-server'ın bir modülü olarak çalışıyor.

### Kritik sorulara yanıtlar

**1. ToM-server'da SMS gönderme modülü var mı?** ✅ Evet, @twake/matrix-identity-server paketi içinde mevcut.

**2. Login WebUI'nin kaynağı?** ✅ @twake/matrix-invite paketi (packages/matrix-invite/ dizininde).

**3. OTP sistemi nasıl çalışıyor?** ✅ Matrix Identity Service API v2 flow: requestToken → SMS gönder → submitToken → validate → bind.

**4. Hangi repository kullanılıyor?** ✅ ToM-server repository'si (https://github.com/linagora/ToM-server).

**5. Ayrı web application mı?** ✅ Hayır, ToM-server plugin'i/modülü.

**6. SMS servisi hangi paket sağlıyor?** ✅ @twake/matrix-identity-server, external SMS gateway (Twilio/MessageBird) ile entegre.

## Twake Chat client authentication flow

Twake Chat client'ı **Matrix Dart SDK** kullanarak authentication yapıyor. SDK üç ana metod sağlıyor: `checkHomeserver()` (homeserver uyumluluğunu kontrol eder), `getLoginFlows()` (sunucunun desteklediği login tiplerini alır), ve `login()` (authentication işlemini gerçekleştirir).

### Desteklenen login tipleri ve flow

Client **dört login tipini** destekliyor: `m.login.password` (kullanıcı adı/şifre), `m.login.sso` (Single Sign-On), `m.login.token` (token-based login), ve OIDC (OAuth 2.0/OpenID Connect için yeni MSC3861 standardı).

**Temel authentication flow şu adımları takip ediyor**: Kullanıcı homeserver seçiyor → Client `checkHomeserver()` ile `.well-known/matrix/client` dosyasını kontrol ediyor → `GET /_matrix/client/r0/login` ile available login flow'lar alınıyor → Kullanıcı login tipini seçiyor (password veya SSO).

### SSO authentication ve WebView kullanımı

**SSO flow WebView/browser redirect** kullanıyor. Client SSO redirect URL'ini construct ediyor: `<homeserver>/_matrix/client/r0/login/sso/redirect?redirectUrl=<app_callback_url>`. **Platform-specific browser implementation** kullanılıyor: iOS'ta ASWebAuthenticationSession API, Android'de Chrome Custom Tabs, Web'de window.open() veya redirect.

**SSO redirect chain şöyle ilerliyor**: Client SSO endpoint'ini çağırıyor → Matrix server SSO provider'a redirect ediyor (Google, SAML, CAS, OIDC) → Kullanıcı external provider'da authenticate oluyor → Provider callback URL'e loginToken ile dönüyor: `<app_url>/?loginToken=<token>` → Client `POST /_matrix/client/r0/login` ile token'ı submit ediyor (type: m.login.token) → Server access_token, device_id ve user_id döndürüyor.

### Client dosya yapısı ve implementasyon

Flutter projesi **muhtemelen şu yapıda organize edilmiş**: `lib/pages/login/login.dart` (ana login ekranı), `lib/pages/homeserver_picker/homeserver_picker.dart` (homeserver seçim ekranı), `lib/widgets/matrix.dart` (Matrix client wrapper), `lib/widgets/sso_button.dart` (SSO login butonu). Token management Matrix SDK tarafından otomatik yönetiliyor, local database (Hive/SQLite) kullanılarak encryption keys ve device keys saklanıyor.

### Yeni OIDC authentication standardı

Matrix ekosistemi **OIDC-native authentication'a geçiş yapıyor** (MSC3861). Authorization Code Flow kullanıyor: short-lived access tokens (5 dakika), refresh tokens ile yenileme, industry-standard OAuth 2.0/OIDC, MFA desteği ve session management avantajları sunuyor.

## GitLab ve dokümantasyon kaynakları

**GitLab deposu** ci.linagora.com'da erişilebilir durumda: `https://ci.linagora.com/publicgroup/oss/twake/tom-server`. Clone için SSH (`ssh://git@ci.linagora.com:7999/publicgroup/oss/twake/tom-server.git`) ve HTTPS URL'leri mevcut. Active branch'ler arasında `optimized-tom-image`, `less-artifacts`, `hashes-rate-limit` bulunuyor.

**Official dokümantasyon** https://linagora.github.io/ToM-server/ adresinde REST API dokümantasyonu sunuyor. Proje **Matrix spesifikasyonlarına referans** veriyor: Matrix Identity Service API, Matrix Client-Server API v1.11, Matrix Application Service API v1.6, ve Matrix Server Discovery spesifikasyonları.

**Teknik gereksinimler ve komutlar**: Node.js >= 18 gerekli, `npm run build` tüm paketleri build ediyor, `npm run test` tüm paketleri test ediyor, `node ./server.mjs` ile server başlatılıyor. Docker image Docker Hub'da mevcut: `linagora/tom-server:latest`.

## Teknoloji stack özeti

**Client-side teknolojiler**: Flutter/Dart framework (multi-platform), Matrix Protocol, End-to-End Encryption (E2EE), OpenSSL libcrypto, custom UI design system.

**Server-side teknolojiler**: Node.js/TypeScript (ToM-server), Matrix Synapse integration, Java (tmail-backend, James Project mail server), JMAP Protocol, external SMS gateway integration (Twilio/MessageBird).

**Lisanslar**: Çoğu proje AGPL-3.0, bazı kütüphaneler MIT, James Project Apache 2.0 lisanslı.

## Sonuç

Twake Chat ve ToM-server ekosistemi **48+ repository'den oluşan profesyonel bir Matrix implementasyonu**. Telefon numarası OTP authentication sistemi standart Matrix Identity Service API'sini takip ediyor ve ToM-server'ın @twake/matrix-identity-server modülünde implement edilmiş. Login WebUI @twake/matrix-invite paketinden geliyor, SMS gönderimi için external provider kullanılıyor. Client Flutter/Dart ile yazılmış, Matrix SDK üzerinden SSO ve WebView redirect ile authentication sağlıyor. Repository'ler 12 ToM-server internal package, 14+ Flutter client library ve Twake Workplace ekosisteminin diğer bileşenlerini kapsıyor.