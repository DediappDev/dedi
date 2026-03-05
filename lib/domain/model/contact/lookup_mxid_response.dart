import 'package:equatable/equatable.dart';
import 'package:fluffychat/domain/model/contact/tom_contact.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lookup_mxid_response.g.dart';

@JsonSerializable()
class LookupMxidResponse with EquatableMixin {
  @JsonKey(name: "matches")
  final Set<TomContact> contacts;

  @JsonKey(name: "inactive_matches")
  final Set<TomContact> inactiveContacts;

  LookupMxidResponse({
    required this.contacts,
    required this.inactiveContacts,
  });

  @override
  List<Object?> get props => [contacts, inactiveContacts];

  factory LookupMxidResponse.fromJson(Map<String, dynamic> json) {
    Set<TomContact> parseContacts(dynamic raw) {
      if (raw is! List) return {};
      return raw
          .whereType<Map>()
          .map(
            (item) => TomContact.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toSet();
    }

    // Compatibility note:
    // - canonical response uses matches/inactive_matches
    // - some fallback servers used matched
    final matchesRaw = json['matches'] ?? json['matched'];
    final inactiveMatchesRaw = json['inactive_matches'] ?? const [];
    return LookupMxidResponse(
      contacts: parseContacts(matchesRaw),
      inactiveContacts: parseContacts(inactiveMatchesRaw),
    );
  }

  Map<String, dynamic> toJson() => _$LookupMxidResponseToJson(this);
}
