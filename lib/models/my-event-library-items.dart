

import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'my-event-library-items.g.dart';


@JsonSerializable(includeIfNull: false)
class MyEventLibraryItems extends BaseModelHive{

  @JsonKey(name: 'event_library_item_id')
  int? eventLibraryItemId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  @JsonKey(name: 'users_id')
  int? usersId;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'uploaded_datetime')
  String? uploadedDateTime;
  @JsonKey(name: 'post_user_id')
  int? postUserId;
  @JsonKey(name: 'post_user_name')
  String? postUserName;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  @JsonKey(name: 'total_likes_on_item')
  int? totalLikesOnItem;
  @JsonKey(name: 'is_liked')
  bool isLiked;
  @JsonKey(name: 'thumbnail_name')
  String? thumbnailName;

  MyEventLibraryItems({this.thumbnailName,this.profilePicture,this.isLiked=false,this.totalLikesOnItem,this.eventPostId,this.usersId,this.eventLibraryItemId,this.fileName,this.fileType,this.postUserId,this.postUserName,this.uploadedDateTime
  });



  Map<String,dynamic> toJson()=> _$MyEventLibraryItemsToJson(this);
  factory MyEventLibraryItems.fromJson(json)=> _$MyEventLibraryItemsFromJson(json);




}