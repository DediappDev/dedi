import 'package:fluffychat/domain/usecase/contacts/twake_look_up_argument.dart';

class FederationLookUpArgument extends DediLookUpArgument {
  final String federationUrl;

  FederationLookUpArgument({
    required super.homeServerUrl,
    required this.federationUrl,
    required super.withMxId,
    required super.withAccessToken,
  });

  @override
  List<Object?> get props => [
        homeServerUrl,
        federationUrl,
        withMxId,
        withAccessToken,
      ];
}
