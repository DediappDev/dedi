import 'dart:async';

import 'package:fluffychat/config/app_config.dart';
import 'package:equatable/equatable.dart';
import 'package:fluffychat/presentation/mixins/connect_page_mixin.dart';
import 'package:fluffychat/pages/twake_welcome/twake_welcome_view.dart';
import 'package:fluffychat/utils/client_manager.dart';
import 'package:fluffychat/utils/dialog/twake_dialog.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:fluffychat/utils/url_launcher.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

enum DediWelcomeType {
  firstAccount,
  otherAccounts,
}

class DediWelcomeArg extends Equatable {
  final DediWelcomeType dediIdType;

  const DediWelcomeArg({
    this.dediIdType = DediWelcomeType.firstAccount,
  });

  bool get isAddAnotherAccount => dediIdType == DediWelcomeType.otherAccounts;

  @override
  List<Object?> get props => [dediIdType];
}

class DediWelcome extends StatefulWidget {
  final DediWelcomeArg? arg;

  const DediWelcome({super.key, this.arg});

  @override
  State<DediWelcome> createState() => DediWelcomeController();
}

class DediWelcomeController extends State<DediWelcome> with ConnectPageMixin {
  void goToHomeserverPicker() {
    if (widget.arg != null && widget.arg?.isAddAnotherAccount == true) {
      context.push('/rooms/addaccount/homeserverpicker');
    } else {
      context.push('/home/homeserverpicker');
    }
  }

  static const String postLoginRedirectUrlPathParams =
      'post_login_redirect_url';

  static const String postRegisteredRedirectUrlPathParams =
      'post_registered_redirect_url';

  String get loginUrl =>
      "${AppConfig.registrationUrl}?$postLoginRedirectUrlPathParams=${AppConfig.appOpenUrlScheme}://redirect&app=${AppConfig.appParameter}";

  String get signupUrl =>
      "${AppConfig.registrationUrl}?$postRegisteredRedirectUrlPathParams=${AppConfig.appOpenUrlScheme}://redirect&app=${AppConfig.appParameter}";

  MatrixState get matrix => Matrix.of(context);

  void onClickSignIn() {
    Logs().d("DediIdController::onClickSignIn: Login Url - $loginUrl");
    _redirectRegistrationUrl(loginUrl);
  }

  void _redirectRegistrationUrl(String url) async {
    try {
      DediDialog.showLoadingDediWelcomeDialog(context);
      final homeserverExisted = await _homeserverExisted();
      if (homeserverExisted) {
        DediDialog.hideLoadingDialog(context);
        return;
      }
      matrix.loginHomeserverSummary =
          await matrix.getLoginClient().checkHomeserver(
                Uri.parse(AppConfig.dediWorkplaceHomeserver),
              );
      final uri = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: AppConfig.appOpenUrlScheme,
        options: const FlutterWebAuth2Options(
          intentFlags: ephemeralIntentFlags,
        ),
      );
      Logs().d("DediIdController:_redirectRegistrationUrl: URI - $uri");
      await handleTokenFromRegistrationSite(matrix: matrix, uri: uri);
      Logs().d("DediIdController:_redirectRegistrationUrl: DONE");
      DediDialog.hideLoadingDialog(context);
    } catch (e) {
      Logs().e("DediIdController::_redirectRegistrationUrl: $e");
      DediDialog.hideLoadingDialog(context);
    }
  }

  void onClickCreateDediId() {
    Logs().d(
      "DediIdController::onClickCreateDediId: Signup Url - $signupUrl",
    );
    _redirectRegistrationUrl(signupUrl);
  }

  Future<bool> _homeserverExisted() async {
    if (widget.arg != null && widget.arg?.isAddAnotherAccount == false) {
      return false;
    }
    try {
      final allHomeserverLoggedIn = (await ClientManager.getClients())
          .where((client) => client.homeserver != null)
          .map((client) => client.homeserver.toString())
          .toList();
      Logs().i('All homeservers: $allHomeserverLoggedIn');
      final homeserverExists = allHomeserverLoggedIn.any(
        (homeserver) => "$homeserver/".contains(AppConfig.homeserver),
      );

      if (homeserverExists &&
          !AppConfig.supportMultipleAccountsInTheSameHomeserver) {
        DediSnackBar.show(
          context,
          L10n.of(context)!.isSingleAccountOnHomeserver,
        );
        return true;
      }
    } catch (e) {
      Logs().e('DediIdController::_homeserverExisted: $e');
      return false;
    }
    return false;
  }

  void onClickPrivacyPolicy() {
    UrlLauncher(
      context,
      url: AppConfig.privacyUrl,
    ).openUrlInAppBrowser();
  }

  @override
  Widget build(BuildContext context) {
    return DediWelcomeView(
      controller: this,
    );
  }
}
