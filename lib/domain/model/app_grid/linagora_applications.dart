import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'linagora_app.dart';

part 'linagora_applications.g.dart';

@JsonSerializable()
class DediApplications with EquatableMixin {
  @JsonKey(name: 'apps')
  final List<DediApp> apps;

  DediApplications(this.apps);

  factory DediApplications.fromJson(Map<String, dynamic> json) =>
      _$DediApplicationsFromJson(json);

  Map<String, dynamic> toJson() => _$DediApplicationsToJson(this);

  @override
  List<Object?> get props => [apps];
}
