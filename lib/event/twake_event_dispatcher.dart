import 'package:matrix/matrix.dart';

class DediEventDispatcher {
  static final DediEventDispatcher _dediEventDispatcher =
      DediEventDispatcher._instance();

  factory DediEventDispatcher() {
    return _dediEventDispatcher;
  }

  DediEventDispatcher._instance();

  void sendAccountDataEvent({
    required Client client,
    required BasicEvent basicEvent,
  }) {
    client.onAccountData.add(basicEvent);
  }
}
