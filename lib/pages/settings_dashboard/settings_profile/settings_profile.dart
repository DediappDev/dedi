import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/room/upload_content_state.dart';
import 'package:fluffychat/domain/app_state/settings/update_profile_failure.dart';
import 'package:fluffychat/domain/app_state/settings/update_profile_success.dart';
import 'package:fluffychat/domain/usecase/room/upload_content_for_web_interactor.dart';
import 'package:fluffychat/domain/usecase/room/upload_content_interactor.dart';
import 'package:fluffychat/domain/usecase/settings/update_profile_interactor.dart';
import 'package:fluffychat/event/twake_event_dispatcher.dart';
import 'package:fluffychat/event/twake_inapp_event_types.dart';
import 'package:fluffychat/pages/multiple_accounts/multiple_accounts_picker.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_profile/settings_profile_capability_check.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_profile/settings_profile_context_menu_actions.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_profile/settings_profile_state/get_clients_ui_state.dart';
import 'package:fluffychat/pages/settings_dashboard/settings_profile/settings_profile_view.dart';
import 'package:fluffychat/presentation/extensions/multiple_accounts/client_profile_extension.dart';
import 'package:fluffychat/presentation/mixins/pick_avatar_mixin.dart';
import 'package:fluffychat/presentation/model/pick_avatar_state.dart';
import 'package:fluffychat/presentation/multiple_account/client_profile_presentation.dart';
import 'package:fluffychat/presentation/enum/settings/settings_profile_enum.dart';
import 'package:fluffychat/presentation/extensions/client_extension.dart';
import 'package:fluffychat/presentation/mixins/common_media_picker_mixin.dart';
import 'package:fluffychat/presentation/mixins/single_image_picker_mixin.dart';
import 'package:fluffychat/presentation/multiple_account/twake_chat_presentation_account.dart';
import 'package:fluffychat/utils/client_manager.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:fluffychat/utils/extension/value_notifier_extension.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:fluffychat/services/session_credentials_storage.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/mixins/on_account_data_listen_mixin.dart';
import 'package:fluffychat/widgets/mixins/popup_context_menu_action_mixin.dart';
import 'package:fluffychat/widgets/mixins/popup_menu_widget_mixin.dart';
import 'package:fluffychat/widgets/mixins/popup_menu_widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:linagora_design_flutter/images_picker/asset_counter.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({
    super.key,
  });

  @override
  State<SettingsProfile> createState() => SettingsProfileController();
}

class SettingsProfileController extends State<SettingsProfile>
    with
        CommonMediaPickerMixin,
        SingleImagePickerMixin,
        PopupContextMenuActionMixin,
        PopupMenuWidgetMixin,
        OnProfileChangeMixin,
        PickAvatarMixin {
  final uploadProfileInteractor = getIt.get<UpdateProfileInteractor>();
  final uploadContentInteractor = getIt.get<UploadContentInteractor>();
  final uploadContentWebInteractor =
      getIt.get<UploadContentInBytesInteractor>();

  final MenuController menuController = MenuController();

  final ValueNotifier<Profile?> currentProfile = ValueNotifier<Profile?>(null);
  AssetEntity? assetEntity;
  MatrixFile? matrixFile;

  List<DediChatPresentationAccount> _multipleAccounts = [];

  final DediEventDispatcher dediEventDispatcher =
      getIt.get<DediEventDispatcher>();

  final ValueNotifier<bool> isEditedProfileNotifier = ValueNotifier(false);

  final settingsMultiAccountsUIState = ValueNotifier<Either<Failure, Success>>(
    Right(GetClientsInitialUIState()),
  );

  Client get client => Matrix.of(context).client;

  bool get _hasEditedDisplayName =>
      displayNameEditingController.text != displayName;

  String get displayName =>
      currentProfile.value?.displayName ??
      client.mxid(context).localpart ??
      client.mxid(context);

  final TextEditingController displayNameEditingController =
      TextEditingController();
  final TextEditingController matrixIdEditingController =
      TextEditingController();

  final FocusNode displayNameFocusNode = FocusNode(
    debugLabel: 'displayNameFocusNode',
  );

  List<SettingsProfileEnum> get getListProfileMobile =>
      getListProfileBasicInfo + getListProfileWorkIdentitiesInfo;

  final List<SettingsProfileEnum> getListProfileBasicInfo = [
    SettingsProfileEnum.displayName,
  ];

  final List<SettingsProfileEnum> getListProfileWorkIdentitiesInfo = [
    SettingsProfileEnum.matrixId,
  ];

  List<SheetAction<AvatarAction>> actions() => [
        SheetAction(
          key: AvatarAction.file,
          label: L10n.of(context)!.changeProfileAvatar,
          icon: Icons.add_a_photo_outlined,
        ),
        if (currentProfile.value?.avatarUrl != null)
          SheetAction(
            key: AvatarAction.remove,
            label: L10n.of(context)!.removeYourAvatar,
            isDestructiveAction: true,
            icon: Icons.delete_outlined,
          ),
      ];

  TextEditingController? getController(
    SettingsProfileEnum settingsProfileEnum,
  ) {
    switch (settingsProfileEnum) {
      case SettingsProfileEnum.displayName:
        return displayNameEditingController;
      case SettingsProfileEnum.matrixId:
        return matrixIdEditingController;
      default:
        return null;
    }
  }

  FocusNode? getFocusNode(SettingsProfileEnum settingsProfileEnum) {
    switch (settingsProfileEnum) {
      case SettingsProfileEnum.displayName:
        return displayNameFocusNode;
      default:
        return null;
    }
  }

  void _handleRemoveAvatarAction() async {
    if (assetEntity != null || matrixFile != null) {
      isEditedProfileNotifier.toggle();
    }
    if (currentProfile.value?.avatarUrl == null) {
      _clearImageInLocal();
    } else {
      DediDialog.showLoadingDialog(context);
      _uploadProfile(isDeleteAvatar: true);
    }
  }

  void _showImagesPickerAction() async {
    if (PlatformInfos.isWeb) {
      pickAvatarImageOnWeb();
      return;
    }
    final currentPermissionPhotos = await getCurrentMediaPermission(context);
    if (currentPermissionPhotos != null) {
      final imagePickerController = createImagePickerController();
      showImagePickerBottomSheet(
        context,
        currentPermissionPhotos,
        imagePickerController,
      );
    }
  }

  ImagePickerGridController createImagePickerController() {
    final imagePickerController = ImagePickerGridController(
      AssetCounter(imagePickerMode: ImagePickerMode.single),
    );

    imagePickerController.addListener(() {
      final selectedAsset = imagePickerController.selectedAssets.firstOrNull;
      if (selectedAsset?.asset.type == AssetType.image) {
        if (!imagePickerController.pickFromCamera()) {
          Navigator.pop(context);
        }
        pickAvatarUIState.value = Right<Failure, Success>(
          GetAvatarOnMobileUIStateSuccess(
            assetEntity: selectedAsset?.asset,
          ),
        );
        if (!isEditedProfileNotifier.value) {
          isEditedProfileNotifier.toggle();
        }
        imagePickerController.removeAllSelectedItem();
      }
    });

    return imagePickerController;
  }

  void onTapAvatarInMobile() async {
    final action = await showModalActionSheet<AvatarAction>(
      context: context,
      title: L10n.of(context)!.changeYourAvatar,
      actions: actions(),
    );
    if (action == null) return;
    if (action == AvatarAction.remove) {
      _handleRemoveAvatarAction();
      return;
    }
    _showImagesPickerAction();
  }

  List<Widget> listContextMenuBuilder(
    BuildContext context,
  ) {
    final listAction = [
      SettingsProfileContextMenuActions.edit,
      SettingsProfileContextMenuActions.delete,
    ];
    final items = listAction.map((action) {
      return popupItemByDediAppRouter(
        context,
        action.getTitle(context),
        iconAction: action.getIcon(),
        isClearCurrentPage: false,
        onCallbackAction: () {
          menuController.close();
          _handleActionContextMenu(action);
        },
      );
    }).toList();

    return [
      for (final item in items) ...[
        item,
        if (item != items.last)
          Divider(
            height: PopupMenuWidgetStyle.dividerHeight,
            thickness: PopupMenuWidgetStyle.dividerThickness,
            color: PopupMenuWidgetStyle.defaultDividerColor(context),
          ),
      ],
    ];
  }

  void _handleActionContextMenu(SettingsProfileContextMenuActions action) {
    switch (action) {
      case SettingsProfileContextMenuActions.edit:
        _showImagesPickerAction();
        break;
      case SettingsProfileContextMenuActions.delete:
        pickAvatarUIState.value = Right<Failure, Success>(
          GetAvatarInitialUIState(),
        );
        _handleRemoveAvatarAction();
        break;
    }
  }

  void _sendAccountDataEvent({
    required Profile profile,
  }) async {
    Logs().d(
      'SettingsProfileController::_handleSyncProfile() - Syncing profile',
    );
    dediEventDispatcher.sendAccountDataEvent(
      client: client,
      basicEvent: BasicEvent(
        type: DediInappEventTypes.uploadAvatarEvent,
        content: profile.toJson(),
      ),
    );
    Logs().d(
      'SettingsProfileController::_handleSyncProfile() - Syncing success',
    );
  }

  void _setAvatarInStream() {
    if (assetEntity != null) {
      uploadContentInteractor
          .execute(
            matrixClient: client,
            entity: assetEntity!,
          )
          .listen(
            (event) => _handleUploadAvatarOnData(context, event),
            onDone: _handleUploadAvatarOnDone,
            onError: _handleUploadAvatarOnError,
          );
    } else {
      _uploadProfile(displayName: displayNameEditingController.text);
    }
  }

  void _setAvatarOnWeb() {
    if (matrixFile != null) {
      uploadContentWebInteractor
          .execute(
            matrixClient: client,
            matrixFile: matrixFile!,
          )
          .listen(
            (event) => _handleUploadAvatarOnData(context, event),
            onDone: _handleUploadAvatarOnDone,
            onError: _handleUploadAvatarOnError,
          );
    } else {
      _uploadProfile(displayName: displayNameEditingController.text);
    }
  }

  void onUploadProfileAction() {
    displayNameFocusNode.unfocus();
    DediDialog.showLoadingDialog(context);
    if (PlatformInfos.isMobile) {
      _setAvatarInStream();
    } else {
      _setAvatarOnWeb();
    }
  }

  void _clearImageInMemory() {
    Logs().d(
      'SettingsProfile::_clearImageInLocal() - Clear image in local',
    );
    if (assetEntity != null) {
      assetEntity = null;
    }
    if (matrixFile != null) {
      matrixFile = null;
    }
    if (currentProfile.value != null) {
      currentProfile.value = null;
    }
  }

  void _handleUploadAvatarOnDone() {
    Logs().d(
      'SettingsProfile::_handleUploadAvatarOnDone() - done',
    );
  }

  void _handleUploadAvatarOnError(
    dynamic error,
    StackTrace? stackTrace,
  ) {
    DediDialog.hideLoadingDialog(context);
    Logs().e(
      'SettingsProfile::_handleUploadAvatarOnError() - error: $error | stackTrace: $stackTrace',
    );
  }

  void _handleUploadAvatarOnData(
    BuildContext context,
    Either<Failure, Success> event,
  ) {
    Logs().d('SettingsProfile::_handleUploadAvatarOnData()');
    event.fold(
      (failure) {
        Logs().e(
          'SettingsProfile::_handleUploadAvatarOnData() - failure: $failure',
        );
        _clearImageInLocal();
        isEditedProfileNotifier.value = false;
        if (failure is UploadContentFailed) {
          DediDialog.hideLoadingDialog(context);
          DediSnackBar.show(
            context,
            _normalizeUploadErrorMessage(failure.exception),
          );
        } else if (failure is FileTooBigMatrix) {
          DediDialog.hideLoadingDialog(context);
          DediSnackBar.show(
            context,
            failure.fileTooBigMatrixException.toString(),
          );
        }
      },
      (success) {
        Logs().d(
          'SettingsProfile::_handleUploadAvatarOnData() - success: $success',
        );
        if (success is UploadContentSuccess) {
          _uploadProfile(
            avatarUr: success.uri,
            displayName: _hasEditedDisplayName
                ? displayNameEditingController.text
                : null,
          );
        }
      },
    );
  }

  void _uploadProfile({
    Uri? avatarUr,
    String? displayName,
    bool isDeleteAvatar = false,
  }) async {
    uploadProfileInteractor
        .execute(
          client: client,
          avatarUrl: avatarUr,
          isDeleteAvatar: isDeleteAvatar,
          displayName: displayName,
        )
        .listen(
          (event) => _handleUploadProfileOnData(context, event),
          onDone: _handleUploadProfileOnDone,
          onError: _handleUploadProfileOnError,
        );
  }

  void _handleUploadProfileOnDone() {
    Logs().d(
      'SettingsProfile::_handleUploadProfileOnDone() - done',
    );
  }

  void _handleUploadProfileOnError(
    dynamic error,
    StackTrace? stackTrace,
  ) {
    DediDialog.hideLoadingDialog(context);
    Logs().e(
      'SettingsProfile::_handleUploadProfileOnError() - error: $error | stackTrace: $stackTrace',
    );
  }

  void _handleUploadProfileOnData(
    BuildContext context,
    Either<Failure, Success> event,
  ) {
    Logs().d('SettingsProfile::_handleUploadProfileOnData()');
    event.fold(
      (failure) {
        final rawError = failure.toString();
        final isProfileCapabilityForbidden = rawError.contains('M_FORBIDDEN') &&
            (rawError.toLowerCase().contains('avatar') ||
                rawError.toLowerCase().contains('displayname') ||
                rawError.toLowerCase().contains('display name'));

        if (isProfileCapabilityForbidden) {
          Logs().w(
            'SettingsProfile::_handleUploadProfileOnData() - blocked by server capability: $failure',
          );
        } else {
          Logs().e(
            'SettingsProfile::_handleUploadProfileOnData() - failure: $failure',
          );
        }
        if (failure is UpdateProfileFailure) {
          _handleUpdateProfileFailure(
            _normalizeProfileErrorMessage(failure.exception.toString()),
          );
        }
      },
      (success) {
        Logs().d(
          'SettingsProfile::_handleUploadProfileOnData() - success: $success',
        );
        if (success is UpdateProfileSuccess) {
          final editedDisplayName = displayNameEditingController.text.trim();
          final resolvedDisplayName = success.displayName ??
              (editedDisplayName.isNotEmpty ? editedDisplayName : displayName);
          final resolvedAvatar =
              success.avatar ?? currentProfile.value?.avatarUrl;
          final newProfile = Profile(
            userId: client.userID!,
            displayName: resolvedDisplayName,
            avatarUrl: resolvedAvatar,
          );
          currentProfile.value = newProfile;
          pickAvatarUIState.value = Right<Failure, Success>(
            GetAvatarInitialUIState(),
          );
          _clearImageInLocal();
          _sendAccountDataEvent(profile: newProfile);
          if (isEditedProfileNotifier.value) {
            isEditedProfileNotifier.toggle();
          }
          _getCurrentProfile(client, isUpdated: true);
          DediDialog.hideLoadingDialog(context);
        }

        if (success is DeleteProfileSuccess) {
          final newProfile = Profile(
            userId: client.userID!,
            displayName: success.displayName ?? displayName,
            avatarUrl: null,
          );
          _sendAccountDataEvent(profile: newProfile);
          if (isEditedProfileNotifier.value) {
            isEditedProfileNotifier.toggle();
          }
          _getCurrentProfile(client, isUpdated: true);
          DediDialog.hideLoadingDialog(context);
          pickAvatarUIState.value = Right<Failure, Success>(
            DeleteAvatarUIStateSuccess(),
          );
        }
      },
    );
  }

  void _getCurrentProfile(
    Client client, {
    isUpdated = false,
  }) async {
    final userId = client.userID;
    if (userId == null || userId.isEmpty) {
      Logs().w(
        'SettingsProfileController::_getCurrentProfile() skipped: client has no userID',
      );
      return;
    }
    final profile = await client.getProfileFromUserId(
      userId,
      cache: false,
      getFromRooms: false,
    );
    if (!mounted) return;
    Logs().d(
      'SettingsProfileController::_getCurrentProfile() - userId=${profile.userId} displayName=${profile.displayName} avatarUrl=${profile.avatarUrl}',
    );
    currentProfile.value = profile;
    if (profile.avatarUrl == null) {
      _clearImageInLocal();
    }
    displayNameEditingController.text = displayName;
    matrixIdEditingController.text = client.mxid(context);
  }

  void handleTextEditOnChange(SettingsProfileEnum settingsProfileEnum) {
    switch (settingsProfileEnum) {
      case SettingsProfileEnum.displayName:
        _listeningDisplayNameHasChange();
        break;
      default:
        break;
    }
  }

  void _listeningDisplayNameHasChange() {
    if (displayNameEditingController.text.isEmpty) {
      isEditedProfileNotifier.value = false;
      return;
    }
    isEditedProfileNotifier.value =
        displayNameEditingController.text != displayName;
    Logs().d(
      'SettingsProfileController::_listeningDisplayNameHasChange() - ${isEditedProfileNotifier.value}',
    );
  }

  void copyEventsAction(SettingsProfileEnum settingsProfileEnum) {
    switch (settingsProfileEnum) {
      case SettingsProfileEnum.matrixId:
        Clipboard.setData(ClipboardData(text: client.mxid(context)));
        DediSnackBar.show(
          context,
          L10n.of(context)!.copiedMatrixIdToClipboard,
        );
        break;
      default:
        break;
    }
  }

  Future<void> _getMultipleAccounts(
    Client currentActiveClient,
  ) async {
    try {
      settingsMultiAccountsUIState.value = Right(GetClientsLoadingUIState());
      final profileBundles = await _getClientProfiles();
      _multipleAccounts = profileBundles
          .where((clientProfile) => clientProfile != null)
          .map(
            (clientProfile) => clientProfile!.toDediChatPresentationAccount(
              currentActiveClient,
            ),
          )
          .toList();
      settingsMultiAccountsUIState.value = Right(
        GetClientsSuccessUIState(
          multipleAccounts: _multipleAccounts,
        ),
      );
    } catch (e) {
      Logs().e(
        'SettingsProfileController::_getMultipleAccounts() - Error: $e',
      );
      settingsMultiAccountsUIState.value = Left<Failure, Success>(
        GetClientsFailureUIState(
          exception: e,
        ),
      );
    }
  }

  Future<List<ClientProfilePresentation?>> _getClientProfiles() async {
    try {
      final matrixClients = Matrix.of(context).widget.clients;
      final sessionsByClientName =
          await SessionCredentialsStorage.loadAllByClientName();
      final signedOutClientNames =
          await SessionCredentialsStorage.loadSignedOutClientNames();
      final uniqueByUserId = <String, Client>{};

      String? resolveUserId(Client client) {
        if (signedOutClientNames.contains(client.clientName)) {
          return null;
        }
        final persistedSession = sessionsByClientName[client.clientName];
        if (!client.isLogged()) {
          // Logged-out clients without a persisted session are stale entries and
          // must not be shown in the switch-account list.
          return persistedSession?.userId;
        }
        final fromClient = client.userID;
        if (fromClient != null && fromClient.isNotEmpty) return fromClient;
        return persistedSession?.userId;
      }

      void upsertClientByUserId(Client client) {
        final userId = resolveUserId(client);
        if (userId == null || userId.isEmpty) return;
        final existing = uniqueByUserId[userId];
        if (existing == null) {
          uniqueByUserId[userId] = client;
          return;
        }
        if (!existing.isLogged() && client.isLogged()) {
          uniqueByUserId[userId] = client;
          return;
        }
        if ((existing.userID?.isEmpty ?? true) &&
            (client.userID?.isNotEmpty ?? false)) {
          uniqueByUserId[userId] = client;
        }
      }

      for (final client in matrixClients) {
        upsertClientByUserId(client);
      }

      final storedClients = await ClientManager.getClients();
      for (final client in storedClients) {
        upsertClientByUserId(client);
      }
      final availableClients = uniqueByUserId.values.toList();

      final profiles = await Future.wait(
        availableClients.map((client) async {
          final resolvedUserId = resolveUserId(client);
          if (resolvedUserId == null || resolvedUserId.isEmpty) return null;

          if (!client.isLogged()) {
            return ClientProfilePresentation(
              profile: Profile(
                userId: resolvedUserId,
                displayName: resolvedUserId,
              ),
              client: client,
            );
          }

          try {
            final profileBundle = await client.fetchOwnProfile();
            Logs().d(
              'SettingsProfileController::getProfileBundles() - ClientName - ${client.clientName}',
            );
            Logs().d(
              'SettingsProfileController::getProfileBundles() - UserId - ${client.userID}',
            );
            return ClientProfilePresentation(
              profile: profileBundle,
              client: client,
            );
          } catch (e, s) {
            Logs().e(
              'SettingsProfileController::getProfileBundles() - Failed to fetch profile for ${client.clientName}: $e',
              e,
              s,
            );
            return ClientProfilePresentation(
              profile: Profile(
                userId: resolvedUserId,
                displayName: resolvedUserId,
              ),
              client: client,
            );
          }
        }),
      );

      return profiles.toList();
    } catch (e) {
      Logs().e(
        'SettingsProfileController::getProfileBundles() - Error: $e',
      );
      rethrow;
    }
  }

  Future<void> onBottomButtonTap({
    required List<DediChatPresentationAccount> multipleAccounts,
  }) async {
    await _getMultipleAccounts(client);
    final latestAccounts = settingsMultiAccountsUIState.value.fold(
      (_) => multipleAccounts,
      (success) {
        if (success is GetClientsSuccessUIState) {
          return success.multipleAccounts;
        }
        return multipleAccounts;
      },
    );
    MultipleAccountsPickerController(
      context: context,
      multipleAccounts: latestAccounts,
    ).showMultipleAccountsPicker(
      client,
      onGoToAccountSettings: () {
        context.go('/rooms/profile');
      },
    );
  }

  void _handleViewState() {
    pickAvatarUIState.addListener(() {
      Logs().d(
        "settingsProfileUIState()::_handleViewState(): ${pickAvatarUIState.value}",
      );
      pickAvatarUIState.value.fold(
        (failure) {
          if (failure is GetAvatarBigSizeUIStateFailure) {
            isEditedProfileNotifier.value = false;
          }
        },
        (success) {
          switch (success.runtimeType) {
            case const (GetAvatarOnMobileUIStateSuccess):
              final uiState = success as GetAvatarOnMobileUIStateSuccess;
              assetEntity = uiState.assetEntity;
              break;
            case const (GetAvatarOnWebUIStateSuccess):
              final uiState = success as GetAvatarOnWebUIStateSuccess;
              matrixFile = uiState.matrixFile;
              break;
            default:
              break;
          }
        },
      );
    });
  }

  void updateMatrixFile(MatrixFile newMatrixFile) {
    matrixFile = newMatrixFile;
    if (!isEditedProfileNotifier.value) {
      isEditedProfileNotifier.toggle();
    }
  }

  void _handleUpdateProfileFailure(String errorMessage) {
    DediDialog.hideLoadingDialog(context);
    DediSnackBar.show(
      context,
      errorMessage,
    );
    _clearImageInLocal();
    isEditedProfileNotifier.value = false;
    if (currentProfile.value != null) {
      _sendAccountDataEvent(profile: currentProfile.value!);
    }
  }

  String _normalizeProfileErrorMessage(String rawError) {
    if (rawError.contains('Changing avatar is disabled on this server')) {
      return 'Changing avatar is disabled on this server';
    }
    if (rawError.contains('Changing displayname is disabled on this server')) {
      return 'Changing display name is disabled on this server';
    }
    if (rawError.contains('M_FORBIDDEN')) {
      return 'Profile update is blocked by server policy';
    }
    return rawError;
  }

  String _normalizeUploadErrorMessage(Object exception) {
    final raw = exception.toString();
    if (raw.contains('DioException') || raw.contains('http error response')) {
      return 'Avatar upload failed. Please try again.';
    }
    return raw;
  }

  void _clearImageInLocal() {
    Logs().d(
      'SettingsProfile::_clearImageInLocal() - Clear image in local',
    );
    if (assetEntity != null) {
      assetEntity = null;
    }
    if (matrixFile != null) {
      matrixFile = null;
    }
  }

  @override
  void initState() {
    _handleViewState();
    _getCurrentProfile(client);
    listenToPickAvatarUIState(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      updateNewProfileForAccount();
      _getMultipleAccounts(client);
    });
    super.initState();
  }

  void updateNewProfileForAccount() {
    listenOnProfileChangeStream(
      client: Matrix.of(context).client,
      currentProfile: currentProfile.value,
      onProfileChanged: (newProfile) {
        final indexOldAccount = _multipleAccounts
            .indexWhere((element) => element.accountId == client.userID);
        if (indexOldAccount < 0) {
          return;
        }
        final newAccount = ClientProfilePresentation(
          client: Matrix.of(context).client,
          profile: newProfile,
        ).toDediChatPresentationAccount(Matrix.of(context).client);
        _multipleAccounts[indexOldAccount] = newAccount;
        settingsMultiAccountsUIState.value = Right<Failure, Success>(
          GetClientsSuccessUIState(
            multipleAccounts: _multipleAccounts,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _clearImageInLocal();
    _clearImageInMemory();
    disposePickAvatarMixin();
    currentProfile.dispose();
    onAccountDataSubscription?.cancel();
    displayNameEditingController.dispose();
    matrixIdEditingController.dispose();
    displayNameFocusNode.dispose();
    isEditedProfileNotifier.dispose();
    settingsMultiAccountsUIState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsProfileCapabilityCheck(
      builder: (capabilities, _) {
        return SettingsProfileView(
          controller: this,
          capabilities: capabilities,
        );
      },
    );
  }
}
