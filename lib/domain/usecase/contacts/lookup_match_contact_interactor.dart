import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/data/network/interceptor/authorization_interceptor.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/app_state/contact/lookup_match_contact_state.dart';
import 'package:fluffychat/domain/model/contact/contact.dart';
import 'package:fluffychat/domain/model/contact/contact_query.dart';
import 'package:fluffychat/domain/model/contact/lookup_mxid_request.dart';
import 'package:fluffychat/domain/repository/contact_repository.dart';
import 'package:fluffychat/services/session_credentials_storage.dart';
import 'package:dio/dio.dart';
import 'package:matrix/matrix.dart';

class LookupMatchContactInteractor {
  final ContactRepository contactRepository = getIt.get<ContactRepository>();
  final AuthorizationInterceptor _authorizationInterceptor =
      getIt.get<AuthorizationInterceptor>();

  LookupMatchContactInteractor();

  Stream<Either<Failure, Success>> execute({
    required String val,
  }) async* {
    try {
      yield const Right(LookupContactsLoading());
      Logs().i('LookupMatchContactInteractor:: Loading...');

      await _ensureAuthorizationToken();

      final lookupRequest = LookupMxidRequest(
        scope: [
          'mail',
          'uid',
          'mobile',
          'cn',
          'displayName',
          'sn',
          'matrixAddress',
        ],
        fields: ['uid', 'mobile', 'mail', 'cn', 'displayName'],
        val: val,
      );

      Future<List<Contact>> doLookup() {
        return contactRepository.lookupMatchContact(
          query: ContactQuery(keyword: val),
          lookupMxidRequest: lookupRequest,
        );
      }

      List<Contact> contactMatched;
      try {
        contactMatched = await doLookup();
      } on DioException catch (e) {
        // Retry once on unauthorized by refreshing auth header from persisted session.
        if (e.response?.statusCode == 401) {
          Logs().w(
            'LookupMatchContactInteractor:: unauthorized lookup, retrying once with refreshed token',
          );
          await _ensureAuthorizationToken(forceRefresh: true);
          contactMatched = await doLookup();
        } else {
          rethrow;
        }
      } on Exception catch (e) {
        // Some network layers wrap DioException in Exception(error).
        final rawError = e.toString();
        if (rawError.contains('status code of 401')) {
          Logs().w(
            'LookupMatchContactInteractor:: unauthorized lookup (wrapped), retrying once with refreshed token',
          );
          await _ensureAuthorizationToken(forceRefresh: true);
          contactMatched = await doLookup();
        } else {
          rethrow;
        }
      }

      if (contactMatched.isEmpty) {
        Logs().i('LookupMatchContactInteractor:: contactMatched is empty');
        yield const Right(LookupContactsEmpty());
      } else {
        Logs().i(
          'LookupMatchContactInteractor:: contactMatched ${contactMatched.first}',
        );
        yield Right(
          LookupMatchContactSuccess(contact: contactMatched.first),
        );
      }
    } catch (e) {
      Logs().e('LookupMatchContactInteractor:: Error $e');
      yield Left(LookupContactsFailure(keyword: val, exception: e));
    }
  }

  Future<void> _ensureAuthorizationToken({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        (_authorizationInterceptor.getAccessToken?.isNotEmpty ?? false)) {
      return;
    }

    final savedSession = await SessionCredentialsStorage.load();
    final token = savedSession?.accessToken;
    if (token != null && token.isNotEmpty) {
      _authorizationInterceptor.accessToken = token;
    }
  }
}
