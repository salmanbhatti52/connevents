import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';

part 'event-tags-model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventTagsModel extends BaseModelHive {
  String? status;
  List<TagsData>? data;
  EventTagsModel({this.status, this.data});
  Map<String, dynamic> toJson() => _$EventTagsModelToJson(this);

  factory EventTagsModel.fromJson(json) => _$EventTagsModelFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class TagsData extends BaseModelHive {
  @JsonKey(name: 'event_tag_id')
  int? eventTagId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  @JsonKey(name: 'tag_id')
  int? tagId;
  @JsonKey(name: 'tag_type')
  String? tagType;
  @JsonKey(name: 'tag_name')
  String? tagName;
   @JsonKey(name: 'custom_tag_users_id')
  int? customTagUsersId;
  String? status;
  bool? isSelected;

  TagsData({this.status,this.tagType,this.customTagUsersId,this.isSelected=false,this.tagId, this.tagName,this.eventPostId,this.eventTagId});

  Map<String, dynamic> toJson() => _$TagsDataToJson(this);

  factory TagsData.fromJson(json) => _$TagsDataFromJson(json);
}
