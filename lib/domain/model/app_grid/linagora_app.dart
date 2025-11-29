import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'linagora_app.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DediApp with EquatableMixin {
  @JsonKey(name: 'appName')
  final String appName;

  @JsonKey(name: 'icon')
  final String iconName;

  @JsonKey(name: 'appLink')
  final Uri appUri;

  final String? androidPackageId;
  final String? iosUrlScheme;
  final String? iosAppStoreLink;
  final Uri? publicIconUri;

  DediApp(
    this.appName,
    this.iconName,
    this.appUri, {
    this.androidPackageId,
    this.iosUrlScheme,
    this.iosAppStoreLink,
    this.publicIconUri,
  });

  factory DediApp.fromJson(Map<String, dynamic> json) =>
      _$DediAppFromJson(json);

  Map<String, dynamic> toJson() => _$DediAppToJson(this);

  @override
  List<Object?> get props => [
        appName,
        iconName,
        appUri,
        androidPackageId,
        iosUrlScheme,
        iosAppStoreLink,
        publicIconUri,
      ];
}
