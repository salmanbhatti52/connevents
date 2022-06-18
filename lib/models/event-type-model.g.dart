// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-type-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTypeList _$EventTypeListFromJson(Map<String, dynamic> json) =>
    EventTypeList(
      status: json['status'] as String?,
      event_types: (json['event_types'] as List<dynamic>?)
          ?.map((e) => EventTypes.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventTypeListToJson(EventTypeList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('event_types', instance.event_types);
  return val;
}

EventTypes _$EventTypesFromJson(Map<String, dynamic> json) => EventTypes(
      status: json['status'] as String?,
      eventType: json['event_type'] as String?,
      eventTypeId: json['event_type_id'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => EventTypeCategories.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$EventTypesToJson(EventTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('event_type_id', instance.eventTypeId);
  writeNotNull('event_type', instance.eventType);
  writeNotNull('status', instance.status);
  writeNotNull('categories', instance.categories);
  return val;
}

EventTypeCategories _$EventTypeCategoriesFromJson(Map<String, dynamic> json) =>
    EventTypeCategories(
      status: json['status'] as String?,
      is_category_selected: json['is_category_selected'] as bool? ?? false,
      value: json['value'] as bool? ?? false,
      category: json['category'] as String?,
      categoryId: json['category_id'] as int?,
      eventTypeId: json['event_type_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventTypeCategoriesToJson(EventTypeCategories instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('event_type_id', instance.eventTypeId);
  writeNotNull('category', instance.category);
  writeNotNull('status', instance.status);
  val['value'] = instance.value;
  val['is_category_selected'] = instance.is_category_selected;
  return val;
}
