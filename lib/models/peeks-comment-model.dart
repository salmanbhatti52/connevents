import 'package:json_annotation/json_annotation.dart';
part 'peeks-comment-model.g.dart';

@JsonSerializable(includeIfNull: false)
class PeeksChat{

  @JsonKey(name: 'event_peek_comment_id')
  int? eventPeekCommentId;
  @JsonKey(name: 'event_peek_id')
  int? eventPeekId;
  @JsonKey(name: 'comment_type')
  String? commentType;
  @JsonKey(name: 'users_id')
  int? usersId;
  @JsonKey(name: 'profile_picture')
  String profilePicture;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'comment_time_ago')
  String commentTimeAgo;
  String comment;

    PeeksChat({this.usersId,this.commentTimeAgo="",this.comment="",this.userName="",this.profilePicture="",this.eventPeekId,this.commentType,this.eventPeekCommentId});

    Map<String,dynamic> toJson()=> _$PeeksChatToJson(this);
    factory PeeksChat.fromJson(json)=> _$PeeksChatFromJson(json);

}