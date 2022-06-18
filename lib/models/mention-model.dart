import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'mention-model.g.dart';

@JsonSerializable(includeIfNull: false)
class MentionCommentModel extends BaseModelHive{
  String? status;
  List<MentionCommentUserList>? data;

MentionCommentModel({this.status,this.data});

  Map<String,dynamic> toJson()=> _$MentionCommentModelToJson(this);
  factory MentionCommentModel.fromJson(json)=> _$MentionCommentModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class MentionCommentUserList extends BaseModelHive{
  @JsonKey(name: 'users_id')
  int? usersId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  MentionCommentUserList({this.usersId,this.userName,this.profilePicture});

  Map<String,dynamic> toJson()=> _$MentionCommentUserListToJson(this);
  factory MentionCommentUserList.fromJson(json)=> _$MentionCommentUserListFromJson(json);
}