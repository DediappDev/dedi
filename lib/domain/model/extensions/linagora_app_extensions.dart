import 'package:fluffychat/domain/model/app_grid/linagora_app.dart';

extension DediAppExtension on DediApp {
  String getDisplayAppName() {
    switch (appName) {
      case 'Dedi Mail':
        return 'Mail';
      case 'Dedi Drive':
        return 'Drive';
      default:
        return appName;
    }
  }
}
