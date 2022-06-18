
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'peek-model.g.dart';

@JsonSerializable(includeIfNull: false)
class PeekModel{
  @JsonKey(name:"total_count")
  int? totalCount;
  String? status;

  PeekModel({this.status,this.totalCount});

   Map<String,dynamic> toJson()=> _$PeekModelToJson(this);
  factory PeekModel.fromJson(json)=> _$PeekModelFromJson(json);


}

@JsonSerializable(includeIfNull: false)
class PeekDetail extends BaseModelHive {
  @JsonKey(name:"event_peek_id")
  int? eventPeekId;
  @JsonKey(name:"event_post_id")
  int? eventPostId;
  @JsonKey(name:"users_id")
  int? usersId;
  @JsonKey(name:"video_name")
  String? videoName;
 @JsonKey(name:"description_text")
  String? descriptionText;
  @JsonKey(name:"total_likes")
  String? totalLikes;
  @JsonKey(name:"total_comments")
  String? totalComments;
  @JsonKey(name:"total_views")
  String? totalViews;
  @JsonKey(name:"video_url")
  String? videoUrl;
  @JsonKey(name:"user_name")
  String? userName;
  @JsonKey(name:"first_name")
  String? firstName;
  @JsonKey(name:"profile_picture")
  String? profilePicture;
  @JsonKey(name:"event_title")
  String? eventTitle;
   @JsonKey(name:"peek_thumbnail")
  String? peekThumbNail;
  int totalView;
  @JsonKey(name:"event_post_details")
 EventDetail? eventDetail;

  PeekDetail({this.usersId,this.eventDetail,this.totalView=0,this.profilePicture,this.userName,this.videoUrl,this.eventPostId,this.totalLikes,this.firstName,this.descriptionText,this.eventTitle,this.eventPeekId,this.totalComments,this.totalViews,this.videoName,this.peekThumbNail});

 Map<String,dynamic> toJson()=> _$PeekDetailToJson(this);
  factory PeekDetail.fromJson(json)=> _$PeekDetailFromJson(json);


}