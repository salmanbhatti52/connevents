// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-tags-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTagsModel _$EventTagsModelFromJson(Map<String, dynamic> json) =>
    EventTagsModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TagsData.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventTagsModelToJson(EventTagsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

TagsData _$TagsDataFromJson(Map<String, dynamic> json) => TagsData(
      status: json['status'] as String?,
      tagType: json['tag_type'] as String?,
      customTagUsersId: json['custom_tag_users_id'] as int?,
      isSelected: json['isSelected'] as bool? ?? false,
      tagId: json['tag_id'] as int?,
      tagName: json['tag_name'] as String?,
      eventPostId: json['event_post_id'] as int?,
      eventTagId: json['event_tag_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$TagsDataToJson(TagsData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('event_tag_id', instance.eventTagId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('tag_id', instance.tagId);
  writeNotNull('tag_type', instance.tagType);
  writeNotNull('tag_name', instance.tagName);
  writeNotNull('custom_tag_users_id', instance.customTagUsersId);
  writeNotNull('status', instance.status);
  writeNotNull('isSelected', instance.isSelected);
  return val;
}
