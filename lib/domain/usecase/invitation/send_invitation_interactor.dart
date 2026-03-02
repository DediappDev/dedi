import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/invitation/invitation_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/invitation/send_invitation_state.dart';
import 'package:fluffychat/domain/model/invitation/invitation_medium_enum.dart';
import 'package:fluffychat/domain/repository/invitation/invitation_repository.dart';
import 'package:fluffychat/domain/usecase/invitation/constants.dart';
import 'package:fluffychat/utils/dio_error_message_extractor.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:matrix/matrix.dart';

class SendInvitationInteractor {
  final InvitationRepository _invitationRepository =
      getIt.get<InvitationRepository>();
  static const _requestTimeout = Duration(seconds: 20);

  Stream<Either<Failure, Success>> execute({
    required String contact,
    required String contactId,
    required InvitationMediumEnum medium,
  }) async* {
    try {
      yield const Right(SendInvitationLoadingState());
      final res = await _invitationRepository
          .sendInvitation(
            request: InvitationRequest(
              contact: _tryToNormalizePhoneNumber(contact, medium),
              medium: medium.value,
            ),
          )
          .timeout(_requestTimeout);
      yield Right(
        SendInvitationSuccessState(
          sendInvitationResponse: res,
          contactId: contactId,
        ),
      );
    } on TimeoutException catch (e) {
      Logs().e('SendInvitationInteractor::execute', e);
      yield Left(
        SendInvitationFailureState(
          exception: e,
          message: 'Request timed out. Please try again.',
        ),
      );
      return;
    } catch (e) {
      final message = DioErrorMessageExtractor.extract(e);
      if (e is DioException) {
        Logs().e(
          'SendInvitationInteractor::execute: status=${e.response?.statusCode}, path=${e.requestOptions.path}, message=${message ?? e.message ?? 'unknown error'}',
        );
      } else {
        Logs().e('SendInvitationInteractor::execute', e);
      }
      if (e is DioException && e.response?.statusCode == 400) {
        if (message == Constants.alreadySentInvitationMessage) {
          yield const Left(InvitationAlreadySentState());
          return;
        } else if (message?.contains(Constants.invalidPhoneNumberMessage) ==
            true) {
          yield const Left(InvalidPhoneNumberFailureState());
          return;
        } else if (message?.contains(Constants.invalidEmailMessage) == true) {
          yield const Left(InvalidEmailFailureState());
          return;
        }
      }
      yield Left(
        SendInvitationFailureState(
          exception: e,
          message: message,
        ),
      );
      return;
    }
  }

  String _tryToNormalizePhoneNumber(
    String contact,
    InvitationMediumEnum medium,
  ) {
    if (medium != InvitationMediumEnum.phone) {
      return contact;
    }

    String normalizedPhoneNumber = contact;
    try {
      normalizedPhoneNumber = contact.normalizePhoneNumberToInvite();
    } catch (e) {
      Logs().e('SendInvitationInteractor::_tryToNormalizePhoneNumber', e);
    }
    return normalizedPhoneNumber;
  }
}
