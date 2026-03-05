import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(includeIfNull: false)
class UserInfo extends Equatable {
  final String? uid;
  final String? displayName;
  final String? avatarUrl;
  final List<String>? phones;
  final List<String>? mail;
  final String? sn;
  final String? givenName;
  final String? language;
  final String? timezone;

  const UserInfo({
    this.uid,
    this.displayName,
    this.avatarUrl,
    this.phones,
    this.mail,
    this.sn,
    this.givenName,
    this.language,
    this.timezone,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    List<String>? parseStringList(dynamic raw) {
      if (raw is! List) return null;
      return raw.whereType<String>().toList();
    }

    return UserInfo(
      uid: json['uid'] as String? ?? json['user_id'] as String?,
      displayName: json['displayName'] as String? ??
          json['display_name'] as String? ??
          json['displayname'] as String? ??
          json['cn'] as String?,
      avatarUrl: json['avatarUrl'] as String? ??
          json['avatar_url'] as String? ??
          json['avatar'] as String?,
      phones: parseStringList(json['phones']),
      mail: parseStringList(json['mail']) ?? parseStringList(json['mails']),
      sn: json['sn'] as String?,
      givenName: json['givenName'] as String? ?? json['given_name'] as String?,
      language: json['language'] as String?,
      timezone: json['timezone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  List<Object?> get props => [
        uid,
        displayName,
        avatarUrl,
        phones,
        mail,
        sn,
        givenName,
        language,
        timezone,
      ];
}
