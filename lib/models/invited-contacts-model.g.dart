// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invited-contacts-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitedContacts _$InvitedContactsFromJson(Map<String, dynamic> json) =>
    InvitedContacts(
      contactName: json['contactName'] as String?,
      contactNumber: json['contactNumber'] as String?,
      senderId: json['senderId'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$InvitedContactsToJson(InvitedContacts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('senderId', instance.senderId);
  writeNotNull('contactName', instance.contactName);
  writeNotNull('contactNumber', instance.contactNumber);
  return val;
}
