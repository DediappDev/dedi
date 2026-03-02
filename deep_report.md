# Tek Tek Dosya Analizi (Twake, Linagora, Fluffy)

### Dosya: `lib/config/default_permission_level_member.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/config/default_power_level_member.dart`

---

### Dosya: `lib/config/go_routes/go_router.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppRoutes`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_app.dart`

---

### Dosya: `lib/config/themes.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DediThemes`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (17 yer):**
  - `lib/utils/adaptive_bottom_sheet.dart`
  - `lib/pages/bootstrap/bootstrap_dialog.dart`
  - `lib/pages/chat/reply_display.dart`
  - `lib/pages/chat/typing_indicators.dart`
  - `lib/pages/chat/chat_event_list.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/di/global/get_it_initializer.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `GetItInitializer`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (191 yer):**
  - `lib/main.dart`
  - `lib/di/base_di.dart`
  - `lib/di/global/dio_cache_interceptor_for_client.dart`
  - `lib/config/themes.dart`
  - `lib/config/app_config.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/domain/app_state/app_grid/get_app_grid_configuration_state.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `LoadingAppGridConfiguration`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_controller.dart`
  - `lib/domain/usecase/app_grid/get_app_grid_configuration_interactor.dart`

---

### Dosya: `lib/domain/contact_manager/contacts_manager.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsManager`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/pages/search/search_contacts_and_chats_controller.dart`
  - `lib/presentation/mixins/address_book_mixin.dart`
  - `lib/presentation/mixins/contacts_view_controller_mixin.dart`
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/domain/exception/contacts/twake_lookup_exceptions.dart`
- **Ne İşe Yarar:** Hata Sınıfı - Özel hata durumlarını (try-catch) yönetmek için.
- **Sınıf Adı:** `DediLookupChunkException`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/domain/usecase/contacts/twake_look_up_phonebook_contact_interactor.dart`
  - `lib/domain/usecase/contacts/federation_look_up_phonebook_contact_interactor.dart`

---

### Dosya: `lib/domain/model/app_grid/app_grid_configuration_parser.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `AppGridConfigurationParser`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/domain/usecase/app_grid/get_app_grid_configuration_interactor.dart`

---

### Dosya: `lib/domain/model/app_grid/linagora_app.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `DediApp`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_item.dart`
  - `lib/domain/model/app_grid/linagora_app.g.dart`
  - `lib/domain/model/app_grid/linagora_applications.dart`
  - `lib/domain/model/extensions/linagora_app_extensions.dart`

---

### Dosya: `lib/domain/model/app_grid/linagora_app.g.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/domain/model/app_grid/linagora_app.dart`

---

### Dosya: `lib/domain/model/app_grid/linagora_applications.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `DediApplications`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (7 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_overlay.dart`
  - `lib/pages/app_grid/app_grid_dashboard_overlay_style.dart`
  - `lib/pages/app_grid/app_grid_dashboard_controller.dart`
  - `lib/domain/app_state/app_grid/get_app_grid_configuration_state.dart`
  - `lib/domain/model/app_grid/linagora_applications.g.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/domain/model/app_grid/linagora_applications.g.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/domain/model/app_grid/linagora_applications.dart`

---

### Dosya: `lib/domain/model/app_twake_information.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `AppDediInformation`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/domain/model/app_twake_information.g.dart`
  - `lib/domain/model/extensions/homeserver_summary_extensions.dart`

---

### Dosya: `lib/domain/model/app_twake_information.g.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/domain/model/app_twake_information.dart`

---

### Dosya: `lib/domain/model/chat/message_report_reason.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat.dart`

---

### Dosya: `lib/domain/model/extensions/homeserver_summary_extensions.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_redirection_edit_button.dart`
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/domain/model/extensions/linagora_app_extensions.dart`
- **Ne İşe Yarar:** Veri Modeli - Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_item.dart`

---

### Dosya: `lib/domain/usecase/app_grid/get_app_grid_configuration_interactor.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `GetAppGridConfigurationInteractor`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/pages/app_grid/app_grid_dashboard_controller.dart`

---

### Dosya: `lib/domain/usecase/contacts/federation_look_up_argument.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `FederationLookUpArgument`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/domain/contact_manager/contacts_manager.dart`
  - `lib/domain/usecase/contacts/federation_look_up_phonebook_contact_interactor.dart`

---

### Dosya: `lib/domain/usecase/contacts/federation_look_up_phonebook_contact_interactor.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `FederationLookUpPhonebookContactInteractor`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/domain/contact_manager/contacts_manager.dart`

---

### Dosya: `lib/domain/usecase/contacts/twake_look_up_argument.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `DediLookUpArgument`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/domain/contact_manager/contacts_manager.dart`
  - `lib/domain/usecase/contacts/twake_look_up_phonebook_contact_interactor.dart`
  - `lib/domain/usecase/contacts/federation_look_up_argument.dart`

---

### Dosya: `lib/domain/usecase/contacts/twake_look_up_phonebook_contact_interactor.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `DediLookupPhonebookContactInteractor`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/domain/contact_manager/contacts_manager.dart`

---

### Dosya: `lib/domain/usecase/forward/forward_message_interactor.dart`
- **Ne İşe Yarar:** İş Mantığı (Usecase/Interactor) - Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı.
- **Sınıf Adı:** `ForwardMessageInteractor`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/pages/forward/forward.dart`

---

### Dosya: `lib/event/twake_event_dispatcher.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DediEventDispatcher`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/di/global/get_it_initializer.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`

---

### Dosya: `lib/event/twake_event_messages.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DediEventMessages`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/presentation/mixins/address_book_mixin.dart`

---

### Dosya: `lib/event/twake_event_types.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DediEventTypes`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat_list/receive_sharing_intent_mixin.dart`
  - `lib/pages/share/share.dart`
  - `lib/domain/usecase/forward/forward_message_interactor.dart`
  - `lib/presentation/mixins/address_book_mixin.dart`
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/event/twake_inapp_event_types.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DediInappEventTypes`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/settings_dashboard/settings/settings.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/widgets/mixins/on_account_data_listen_mixin.dart`
  - `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation.dart`
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body.dart`

---

### Dosya: `lib/pages/add_story/add_story.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AddStoryPage`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/add_story/add_story_view.dart`

---

### Dosya: `lib/pages/add_story/add_story_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AddStoryView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/add_story/add_story.dart`

---

### Dosya: `lib/pages/add_story/invite_story_page.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `InviteStoryPage`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/add_story/add_story.dart`

---

### Dosya: `lib/pages/app_grid/app_grid_dashboard_controller.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppGridDashboard`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_view.dart`
  - `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_appbar.dart`

---

### Dosya: `lib/pages/app_grid/app_grid_dashboard_item.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppGridDashboardItem`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_overlay.dart`

---

### Dosya: `lib/pages/app_grid/app_grid_dashboard_overlay.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppGridDashboardOverlay`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_view.dart`

---

### Dosya: `lib/pages/app_grid/app_grid_dashboard_overlay_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppGridDashboardOverlayStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/app_grid/app_grid_dashboard_overlay.dart`

---

### Dosya: `lib/pages/archive/archive.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Archive`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/archive/archive_view.dart`

---

### Dosya: `lib/pages/archive/archive_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ArchiveView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/archive/archive.dart`

---

### Dosya: `lib/pages/auto_homeserver_picker/auto_homeserver_picker.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AutoHomeserverPicker`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/auto_homeserver_picker/auto_homeserver_picker_view.dart`

---

### Dosya: `lib/pages/auto_homeserver_picker/auto_homeserver_picker_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AutoHomeserverPickerView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/auto_homeserver_picker/auto_homeserver_picker.dart`

---

### Dosya: `lib/pages/bootstrap/bootstrap_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `BootstrapDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/events/encrypted_mixin.dart`
  - `lib/pages/chat_list/chat_list.dart`
  - `lib/pages/settings_dashboard/settings/settings.dart`
  - `lib/pages/settings_dashboard/settings_security/settings_security.dart`

---

### Dosya: `lib/pages/bootstrap/init_client_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `InitClientDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/utils/dialog/twake_dialog.dart`

---

### Dosya: `lib/pages/bootstrap/tom_bootstrap_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `TomBootstrapDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/bootstrap/bootstrap_dialog.dart`
  - `lib/pages/chat_list/chat_list.dart`

---

### Dosya: `lib/pages/bootstrap/tom_bootstrap_dialog_mobile_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `TomBootstrapDialogMobileView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/bootstrap/init_client_dialog.dart`
  - `lib/pages/bootstrap/tom_bootstrap_dialog.dart`

---

### Dosya: `lib/pages/bootstrap/tom_bootstrap_dialog_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `TomBootstrapDialogStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/bootstrap/tom_bootstrap_dialog_mobile_view.dart`
  - `lib/pages/bootstrap/tom_bootstrap_dialog_web_view.dart`
  - `lib/pages/bootstrap/tom_bootstrap_dialog.dart`

---

### Dosya: `lib/pages/bootstrap/tom_bootstrap_dialog_web_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `TomBootstrapDialogWebView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/bootstrap/init_client_dialog.dart`
  - `lib/pages/bootstrap/tom_bootstrap_dialog.dart`

---

### Dosya: `lib/pages/chat/add_widget_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AddWidgetTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/add_widget_tile_view.dart`
  - `lib/pages/chat/edit_widgets_dialog.dart`

---

### Dosya: `lib/pages/chat/blocked_user_banner.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `BlockedUserBanner`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat_view_body.dart`
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat/chat.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Chat`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (12 yer):**
  - `lib/pages/chat/chat_invitation_body.dart`
  - `lib/pages/chat/reply_display.dart`
  - `lib/pages/chat/typing_indicators.dart`
  - `lib/pages/chat/chat_event_list.dart`
  - `lib/pages/chat/chat_input_row.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/pages/chat/chat_actions.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/item_actions_bottom_widget.dart`
  - `lib/pages/chat/chat.dart`
  - `lib/presentation/mixins/send_files_mixin.dart`
  - `lib/presentation/mixins/media_picker_mixin.dart`

---

### Dosya: `lib/pages/chat/chat_actions_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatActionsStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_actions.dart`

---

### Dosya: `lib/pages/chat/chat_app_bar_title_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatAppBarTitleStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/utils/matrix_sdk_extensions/presence_extension.dart`
  - `lib/pages/chat/chat_app_bar_title.dart`
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat/chat_context_menu_actions.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`

---

### Dosya: `lib/pages/chat/chat_input_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatInputRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_view_body.dart`

---

### Dosya: `lib/pages/chat/chat_input_row_mobile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatInputRowMobile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat_draft/draft_chat_input_row.dart`

---

### Dosya: `lib/pages/chat/chat_input_row_send_btn.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatInputRowSendBtn`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat_draft/draft_chat_input_row.dart`

---

### Dosya: `lib/pages/chat/chat_input_row_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatInputRowWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat_draft/draft_chat_input_row.dart`

---

### Dosya: `lib/pages/chat/chat_invitation_body.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatInvitationBody`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_view.dart`

---

### Dosya: `lib/pages/chat/chat_pinned_events/pinned_events_view.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `PinnedEventsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_view_body.dart`

---

### Dosya: `lib/pages/chat/chat_pinned_events/pinned_messages.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `PinnedMessages`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages_screen.dart`

---

### Dosya: `lib/pages/chat/chat_pinned_events/pinned_messages_screen.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `PinnedMessagesScreen`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`

---

### Dosya: `lib/pages/chat/chat_report_message_additional_reason_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatReportMessageAdditionalReasonDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat.dart`

---

### Dosya: `lib/pages/chat/chat_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat.dart`

---

### Dosya: `lib/pages/chat/chat_view_body.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatViewBody`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_view.dart`

---

### Dosya: `lib/pages/chat/chat_view_body_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatViewBodyStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/blocked_user_banner.dart`
  - `lib/pages/chat/chat_view_body.dart`
  - `lib/pages/chat/events/message/message.dart`
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat/disabled_chat_input_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DisabledChatInputRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_view_body.dart`

---

### Dosya: `lib/pages/chat/events/audio_message/audio_player_style.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `AudioPlayerStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/audio_message/audio_player_widget.dart`

---

### Dosya: `lib/pages/chat/events/download_video_widget.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DownloadVideoWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/media/chat_details_media_page.dart`

---

### Dosya: `lib/pages/chat/events/edit_content_style.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `EditContentStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/edit_content.dart`

---

### Dosya: `lib/pages/chat/events/event_video_player.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `EventVideoPlayer`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat/events/message_video_upload_content.dart`
  - `lib/pages/chat/events/message_video_download_content.dart`
  - `lib/pages/chat/events/download_video_widget.dart`
  - `lib/pages/chat/events/message_video_download_content_web.dart`
  - `lib/pages/chat_details/chat_details_page_view/media/chat_details_media_page.dart`

---

### Dosya: `lib/pages/chat/events/images_builder/sending_image_info_widget.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `SendingImageInfoWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/images_builder/message_content_image_builder.dart`

---

### Dosya: `lib/pages/chat/events/message/display_name_widget.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `DisplayNameWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/message/message_content_builder_mixin.dart`
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`

---

### Dosya: `lib/pages/chat/events/message/message.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `Message`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/chat_event_list.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages_screen.dart`
  - `lib/pages/chat/events/message/message_content_builder.dart`
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`

---

### Dosya: `lib/pages/chat/events/message/message_content_builder_mixin.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message/message_content_builder.dart`

---

### Dosya: `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageContentWithTimestampBuilder`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message/message.dart`

---

### Dosya: `lib/pages/chat/events/message/message_context_menu_action.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`

---

### Dosya: `lib/pages/chat/events/message_content.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageContent`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message/message_content_builder.dart`

---

### Dosya: `lib/pages/chat/events/message_download_content_web.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageDownloadContentWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/message_content.dart`
  - `lib/pages/chat_search/chat_search_view.dart`

---

### Dosya: `lib/pages/chat/events/message_reactions.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageReactions`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/utils/matrix_sdk_extensions/event_extension.dart`
  - `lib/pages/chat/events/message_reactions_bottom_sheet.dart`
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`

---

### Dosya: `lib/pages/chat/events/message_reactions_bottom_sheet.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageReactionsBottomSheet`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_reactions.dart`

---

### Dosya: `lib/pages/chat/events/message_time.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageTime`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/message/message_content_builder.dart`
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`

---

### Dosya: `lib/pages/chat/events/message_time_style.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageTimeStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat/seen_by_row.dart`
  - `lib/pages/chat/events/message_time.dart`
  - `lib/pages/chat/events/message/message_content_builder_mixin.dart`

---

### Dosya: `lib/pages/chat/events/message_video_download_content.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageVideoDownloadContent`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_content.dart`

---

### Dosya: `lib/pages/chat/events/message_video_download_content_web.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageVideoDownloadContentWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_content.dart`

---

### Dosya: `lib/pages/chat/events/message_video_upload_content.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `MessageVideoUploadContentWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_content.dart`

---

### Dosya: `lib/pages/chat/events/reply_content_style.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `ReplyContentStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/reply_content.dart`
  - `lib/pages/chat/events/message/reply_content_widget.dart`

---

### Dosya: `lib/pages/chat/events/sending_video_widget.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `SendingVideoWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_content.dart`

---

### Dosya: `lib/pages/chat/events/state_message.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `StateMessage`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message/message.dart`

---

### Dosya: `lib/pages/chat/group_chat_empty_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `GroupChatEmptyView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat_event_list.dart`

---

### Dosya: `lib/pages/chat/input_bar/input_bar.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `InputBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat/send_file_dialog/send_file_dialog_view.dart`
  - `lib/pages/chat_draft/draft_chat_input_row.dart`
  - `lib/presentation/mixins/media_picker_mixin.dart`

---

### Dosya: `lib/pages/chat/others_group_chat_empty_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `OthersGroupChatEmptyView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/group_chat_empty_view.dart`

---

### Dosya: `lib/pages/chat/send_file_dialog/hover_actions_widget.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SendFileDialogActionsWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/send_file_dialog/files_listview_widget.dart`

---

### Dosya: `lib/pages/chat/send_file_dialog/media_page_view_widget.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MediaPageViewWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/send_file_dialog/send_file_dialog_view.dart`

---

### Dosya: `lib/pages/chat/send_file_dialog/send_file_dialog_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SendFileDialogStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat/send_file_dialog/send_file_dialog_view.dart`
  - `lib/pages/chat/send_file_dialog/files_listview_widget.dart`
  - `lib/pages/chat/send_file_dialog/media_page_view_widget.dart`
  - `lib/pages/chat/send_file_dialog/hover_actions_widget.dart`
  - `lib/presentation/mixins/media_picker_mixin.dart`

---

### Dosya: `lib/pages/chat/sticky_timestamp_widget.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `StickyTimestampWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat_view_body.dart`
  - `lib/pages/chat/events/message/message.dart`

---

### Dosya: `lib/pages/chat_blank/chat_blank.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatBlank`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/config/go_routes/go_router.dart`

---

### Dosya: `lib/pages/chat_blank/chat_blank_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatBlankStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_blank/chat_blank.dart`

---

### Dosya: `lib/pages/chat_blank/chat_qr_code.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatQrCode`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_blank/chat_blank.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles/assign_roles.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRoles`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details_edit.dart`
  - `lib/pages/chat_details/assign_roles/assign_roles_view.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles/assign_roles_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/assign_roles/assign_roles.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesMemberPicker`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/assign_roles/assign_roles.dart`
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_view.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesMemberPickerStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/assign_roles/assign_roles.dart`
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_view.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesMemberPickerView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesRolePicker`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker_view.dart`
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AssignRolesRolePickerView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker.dart`

---

### Dosya: `lib/pages/chat_details/assign_roles_role_picker/quick_role_picker_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/assign_roles/assign_roles.dart`
  - `lib/pages/chat_details/exceptions/exceptions.dart`

---

### Dosya: `lib/pages/chat_details/chat_details.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetails`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details_view.dart`
  - `lib/pages/chat_details/chat_details_navigator.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_actions_button.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsActionsButton`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_header_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_edit.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsEdit`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat_details/chat_details_navigator.dart`
  - `lib/pages/chat_details/chat_details.dart`
  - `lib/pages/chat_details/chat_details_edit_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_edit_option.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsEditOption`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_edit_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_edit_option_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsEditOptionStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_edit_option.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_edit_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsEditView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_edit.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFileTileStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (10 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_tile/chat_details_file_downloading_tile.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_tile/chat_details_file_row_web.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_downloading_tile.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_row_wrapper.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_row_web.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFilesView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFileItemWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_page.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_view_web.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_download_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsDownloadFileTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_downloaded_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsDownloadedFileTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_downloading_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsDownloadingFileTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_view.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_row_downloading_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFileTileRowDownloadingWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_view_web.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_row_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFileTileRowWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_view_web.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/links/chat_details_links_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsLinksStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/links/chat_details_links_item.dart`

---

### Dosya: `lib/pages/chat_details/chat_details_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details.dart`

---

### Dosya: `lib/pages/chat_details/exceptions/exceptions.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Exceptions`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details_edit.dart`
  - `lib/pages/chat_details/exceptions/exceptions_view.dart`

---

### Dosya: `lib/pages/chat_details/exceptions/exceptions_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ExceptionsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/exceptions/exceptions.dart`

---

### Dosya: `lib/pages/chat_details/participant_list_item/participant_list_item.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ParticipantListItem`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/chat_details_page_view/chat_details_members_page.dart`

---

### Dosya: `lib/pages/chat_details/removed/removed.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Removed`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details_edit.dart`
  - `lib/pages/chat_details/removed/removed_view.dart`

---

### Dosya: `lib/pages/chat_details/removed/removed_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `RemovedView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/removed/removed.dart`

---

### Dosya: `lib/pages/chat_draft/draft_chat.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DraftChat`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat_draft/draft_chat_input_row.dart`
  - `lib/pages/chat_draft/draft_chat_adaptive_scaffold.dart`
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat_draft/draft_chat_empty_widget_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DraftChatEmptyWidgetStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_draft/draft_chat_empty_widget.dart`

---

### Dosya: `lib/pages/chat_draft/draft_chat_input_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DraftChatInputRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat_draft/draft_chat_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DraftChatView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_draft/draft_chat.dart`

---

### Dosya: `lib/pages/chat_draft/draft_chat_view_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DraftChatViewStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_draft/draft_chat_input_row.dart`
  - `lib/pages/chat_draft/draft_chat_view.dart`

---

### Dosya: `lib/pages/chat_encryption_settings/chat_encryption_settings.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatEncryptionSettings`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/chat_encryption_settings/chat_encryption_settings_view.dart`

---

### Dosya: `lib/pages/chat_list/chat_list.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (9 yer):**
  - `lib/utils/voip_plugin.dart`
  - `lib/pages/chat_list/chat_list_view.dart`
  - `lib/pages/chat_list/space_view.dart`
  - `lib/pages/chat_list/common_chat_list_item.dart`
  - `lib/pages/chat_list/chat_list_header.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/pages/chat_list/chat_list_body_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListBodyView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_list/chat_list_view.dart`
  - `lib/widgets/sliver_expandable_list.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_header.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListHeader`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_list/chat_list_view.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_header_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListHeaderStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (8 yer):**
  - `lib/pages/bootstrap/tom_bootstrap_dialog_mobile_view.dart`
  - `lib/pages/chat_list/chat_list_header.dart`
  - `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_users_view.dart`
  - `lib/pages/chat_details/assign_roles/assign_roles_view.dart`
  - `lib/pages/chat_details/exceptions/exceptions_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/pages/chat_list/chat_list_item.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListItem`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/archive/archive_view.dart`
  - `lib/pages/chat_list/space_view.dart`
  - `lib/pages/chat_list/common_chat_list_item.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_item_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListItemStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat_list/chat_list_item_title.dart`
  - `lib/pages/chat_list/chat_list_item.dart`
  - `lib/pages/chat_list/chat_list_item_subtitle.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_item_subtitle.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListItemSubtitle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_list/chat_list_item.dart`
  - `lib/pages/forward/recent_chat_list.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_item_title.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListItemTitle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat_list/chat_list_item.dart`
  - `lib/pages/search/server_search_view.dart`
  - `lib/pages/forward/recent_chat_list.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_list/chat_list.dart`

---

### Dosya: `lib/pages/chat_list/chat_list_view_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListViewStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat_list/chat_list_view.dart`
  - `lib/pages/chat_list/chat_list.dart`
  - `lib/pages/chat_list/chat_list_view_builder.dart`
  - `lib/pages/chat_list/chat_custom_slidable_action.dart`
  - `lib/pages/chat_list/slidable_chat_list_item.dart`

---

### Dosya: `lib/pages/chat_list/receive_sharing_intent_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/pages/chat_list/space_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SpaceView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_list/chat_list_body_view.dart`

---

### Dosya: `lib/pages/chat_permissions_settings/chat_permissions_settings.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatPermissionsSettings`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_permissions_settings/chat_permissions_settings_view.dart`

---

### Dosya: `lib/pages/chat_profile_info/chat_profile_info.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatProfileInfo`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_profile_info/chat_profile_info_navigator.dart`
  - `lib/pages/chat_profile_info/chat_profile_info_view.dart`

---

### Dosya: `lib/pages/chat_profile_info/chat_profile_info_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatProfileInfoStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/profile_info/copiable_profile_row/svg_copiable_profile_row.dart`
  - `lib/pages/profile_info/copiable_profile_row/copiable_profile_row.dart`
  - `lib/pages/profile_info/copiable_profile_row/icon_copiable_profile_row.dart`
  - `lib/pages/chat_profile_info/chat_profile_info_view.dart`

---

### Dosya: `lib/pages/chat_profile_info/chat_profile_info_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatProfileInfoView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_profile_info/chat_profile_info.dart`

---

### Dosya: `lib/pages/chat_search/chat_search_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatSearchView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_search/chat_search.dart`

---

### Dosya: `lib/pages/connect/connect_page_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ConnectPageView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/connect/connect_page.dart`

---

### Dosya: `lib/pages/contacts_tab/contacts_appbar.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsAppBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/contacts_tab/contacts_tab_view.dart`

---

### Dosya: `lib/pages/contacts_tab/contacts_invitation.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsInvitation`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/contacts_tab/contacts_invitation_view.dart`
  - `lib/pages/new_private_chat/widget/expansion_contact_list_tile.dart`
  - `lib/pages/new_private_chat/widget/expansion_phonebook_contact_list_tile.dart`

---

### Dosya: `lib/pages/contacts_tab/contacts_invitation_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsInvitationView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/contacts_tab/contacts_invitation.dart`

---

### Dosya: `lib/pages/contacts_tab/contacts_tab_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsTabView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/contacts_tab/contacts_tab.dart`

---

### Dosya: `lib/pages/contacts_tab/empty_contacts_body.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `EmptyContactBody`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`

---

### Dosya: `lib/pages/device_settings/device_settings.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DevicesSettings`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/device_settings/device_settings_view.dart`

---

### Dosya: `lib/pages/device_settings/device_settings_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DevicesSettingsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/device_settings/device_settings.dart`

---

### Dosya: `lib/pages/error_page/error_page_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ErrorPageStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/error_page/error_page.dart`

---

### Dosya: `lib/pages/forward/forward_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ForwardView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/forward/forward.dart`

---

### Dosya: `lib/pages/forward/recent_chat_list.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `RecentChatList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/forward/forward_view.dart`
  - `lib/pages/share/share_view.dart`

---

### Dosya: `lib/pages/forward/recent_chat_title.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `RecentChatsTitle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/forward/forward_view.dart`
  - `lib/pages/share/share_view.dart`

---

### Dosya: `lib/pages/homeserver_picker/homeserver_picker.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `HomeserverPicker`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/homeserver_picker/homeserver_app_bar.dart`
  - `lib/pages/homeserver_picker/homeserver_picker_view.dart`

---

### Dosya: `lib/pages/homeserver_picker/homeserver_picker_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `HomeserverPickerView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/homeserver_picker/homeserver_picker.dart`

---

### Dosya: `lib/pages/image_viewer/media_viewer_app_bar.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MediaViewerAppBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat/events/download_video_widget.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar_web.dart`
  - `lib/pages/image_viewer/image_viewer_view.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar_view.dart`
  - `lib/widgets/video_viewer_mobile_theme.dart`

---

### Dosya: `lib/pages/image_viewer/media_viewer_app_bar_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MediaViewewAppbarStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/image_viewer/media_viewer_app_bar_web.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar_view.dart`

---

### Dosya: `lib/pages/image_viewer/media_viewer_app_bar_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MediaViewerAppbarView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/image_viewer/media_viewer_app_bar.dart`

---

### Dosya: `lib/pages/image_viewer/media_viewer_app_bar_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MediaViewerAppBarWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/download_video_widget.dart`
  - `lib/widgets/video_viewer_desktop_theme.dart`

---

### Dosya: `lib/pages/invitation_selection/invitation_selection.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `InvitationSelection`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/invitation_selection/invitation_selection_web.dart`
  - `lib/presentation/mixins/chat_details_tab_mixin.dart`

---

### Dosya: `lib/pages/key_verification/key_verification_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `KeyVerificationDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/bootstrap/bootstrap_dialog.dart`
  - `lib/pages/device_settings/device_settings.dart`

---

### Dosya: `lib/pages/login/login.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Login`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/login/login_view.dart`

---

### Dosya: `lib/pages/login/on_auth_redirect.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `OnAuthRedirect`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/config/go_routes/go_router.dart`

---

### Dosya: `lib/pages/multiple_accounts/multiple_accounts_picker.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MultipleAccountsPickerController`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`

---

### Dosya: `lib/pages/new_group/contacts_selection_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactsSelectionView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/invitation_selection/invitation_selection.dart`
  - `lib/pages/new_group/contacts_selection.dart`

---

### Dosya: `lib/pages/new_group/new_group_chat_info.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `NewGroupChatInfo`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/config/first_column_inner_routes.dart`
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/new_group/new_group_chat_info_view.dart`
  - `lib/pages/new_group/new_group_info_controller.dart`

---

### Dosya: `lib/pages/new_group/new_group_chat_info_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `NewGroupChatInfoView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/new_group/new_group_chat_info.dart`

---

### Dosya: `lib/pages/new_group/widget/expansion_participants_list.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ExpansionParticipantsList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/new_group/new_group_chat_info_view.dart`

---

### Dosya: `lib/pages/new_group/widget/selected_participants_list.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SelectedParticipantsList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/new_group/contacts_selection_view.dart`

---

### Dosya: `lib/pages/new_private_chat/new_private_chat_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `NewPrivateChatView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/new_private_chat/new_private_chat.dart`

---

### Dosya: `lib/pages/new_private_chat/widget/contact_status_widget.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ContactStatusWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/new_private_chat/widget/expansion_contact_list_tile.dart`
  - `lib/pages/new_private_chat/widget/expansion_phonebook_contact_list_tile.dart`

---

### Dosya: `lib/pages/new_private_chat/widget/expansion_contact_list_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ExpansionContactListTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`
  - `lib/pages/search/search_external_contact.dart`
  - `lib/pages/new_private_chat/widget/expansion_list.dart`
  - `lib/pages/new_group/widget/expansion_participants_list.dart`
  - `lib/pages/new_group/widget/contact_item.dart`

---

### Dosya: `lib/pages/new_private_chat/widget/expansion_list.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ExpansionList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/new_private_chat/new_private_chat_view.dart`

---

### Dosya: `lib/pages/new_private_chat/widget/expansion_phonebook_contact_list_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ExpansionPhonebookContactListTile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`

---

### Dosya: `lib/pages/profile_info/copiable_profile_row/copiable_profile_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `CopiableProfileRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/profile_info/copiable_profile_row/svg_copiable_profile_row.dart`
  - `lib/pages/profile_info/copiable_profile_row/icon_copiable_profile_row.dart`

---

### Dosya: `lib/pages/profile_info/copiable_profile_row/icon_copiable_profile_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `IconCopiableProfileRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_body/profile_info_contact_rows.dart`

---

### Dosya: `lib/pages/profile_info/copiable_profile_row/svg_copiable_profile_row.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SvgCopiableProfileRow`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_body/profile_info_contact_rows.dart`

---

### Dosya: `lib/pages/profile_info/profile_info_body/profile_info_body.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ProfileInfoBody`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/utils/user_extension.dart`
  - `lib/pages/profile_info/profile_info_view.dart`
  - `lib/pages/profile_info/profile_info_body/profile_info_body_view.dart`

---

### Dosya: `lib/pages/profile_info/profile_info_body/profile_info_header.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ProfileInfoHeader`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_body/profile_info_body_view.dart`

---

### Dosya: `lib/pages/profile_info/profile_info_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ProfileInfoView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_page.dart`

---

### Dosya: `lib/pages/search/recent_item_widget.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `RecentItemWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`
  - `lib/pages/search/search_view.dart`
  - `lib/pages/new_private_chat/widget/expansion_list.dart`

---

### Dosya: `lib/pages/search/search.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Search`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/config/first_column_inner_routes.dart`
  - `lib/pages/chat_list/chat_list_header.dart`
  - `lib/pages/search/search_external_contact.dart`
  - `lib/pages/search/search_view.dart`
  - `lib/pages/search/server_search_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/pages/search/search_text_field.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SearchTextField`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/contacts_tab/contacts_appbar.dart`
  - `lib/pages/search/search_view.dart`

---

### Dosya: `lib/pages/search/search_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SearchView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/search/search.dart`

---

### Dosya: `lib/pages/search/search_view_style.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SearchViewStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/search/search_view.dart`
  - `lib/pages/search/search_text_field.dart`

---

### Dosya: `lib/pages/search/server_search_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ServerSearchMessagesList`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/search/search_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings/settings.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Settings`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings/settings_view.dart`
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings/settings_item_builder.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsItemBuilder`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings/settings_view.dart`
  - `lib/pages/settings_dashboard/settings_security/settings_security_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings/settings_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings/settings.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_3pid/settings_3pid.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Settings3Pid`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_3pid/settings_3pid_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_3pid/settings_3pid_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Settings3PidView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_3pid/settings_3pid.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_app_language/settings_app_language_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsAppLanguageView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_app_language/settings_app_language.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_user.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `BlockedUsers`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_users_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_users_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsBlockedUsersView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_user.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_chat/settings_chat_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsChatView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_chat/settings_chat.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_emotes/settings_emotes.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `EmotesSettings`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_emotes/settings_emotes_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_emotes/settings_emotes_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `EmotesSettingsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_emotes/settings_emotes.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_multiple_emotes/settings_multiple_emotes_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `MultipleEmotesSettingsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_multiple_emotes/settings_multiple_emotes.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_notifications/settings_notifications.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `NotificationSettingsItem`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_notifications/settings_notifications_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_notifications/settings_notifications_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsNotificationsView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_notifications/settings_notifications.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_item.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfileItemBuilder`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_redirection_edit_button.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfileRedirectionEditButton`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_state/get_clients_ui_state.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `GetClientsInitialUIState`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view_mobile.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfileView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_view_mobile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfileViewMobile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_profile/settings_profile_view_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsProfileViewWeb`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_security/settings_security.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsSecurity`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/chat_list/chat_list.dart`
  - `lib/pages/settings_dashboard/settings_security/settings_security_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_security/settings_security_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsSecurityView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_security/settings_security.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_stories/settings_stories.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsStories`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/settings_dashboard/settings_stories/settings_stories_view.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_stories/settings_stories_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsStoriesView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_stories/settings_stories.dart`

---

### Dosya: `lib/pages/settings_dashboard/settings_style/settings_style_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `SettingsStyleView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_style/settings_style.dart`

---

### Dosya: `lib/pages/share/share.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `Share`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_list/receive_sharing_intent_mixin.dart`
  - `lib/pages/share/share_view.dart`

---

### Dosya: `lib/pages/share/share_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ShareView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/share/share.dart`

---

### Dosya: `lib/pages/story/story_page.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `StoryPage`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/story/story_view.dart`

---

### Dosya: `lib/pages/twake_welcome/twake_welcome.dart`
- **Ne İşe Yarar:** UI Sayfası (Eski Twake Giriş Ekranı) - Twake'in orijinal giriş (login/welcome) ekranı.
- **Sınıf Adı:** `DediWelcomeArg`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/twake_welcome/twake_welcome_view.dart`

---

### Dosya: `lib/pages/twake_welcome/twake_welcome_view.dart`
- **Ne İşe Yarar:** UI Sayfası (Eski Twake Giriş Ekranı) - Twake'in orijinal giriş (login/welcome) ekranı.
- **Sınıf Adı:** `DediWelcomeView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/twake_welcome/twake_welcome.dart`

---

### Dosya: `lib/presentation/decorators/chat_list/subtitle_text_style_decorator/subtitle_text_style_decorator.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListSubtitleTextStyleDecorator`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/presentation/decorators/chat_list/subtitle_text_style_decorator/subtitle_text_style_view.dart`

---

### Dosya: `lib/presentation/decorators/chat_list/title_text_style_decorator/title_text_style_decorator.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatListTitleTextStyleDecorator`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/presentation/decorators/chat_list/title_text_style_decorator/title_text_style_view.dart`

---

### Dosya: `lib/presentation/enum/profile_info/profile_info_body_enum.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_body/profile_info_body.dart`

---

### Dosya: `lib/presentation/enum/settings/settings_enum.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings/settings_view.dart`
  - `lib/pages/settings_dashboard/settings/settings.dart`

---

### Dosya: `lib/presentation/extensions/multiple_accounts/client_profile_extension.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`

---

### Dosya: `lib/presentation/mixins/address_book_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/contacts_tab/contacts_tab.dart`
  - `lib/pages/new_private_chat/new_private_chat.dart`
  - `lib/pages/new_group/contacts_selection.dart`

---

### Dosya: `lib/presentation/mixins/audio_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat/chat_view.dart`
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/events/audio_message/audio_player_widget.dart`
  - `lib/pages/chat_draft/draft_chat_input_row.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/presentation/mixins/chat_details_tab_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat_details/chat_details.dart`
  - `lib/pages/chat_profile_info/chat_profile_info.dart`

---

### Dosya: `lib/presentation/mixins/chat_list_item_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat_list/chat_list_item_title.dart`
  - `lib/pages/chat_list/chat_list_item.dart`
  - `lib/pages/chat_list/chat_list_item_subtitle.dart`

---

### Dosya: `lib/presentation/mixins/connect_page_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (7 yer):**
  - `lib/pages/settings_dashboard/settings/settings.dart`
  - `lib/pages/twake_welcome/twake_welcome.dart`
  - `lib/pages/homeserver_picker/homeserver_picker.dart`
  - `lib/pages/connect/connect_page.dart`
  - `lib/pages/auto_homeserver_picker/auto_homeserver_picker.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/presentation/mixins/delete_event_mixin.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`

---

### Dosya: `lib/presentation/mixins/go_to_direct_chat_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/utils/url_launcher.dart`
  - `lib/pages/chat/chat.dart`
  - `lib/pages/new_private_chat/new_private_chat.dart`

---

### Dosya: `lib/presentation/mixins/invite_external_contact_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/new_private_chat/new_private_chat.dart`
  - `lib/pages/new_group/contacts_selection.dart`

---

### Dosya: `lib/presentation/mixins/leave_chat_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat_details/chat_details_edit.dart`

---

### Dosya: `lib/presentation/mixins/linkify_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/html_message.dart`
  - `lib/widgets/twake_components/twake_preview_link/twake_link_preview.dart`

---

### Dosya: `lib/presentation/mixins/media_picker_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat_draft/draft_chat.dart`

---

### Dosya: `lib/presentation/mixins/paste_image_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/input_bar/input_bar.dart`
  - `lib/presentation/mixins/handle_clipboard_action_mixin.dart`

---

### Dosya: `lib/presentation/mixins/pick_avatar_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/pages/chat_details/chat_details_edit.dart`
  - `lib/pages/new_group/new_group_chat_info.dart`

---

### Dosya: `lib/presentation/mixins/save_file_to_twake_downloads_folder_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar_web.dart`
  - `lib/presentation/mixins/save_media_to_gallery_android_mixin.dart`

---

### Dosya: `lib/presentation/mixins/save_media_to_gallery_android_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar.dart`
  - `lib/pages/image_viewer/media_viewer_app_bar_web.dart`
  - `lib/presentation/mixins/media_viewer_app_bar_mixin.dart`

---

### Dosya: `lib/presentation/mixins/send_files_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat_draft/draft_chat.dart`
  - `lib/pages/share/share.dart`

---

### Dosya: `lib/presentation/mixins/send_files_with_caption_web_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/chat.dart`

---

### Dosya: `lib/presentation/mixins/single_image_picker_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/pages/chat_details/chat_details_edit.dart`
  - `lib/pages/new_group/new_group_chat_info.dart`

---

### Dosya: `lib/presentation/mixins/unblock_user_mixin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat_draft/draft_chat.dart`

---

### Dosya: `lib/presentation/multiple_account/twake_chat_presentation_account.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DediChatPresentationAccount`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/multiple_accounts/multiple_accounts_picker.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view_mobile.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_state/get_clients_ui_state.dart`
  - `lib/presentation/extensions/multiple_accounts/client_profile_extension.dart`

---

### Dosya: `lib/presentation/same_type_events_builder/same_type_events_builder.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `SameTypeEventsBuilder`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat_details/chat_details_page_view/links/chat_details_links_page.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_page.dart`
  - `lib/pages/chat_details/chat_details_page_view/media/chat_details_media_page.dart`
  - `lib/pages/chat_search/chat_search_view.dart`

---

### Dosya: `lib/resource/image_paths.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ImagePaths`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (51 yer):**
  - `lib/config/default_permission_level_member.dart`
  - `lib/utils/extension/mime_type_extension.dart`
  - `lib/utils/dialog/twake_dialog.dart`
  - `lib/pages/splash/splash.dart`
  - `lib/pages/contacts_tab/empty_contacts_body.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/dialog/twake_dialog.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DediDialog`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (54 yer):**
  - `lib/utils/url_launcher.dart`
  - `lib/utils/matrix_sdk_extensions/event_extension.dart`
  - `lib/pages/contacts_tab/contacts_invitation.dart`
  - `lib/pages/bootstrap/bootstrap_dialog.dart`
  - `lib/pages/bootstrap/tom_bootstrap_dialog.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/matrix_sdk_extensions/event_extension.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (39 yer):**
  - `lib/pages/chat/others_group_chat_empty_view.dart`
  - `lib/pages/chat/chat_context_menu_actions.dart`
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_events_view.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/matrix_sdk_extensions/matrix_file_extension.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DediAudioFile`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (16 yer):**
  - `lib/utils/matrix_sdk_extensions/event_extension.dart`
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/send_file_dialog/files_listview_widget.dart`
  - `lib/pages/chat/send_file_dialog/send_file_dialog.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/matrix_sdk_extensions/presence_extension.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/profile_info/profile_info_body/profile_info_header.dart`

---

### Dosya: `lib/utils/permission_service.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `PermissionHandlerService`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/presentation/mixins/media_picker_mixin.dart`
  - `lib/presentation/mixins/common_media_picker_mixin.dart`
  - `lib/presentation/mixins/contacts_view_controller_mixin.dart`
  - `lib/presentation/mixins/save_media_to_gallery_android_mixin.dart`
  - `lib/presentation/mixins/save_file_to_twake_downloads_folder_mixin.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/platform_infos.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `PlatformInfos`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (114 yer):**
  - `lib/main.dart`
  - `lib/config/first_column_inner_routes.dart`
  - `lib/config/go_routes/go_router.dart`
  - `lib/utils/interactive_viewer_gallery.dart`
  - `lib/utils/permission_dialog.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/twake_snackbar.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `DediSnackBarStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (46 yer):**
  - `lib/utils/url_launcher.dart`
  - `lib/utils/voip_plugin.dart`
  - `lib/utils/matrix_sdk_extensions/matrix_file_extension.dart`
  - `lib/utils/matrix_sdk_extensions/event_extension.dart`
  - `lib/pages/contacts_tab/contacts_invitation.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/uia_request_manager.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `UiaException`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/utils/localized_exception_extension.dart`
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/utils/url_launcher.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `UrlLauncher`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (19 yer):**
  - `lib/utils/uia_request_manager.dart`
  - `lib/utils/platform_infos.dart`
  - `lib/pages/app_grid/app_grid_dashboard_view.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_events_view.dart`
  - `lib/pages/chat/events/message_content.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/user_extension.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/pages/chat_details/assign_roles/assign_roles_view.dart`
  - `lib/pages/chat_details/exceptions/exceptions_view.dart`
  - `lib/pages/chat_details/participant_list_item/participant_list_item.dart`
  - `lib/pages/chat_details/removed/removed_view.dart`
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/utils/voip_plugin.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `VoipPlugin`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/utils/voip/callkeep_manager.dart`
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/widgets/app_bars/searchable_app_bar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `SearchableAppBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/new_private_chat/new_private_chat_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`
  - `lib/pages/forward/forward_view.dart`
  - `lib/pages/share/share_view.dart`

---

### Dosya: `lib/widgets/app_bars/twake_app_bar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediAppBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (21 yer):**
  - `lib/pages/contacts_tab/contacts_appbar.dart`
  - `lib/pages/device_settings/device_settings_view.dart`
  - `lib/pages/settings_dashboard/settings/settings_view.dart`
  - `lib/pages/settings_dashboard/settings_notifications/settings_notifications_view.dart`
  - `lib/pages/settings_dashboard/settings_multiple_emotes/settings_multiple_emotes_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/app_bars/twake_app_bar_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediAppBarStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/pages/device_settings/device_settings_view.dart`
  - `lib/pages/settings_dashboard/settings_notifications/settings_notifications_view.dart`
  - `lib/pages/settings_dashboard/settings_security/settings_security_view.dart`
  - `lib/pages/settings_dashboard/settings_app_language/settings_app_language_view.dart`
  - `lib/pages/settings_dashboard/settings_chat/settings_chat_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/avatar/avatar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `Avatar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (47 yer):**
  - `lib/pages/chat/typing_indicators.dart`
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat/event_info_dialog.dart`
  - `lib/pages/chat/sticker_picker_dialog.dart`
  - `lib/pages/chat/chat_app_bar_title.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/avatar/bottom_navigation_avatar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `BottomNavigationAvatar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/enum/adaptive_destinations_enum.dart`

---

### Dosya: `lib/widgets/contacts_warning_banner/contacts_warning_banner_view.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `ContactsWarningBannerView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`
  - `lib/pages/new_private_chat/new_private_chat_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`

---

### Dosya: `lib/widgets/context_menu/context_menu_action_item_widget.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `ContextMenuActionItemWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/widgets/context_menu/twake_context_menu.dart`

---

### Dosya: `lib/widgets/context_menu/twake_context_menu.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediContextMenu`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/presentation/mixins/linkify_mixin.dart`
  - `lib/widgets/mixins/twake_context_menu_mixin.dart`
  - `lib/widgets/context_menu/twake_context_menu_area.dart`

---

### Dosya: `lib/widgets/context_menu/twake_context_menu_area.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediContextMenuArea`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/events/message/message_content_with_timestamp_builder.dart`
  - `lib/widgets/context_menu/twake_context_menu.dart`

---

### Dosya: `lib/widgets/expandable_widget.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `ExpandableWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker_view.dart`

---

### Dosya: `lib/widgets/file_widget/file_error_tile_widget_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `FileErrorTileWidgetStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/send_file_dialog/files_listview_widget.dart`

---

### Dosya: `lib/widgets/file_widget/file_tile_widget_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `FileTileWidgetStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (8 yer):**
  - `lib/pages/chat/send_file_dialog/files_listview_widget.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item_style.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_tile/chat_details_file_row_web.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_row/chat_details_file_row_web.dart`
  - `lib/widgets/file_widget/file_error_tile_widget_style.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_appbar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AdaptiveScaffoldAppBar`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AdaptiveScaffoldPrimaryNavigation`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AdaptiveScaffoldPrimaryNavigationStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation_view.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation_view.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AdaptiveScaffoldPrimaryNavigationView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/adaptive_scaffold_primary_navigation.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AppAdaptiveScaffold`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/pages/chat_adaptive_scaffold/chat_adaptive_scaffold_builder.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AppAdaptiveScaffoldBody`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/config/go_routes/go_router.dart`
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AppAdaptiveScaffoldBodyView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body.dart`

---

### Dosya: `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AppAdaptiveScaffoldBodyViewStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`

---

### Dosya: `lib/widgets/layouts/enum/adaptive_destinations_enum.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/utils/background_push.dart`
  - `lib/pages/chat_list/receive_sharing_intent_mixin.dart`
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body.dart`
  - `lib/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view.dart`
  - `lib/widgets/layouts/agruments/receive_content_args.dart`

---

### Dosya: `lib/widgets/local_notifications_extension.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/matrix.dart`

---

### Dosya: `lib/widgets/matrix.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `Matrix`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (114 yer):**
  - `lib/utils/background_push.dart`
  - `lib/utils/url_launcher.dart`
  - `lib/utils/string_extension.dart`
  - `lib/utils/uia_request_manager.dart`
  - `lib/utils/matrix_sdk_extensions/event_extension.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/mixins/download_file_on_web_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/chat/events/message_download_content_web.dart`
  - `lib/pages/chat/events/message_video_download_content_web.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_web.dart`

---

### Dosya: `lib/widgets/mixins/drag_drog_file_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat_draft/draft_chat.dart`

---

### Dosya: `lib/widgets/mixins/handle_download_and_preview_file_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat/events/message_download_content_web.dart`
  - `lib/pages/chat/events/message_content.dart`
  - `lib/pages/chat/events/message_download_content.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item/chat_details_files_item.dart`
  - `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_item_web/chat_details_files_item_web.dart`

---

### Dosya: `lib/widgets/mixins/on_account_data_listen_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/widgets/twake_components/twake_header.dart`

---

### Dosya: `lib/widgets/mixins/popup_menu_widget_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (5 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`
  - `lib/pages/chat_list/chat_list.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - `lib/pages/chat_details/chat_details_edit.dart`

---

### Dosya: `lib/widgets/mixins/popup_menu_widget_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `PopupMenuWidgetStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (14 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`
  - `lib/pages/chat_list/chat_list_view.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile_view_web.dart`
  - `lib/pages/settings_dashboard/settings_profile/settings_profile.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/mixins/twake_context_menu_mixin.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (7 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/pages/chat/chat_pinned_events/pinned_messages.dart`
  - `lib/pages/chat_list/chat_list.dart`
  - `lib/pages/chat_details/assign_roles/assign_roles.dart`
  - `lib/pages/chat_details/exceptions/exceptions.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/mixins/twake_context_menu_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediContextMenuStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat/chat.dart`
  - `lib/widgets/context_menu/twake_context_menu_area.dart`
  - `lib/widgets/context_menu/context_menu_action_item_widget.dart`
  - `lib/widgets/context_menu/twake_context_menu.dart`

---

### Dosya: `lib/widgets/phone_book_loading/phone_book_loading_view.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `PhoneBookLoadingView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/contacts_tab/contacts_tab_body_view.dart`
  - `lib/pages/new_private_chat/new_private_chat_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`

---

### Dosya: `lib/widgets/profile_bottom_sheet.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `ProfileBottomSheet`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/utils/url_launcher.dart`

---

### Dosya: `lib/widgets/public_room_bottom_sheet.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `PublicRoomBottomSheet`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/utils/url_launcher.dart`

---

### Dosya: `lib/widgets/search/empty_search_widget.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `EmptySearchWidget`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (8 yer):**
  - `lib/pages/settings_dashboard/settings_blocked_users/settings_blocked_users_view.dart`
  - `lib/pages/search/server_search_view.dart`
  - `lib/pages/new_private_chat/widget/no_contacts_found.dart`
  - `lib/pages/chat_details/assign_roles/assign_roles_view.dart`
  - `lib/pages/chat_details/exceptions/exceptions_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/twake_app.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediApp`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (15 yer):**
  - `lib/utils/background_push.dart`
  - `lib/utils/voip_plugin.dart`
  - `lib/utils/uia_request_manager.dart`
  - `lib/utils/platform_infos.dart`
  - `lib/utils/dialog/twake_dialog.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/twake_components/twake_chip.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediChip`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (3 yer):**
  - `lib/pages/search/recent_item_widget.dart`
  - `lib/pages/new_private_chat/widget/expansion_contact_list_tile.dart`
  - `lib/pages/new_private_chat/widget/expansion_phonebook_contact_list_tile.dart`

---

### Dosya: `lib/widgets/twake_components/twake_fab.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediFloatingActionButton`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (4 yer):**
  - `lib/pages/chat_list/chat_list_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`
  - `lib/pages/new_group/new_group_chat_info_view.dart`
  - `lib/pages/forward/forward_view.dart`

---

### Dosya: `lib/widgets/twake_components/twake_header.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediHeader`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat_list/chat_list_header.dart`

---

### Dosya: `lib/widgets/twake_components/twake_header_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediHeaderStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/pages/multiple_accounts/multiple_accounts_picker.dart`
  - `lib/widgets/twake_components/twake_header.dart`

---

### Dosya: `lib/widgets/twake_components/twake_icon_button.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediIconButton`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (36 yer):**
  - `lib/pages/archive/archive_view.dart`
  - `lib/pages/chat/chat_input_row_send_btn.dart`
  - `lib/pages/chat/chat_input_row.dart`
  - `lib/pages/chat/chat_view.dart`
  - `lib/pages/chat/chat_input_row_web.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/twake_components/twake_loading/status_loading_widget.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `StatusLoading`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_loading/twake_loading_indicator.dart`

---

### Dosya: `lib/widgets/twake_components/twake_loading/twake_loading_indicator.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLoadingIndicator`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/send_file_dialog/media_page_view_widget.dart`

---

### Dosya: `lib/widgets/twake_components/twake_navigation_icon/twake_navigation_icon.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediNavigationIcon`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/widgets/unread_rooms_badge.dart`
  - `lib/widgets/layouts/enum/adaptive_destinations_enum.dart`

---

### Dosya: `lib/widgets/twake_components/twake_navigation_icon/twake_navigation_icon_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediNavigationIconStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_navigation_icon/twake_navigation_icon.dart`

---

### Dosya: `lib/widgets/twake_components/twake_preview_link/twake_link_preview.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLinkPreview`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/pages/chat/events/message_content.dart`

---

### Dosya: `lib/widgets/twake_components/twake_preview_link/twake_link_preview_item.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLinkPreviewItem`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_preview_link/twake_link_preview.dart`

---

### Dosya: `lib/widgets/twake_components/twake_preview_link/twake_link_preview_item_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLinkPreviewItemStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (2 yer):**
  - `lib/widgets/twake_components/twake_preview_link/twake_link_preview.dart`
  - `lib/widgets/twake_components/twake_preview_link/twake_link_preview_item.dart`

---

### Dosya: `lib/widgets/twake_components/twake_preview_link/twake_link_view.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLinkView`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_preview_link/twake_link_preview.dart`

---

### Dosya: `lib/widgets/twake_components/twake_preview_link/twake_link_view_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediLinkViewStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_preview_link/twake_link_view.dart`

---

### Dosya: `lib/widgets/twake_components/twake_text_button.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediTextButton`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (6 yer):**
  - `lib/pages/key_verification/key_verification_dialog.dart`
  - `lib/pages/chat_details/assign_roles_role_picker/assign_roles_role_picker_view.dart`
  - `lib/pages/chat_details/assign_roles_member_picker/assign_roles_member_picker_view.dart`
  - `lib/pages/new_group/contacts_selection_view.dart`
  - `lib/pages/forward/forward_view.dart`
  - ...ve daha fazlası

---

### Dosya: `lib/widgets/twake_components/twake_text_button_style.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediTextButtonStyle`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/twake_components/twake_text_button.dart`

---

### Dosya: `lib/widgets/unread_rooms_badge.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `UnreadRoomsBadge`
- **Durum:** ✅ AKTİF OLARAK KULLANILIYOR
- **Nerelerde Çağrılıyor (1 yer):**
  - `lib/widgets/layouts/enum/adaptive_destinations_enum.dart`

---

### Dosya: `lib/main.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `AppStarter`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/chat/events/audio_message/audio_player_widget.dart`
- **Ne İşe Yarar:** Matrix Event Tipi - Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak.
- **Sınıf Adı:** `AudioPlayerWidget`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/chat_details_page_view.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsPageViewBuilder`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_tile/chat_details_file_downloading_tile.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsDownloadingFileTile`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/chat_details/chat_details_page_view/files/chat_details_files_tile/chat_details_file_row_web.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `ChatDetailsFileTileRowWeb`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/chat_list/stories_header.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `StoriesHeader`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/pages/twake_welcome/twake_welcome_view_style.dart`
- **Ne İşe Yarar:** UI Sayfası (Eski Twake Giriş Ekranı) - Twake'in orijinal giriş (login/welcome) ekranı.
- **Sınıf Adı:** `DediWelcomeViewStyle`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/utils/background_push.dart`
- **Ne İşe Yarar:** Bilinmeyen - Projeye ait bir dosya
- **Sınıf Adı:** `NoTokenException`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/widgets/avatar/avatar_with_bottom_icon_widget.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `AvatarWithBottomIconWidget`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/widgets/chat_settings_popup_menu.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `ChatSettingsPopupMenu`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/widgets/twake_components/twake_avatar.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediAvatar`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/widgets/twake_components/twake_preview_placeholder.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediPreviewPlaceHolder`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

### Dosya: `lib/widgets/twake_components/twake_smart_refresher.dart`
- **Ne İşe Yarar:** UI Bileşeni (Widget) - Arayüzde gösterilen bir buton, yükleme ikonu veya menü.
- **Sınıf Adı:** `DediSmartRefresher`
- **Durum:** ❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)

---

