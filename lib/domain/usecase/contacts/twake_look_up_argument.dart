import 'package:equatable/equatable.dart';

class DediLookUpArgument with EquatableMixin {
  final String homeServerUrl;
  final String withAccessToken;
  final String withMxId;

  DediLookUpArgument({
    required this.homeServerUrl,
    required this.withAccessToken,
    required this.withMxId,
  });

  @override
  List<Object?> get props => [
        homeServerUrl,
        withAccessToken,
        withMxId,
      ];
}
