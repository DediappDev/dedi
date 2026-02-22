import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/model/invitation/invitation_request.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/invitation/generate_invitation_link_state.dart';
import 'package:fluffychat/domain/app_state/invitation/send_invitation_state.dart';
import 'package:fluffychat/domain/model/invitation/invitation_medium_enum.dart';
import 'package:fluffychat/domain/repository/invitation/invitation_repository.dart';
import 'package:fluffychat/domain/usecase/invitation/constants.dart';
import 'package:matrix/matrix.dart';

class GenerateInvitationLinkInteractor {
  final InvitationRepository _invitationRepository =
      getIt.get<InvitationRepository>();

  Stream<Either<Failure, Success>> execute({
    String? contact,
    InvitationMediumEnum? medium,
  }) async* {
    try {
      yield const Right(GenerateInvitationLinkLoadingState());
      final res = await _invitationRepository.generateInvitationLink(
        request: InvitationRequest(
          contact: contact,
          medium: medium?.value,
        ),
      );

      if (res.link.isEmpty == true) {
        yield const Left(GenerateInvitationLinkIsEmptyState());
      }
      yield Right(
        GenerateInvitationLinkSuccessState(
          link: res.link,
          id: res.id,
        ),
      );
    } catch (e) {
      Logs().e('GenerateInvitationLinkInteractor::execute', e);
      final message = _extractServerMessage(e);
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
        GenerateInvitationLinkFailureState(
          exception: e,
          message: message,
        ),
      );
      return;
    }
  }

  String? _extractServerMessage(Object error) {
    if (error is! DioException) return null;
    final data = error.response?.data;

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

    final requestPath = error.requestOptions.path;
    if (error.response?.statusCode == 400 &&
        requestPath.contains('/_dedi/v1/invite')) {
      return 'Invitations are not enabled';
    }

    return null;
  }
}
