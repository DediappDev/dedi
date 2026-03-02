import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/pages/twake_welcome/twake_welcome.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class DediWelcomeView extends StatelessWidget {
  final DediWelcomeController controller;

  const DediWelcomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final isSaasPlatform = AppConfig.isSaasPlatForm;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: controller.widget.arg?.isAddAnotherAccount == true
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                tooltip: l10n.back,
              ),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF02C8FF),
              Color(0xFF0058FF),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    ImagePaths.dediWordmarkLight,
                    width: 132,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 48),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePaths.dediSplashLogo,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        l10n.dediMainTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.dediMainDescription,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (isSaasPlatform) ...[
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0058FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: controller.onClickSignIn,
                    child: Text(l10n.signIn),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: controller.onClickCreateDediId,
                    child: Text(l10n.createDediId),
                  ),
                  const SizedBox(height: 12),
                ],
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white54),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: controller.goToHomeserverPicker,
                  child: Text(l10n.useYourCompanyServer),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: controller.onClickPrivacyPolicy,
                  child: Text(
                    '${l10n.byContinuingYourAgreeingToOur} ${l10n.privacyPolicy}',// TODO: add translation
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
