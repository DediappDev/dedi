import 'package:equatable/equatable.dart';

class DediLookUpArgument with EquatableMixin {
  final String homeServerUrl;
  final String withAccessToken;

  DediLookUpArgument({
    required this.homeServerUrl,
    required this.withAccessToken,
  });

  @override
  List<Object?> get props => [
        homeServerUrl,
        withAccessToken,
      ];
}
