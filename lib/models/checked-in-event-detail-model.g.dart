// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checked-in-event-detail-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckedInEventDetail _$CheckedInEventDetailFromJson(
        Map<String, dynamic> json) =>
    CheckedInEventDetail(
      eventPostId: json['event_post_id'] as int?,
      title: json['title'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$CheckedInEventDetailToJson(
    CheckedInEventDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('title', instance.title);
  return val;
}
