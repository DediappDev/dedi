import 'dart:convert';
import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/invitation/invitation_status_response.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/invitation/generate_invitation_link_state.dart';
import 'package:fluffychat/domain/app_state/invitation/send_invitation_state.dart';
import 'package:fluffychat/domain/model/invitation/invitation_medium_enum.dart';
import 'package:fluffychat/domain/usecase/invitation/generate_invitation_link_interactor.dart';
import 'package:fluffychat/domain/usecase/invitation/send_invitation_interactor.dart';
import 'package:fluffychat/domain/usecase/invitation/store_invitation_status_interactor.dart';
import 'package:fluffychat/pages/contacts_tab/contacts_invitation_view.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';
import 'package:share_plus/share_plus.dart';

class ContactsInvitation extends StatefulWidget {
  final PresentationContact contact;
  final String userId;
  final InvitationStatusResponse? invitationStatus;

  const ContactsInvitation({
    super.key,
    required this.contact,
    required this.userId,
    this.invitationStatus,
  });

  @override
  State<ContactsInvitation> createState() => ContactsInvitationController();
}

class ContactsInvitationController extends State<ContactsInvitation> {
  final SendInvitationInteractor _sendInvitationInteractor =
      getIt.get<SendInvitationInteractor>();

  final GenerateInvitationLinkInteractor _generateInvitationLinkInteractor =
      getIt.get<GenerateInvitationLinkInteractor>();

  final StoreInvitationStatusInteractor _hiveStoreInvitationStatusInteractor =
      getIt.get<StoreInvitationStatusInteractor>();

  final ValueNotifier<PresentationThirdPartyContact?> selectedContact =
      ValueNotifier(null);

  final ValueNotifier<Either<Failure, Success>> sendInvitationNotifier =
      ValueNotifier(const Right(SendInvitationInitial()));

  final ValueNotifier<Either<Failure, Success>> generateInvitationLinkNotifier =
      ValueNotifier(const Right(GenerateInvitationLinkInitial()));

  StreamSubscription<Either<Failure, Success>>? _sendInvitationSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _generateInvitationLinkSubscription;

  bool get isSendingInvitation => sendInvitationNotifier.value.fold(
        (_) => false,
        (success) => success is SendInvitationLoadingState,
      );

  bool get isGeneratingInvitationLink =>
      generateInvitationLinkNotifier.value.fold(
        (_) => false,
        (success) => success is GenerateInvitationLinkLoadingState,
      );

  bool get isBusy => isSendingInvitation || isGeneratingInvitationLink;

  void onSelectContact(PresentationThirdPartyContact contact) {
    if (isBusy) return;
    if (widget.invitationStatus?.invitation?.medium != null) return;
    if (selectedContact.value == null) {
      selectedContact.value = contact;
    } else {
      if (selectedContact.value == contact) {
        selectedContact.value = null;
      } else {
        selectedContact.value = contact;
      }
    }
  }

  ({
    String contact,
    InvitationMediumEnum medium,
  })? _getInvitationData(PresentationThirdPartyContact contact) {
    return switch (contact) {
      final PresentationPhoneNumber phoneNumber => (
          contact: phoneNumber.phoneNumber,
          medium: InvitationMediumEnum.phone,
        ),
      final PresentationEmail email => (
          contact: email.email,
          medium: InvitationMediumEnum.email,
        ),
      _ => null,
    };
  }

  void onSendInvitation(PresentationThirdPartyContact contact) {
    if (isBusy) return;

    final invitationData = _getInvitationData(contact);

    if (invitationData != null) {
      _sendInvitationSubscription?.cancel();
      _sendInvitationSubscription = _sendInvitationInteractor
          .execute(
        contact: invitationData.contact,
        medium: invitationData.medium,
        contactId: widget.contact.id ?? '',
      )
          .listen((state) {
        sendInvitationNotifier.value = state;
      });
    }
  }

  void _onSelectContactDefault(PresentationContact contact) {
    if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
      onSelectContact(contact.phoneNumbers!.first);
      return;
    }

    if (contact.emails != null && contact.emails!.isNotEmpty) {
      onSelectContact(contact.emails!.first);
      return;
    }
  }

  void _onSendInvitationStateListener() {
    sendInvitationNotifier.value.fold(
      (failure) {
        if (failure is InvitationAlreadySentState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.youAlreadySentAnInvitationToThisContact,
          );
          return;
        }
        if (failure is InvalidPhoneNumberFailureState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.invalidPhoneNumber,
          );
          return;
        }
        if (failure is InvalidEmailFailureState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.invalidEmail,
          );
          return;
        }
        if (failure is SendInvitationFailureState) {
          final failureMessage = failure.message?.trim().isNotEmpty == true
              ? failure.message!.trim()
              : _extractServerMessage(failure.exception);
          DediSnackBar.show(
            context,
            failureMessage ?? L10n.of(context)!.failedToSendInvitation,
          );
          return;
        }
      },
      (success) {
        if (success is SendInvitationSuccessState) {
          _onStoreInvitationStatusInteractor(
            userId: widget.userId,
            contactId: widget.contact.id ?? '',
            invitationId: success.sendInvitationResponse.id ?? '',
          );
          DediSnackBar.show(
            context,
            L10n.of(context)!.invitationHasBeenSuccessfullySent,
          );
          Navigator.of(context).pop(success.sendInvitationResponse.id ?? '');
          return;
        }
      },
    );
  }

  void onGenerateInvitationLink() {
    if (isBusy) return;

    final contact = widget.contact.primaryContact;
    if (contact == null) {
      return;
    }
    final invitationData = _getInvitationData(contact);

    if (invitationData != null) {
      _generateInvitationLinkSubscription?.cancel();
      _generateInvitationLinkSubscription =
          _generateInvitationLinkInteractor.execute().listen((state) {
        generateInvitationLinkNotifier.value = state;
      });
    }
  }

  void _onGenerateInvitationLinkStateListener() {
    generateInvitationLinkNotifier.value.fold(
      (failure) {
        DediDialog.hideLoadingDialog(context);

        if (failure is GenerateInvitationLinkFailureState) {
          final failureMessage = failure.message?.trim().isNotEmpty == true
              ? failure.message!.trim()
              : _extractServerMessage(failure.exception);
          DediSnackBar.show(
            context,
            failureMessage ?? L10n.of(context)!.failedToGenerateInvitationLink,
          );
          return;
        }
        if (failure is InvalidPhoneNumberFailureState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.invalidPhoneNumber,
          );
          return;
        }
        if (failure is InvalidEmailFailureState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.invalidEmail,
          );
          return;
        }
        if (failure is GenerateInvitationLinkIsEmptyState) {
          DediSnackBar.show(
            context,
            L10n.of(context)!.failedToGenerateInvitationLink,
          );
          return;
        }
      },
      (success) async {
        if (success is GenerateInvitationLinkLoadingState) {
          DediDialog.showLoadingDialog(context);
          return;
        } else {
          DediDialog.hideLoadingDialog(context);
        }
        if (success is GenerateInvitationLinkSuccessState) {
          await Share.shareUri(
            Uri.parse(success.link),
          );
          Navigator.of(context).pop();
          return;
        }
      },
    );
  }

  void _onStoreInvitationStatusInteractor({
    required String userId,
    required String contactId,
    required String invitationId,
  }) {
    if (contactId.isEmpty || invitationId.isEmpty) {
      return;
    }
    _hiveStoreInvitationStatusInteractor
        .execute(
      userId: userId,
      contactId: contactId,
      invitationId: invitationId,
    )
        .listen((state) {
      Logs().d(
        'ContactsInvitationController::_onStoreInvitationStatusInteractor',
        state,
      );
    });
  }

  @override
  void initState() {
    _onSelectContactDefault(widget.contact);
    sendInvitationNotifier.addListener(_onSendInvitationStateListener);
    generateInvitationLinkNotifier
        .addListener(_onGenerateInvitationLinkStateListener);
    super.initState();
  }

  @override
  void dispose() {
    _sendInvitationSubscription?.cancel();
    _generateInvitationLinkSubscription?.cancel();
    DediDialog.hideLoadingDialog(context);
    sendInvitationNotifier.removeListener(_onSendInvitationStateListener);
    generateInvitationLinkNotifier
        .removeListener(_onGenerateInvitationLinkStateListener);
    selectedContact.dispose();
    sendInvitationNotifier.dispose();
    generateInvitationLinkNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContactsInvitationView(
      controller: this,
      contact: widget.contact,
    );
  }

  String? _extractServerMessage(dynamic exception) {
    if (exception is! DioException) return null;
    final data = exception.response?.data;

    if (data is Map && data['message'] is String) {
      final message = (data['message'] as String).trim();
      return message.isEmpty ? null : message;
    }

    if (data is String) {
      final text = data.trim();
      if (text.isEmpty) return null;
      try {
        final decoded = jsonDecode(text);
        if (decoded is Map && decoded['message'] is String) {
          final message = (decoded['message'] as String).trim();
          return message.isEmpty ? null : message;
        }
      } catch (_) {
        // Keep raw response text as fallback when body is not JSON.
      }
      return text;
    }

    return null;
  }
}
