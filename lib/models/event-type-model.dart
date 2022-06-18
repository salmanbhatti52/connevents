
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'event-type-model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventTypeList extends BaseModelHive{

  String? status;
  List<EventTypes>? event_types;
  EventTypeList({this.status,this.event_types});
  Map<String,dynamic> toJson()=> _$EventTypeListToJson(this);
  factory EventTypeList.fromJson(json)=> _$EventTypeListFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class EventTypes{
  @JsonKey(name: 'event_type_id')
  int? eventTypeId;
  @JsonKey(name: 'event_type')
  String? eventType;
  String? status;
  List<EventTypeCategories>? categories;
  EventTypes({this.status,this.eventType,this.eventTypeId,this.categories});
  Map<String,dynamic> toJson()=> _$EventTypesToJson(this);
  factory EventTypes.fromJson(json)=> _$EventTypesFromJson(json);
  @override
  bool operator ==(Object other) {
    if (other is EventTypes) {
      return other.eventTypeId == eventTypeId;}
    return false;
  }
  @override
  int get hashCode => eventTypeId.hashCode;

}


@JsonSerializable(includeIfNull: false)
class EventTypeCategories extends BaseModelHive{
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'event_type_id')
  int? eventTypeId;
  String? category;
  String? status;
  bool value;
  bool is_category_selected;
  EventTypeCategories({this.status,this.is_category_selected=false,this.value=false,this.category,this.categoryId,this.eventTypeId});
  Map<String,dynamic> toJson()=> _$EventTypeCategoriesToJson(this);
  factory EventTypeCategories.fromJson(json)=> _$EventTypeCategoriesFromJson(json);


  @override
  bool operator ==(Object other) {
    if (other is EventTypeCategories) {
      return   other.categoryId == categoryId;
    }
    return false;
  }

  @override
  int get hashCode => categoryId.hashCode;

}


