import 'package:equatable/equatable.dart';
import 'package:fluffychat/domain/model/common_settings_information.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_twake_information.g.dart';

@JsonSerializable()
class AppDediInformation with EquatableMixin {
  static const String appDediInformationKey = 'app.dedi.chat';

  @JsonKey(name: 'common_settings')
  CommonSettingsInformation? commonSettingsInformation;

  AppDediInformation({
    this.commonSettingsInformation,
  });

  factory AppDediInformation.fromJson(Map<String, dynamic> json) =>
      _$AppDediInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AppDediInformationToJson(this);

  @override
  List<Object?> get props => [commonSettingsInformation];
}
