import 'package:matrix/matrix.dart';

/// Lightweight placeholder used while VoIP is disabled.
///
/// The app currently gates all VoIP usage behind `webrtcIsSupported == false`,
/// but some call sites still keep a typed `VoipPlugin?` reference.
/// Keeping this no-op class avoids compile-time breakage without changing
/// runtime behavior.
class VoipPlugin {
  final Client client;

  VoipPlugin(this.client);
}
