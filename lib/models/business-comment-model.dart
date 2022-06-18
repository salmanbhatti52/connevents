import 'package:json_annotation/json_annotation.dart';
part 'business-comment-model.g.dart';

@JsonSerializable(includeIfNull: false)
class BusinessCommentsModel{
  String? status;
  @JsonKey(name: "total_post_comments")
  int? totalPostComments;
  List<BusinessComments>? comments;
  BusinessCommentsModel({this.comments,this.status,this.totalPostComments});

  Map<String, dynamic> toJson() => _$BusinessCommentsModelToJson(this);
  factory BusinessCommentsModel.fromJson(json) => _$BusinessCommentsModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class BusinessComments{
  @JsonKey(name: "business_comment_id")
  int? businessCommentId;
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "users_id")
  int? usersId;
  String? comment;
  @JsonKey(name: "comment_type")
  String? commentType;
  @JsonKey(name: "replying_to_comment_id")
  int? replyingToCommentId;
  @JsonKey(name: "total_likes")
  int? totalLikes;
  @JsonKey(name: "total_shares")
  int? totalShares;
  @JsonKey(name: "commented_datetime")
  String? commentedDatetime;
  String? status;
  @JsonKey(name: "comment_user_profile")
  String? commentUserProfile;
  @JsonKey(name: "comment_user_name")
  String? commentUserName;
  @JsonKey(name: "total_replies_count")
  int? totalRepliesCount;
  @JsonKey(name: "comment_time_ago")
  String? commentTimeAgo;
  @JsonKey(name: "comment_liked")
  String? commentLiked;
  @JsonKey(name: "mentioned_user_id")
  int? mentionedUserId;
  @JsonKey(name: "mentioned_user_name")
  String mentionedUserName;
  List<BusinessCommentReplies>? comment_replies;


  BusinessComments({this.status,this.totalRepliesCount,this.mentionedUserId,this.commentLiked,this.mentionedUserName="",this.businessCommentId,this.totalLikes,this.comment,this.comment_replies,this.commentedDatetime,this.commentTimeAgo,this.commentType,this.commentUserName,this.commentUserProfile,this.businessId,this.replyingToCommentId,this.totalShares,this.usersId});
  Map<String, dynamic> toJson() => _$BusinessCommentsToJson(this);
  factory BusinessComments.fromJson(json) => _$BusinessCommentsFromJson(json);
}


@JsonSerializable(includeIfNull: false)
class BusinessCommentReplies{
  @JsonKey(name: "business_comment_id")
  int? businessCommentId;
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "users_id")
  int? usersId;
  String? comment;
  @JsonKey(name: "comment_type")
  String? commentType;
  @JsonKey(name: "replying_to_comment_id")
  int? replyingToCommentId;
  @JsonKey(name: "total_likes")
  int? totalLikes;
  @JsonKey(name: "total_shares")
  int? totalShares;
  @JsonKey(name: "commented_datetime")
  String? commentedDatetime;
  String? status;
  @JsonKey(name: "reply_user_profile")
  String? replyUserProfile;
  @JsonKey(name: "reply_user_name")
  String? replyUserName;
  @JsonKey(name: "reply_time_ago")
  String? replyTimeAgo;
  @JsonKey(name: "reply_liked")
  String? replyLiked;
  @JsonKey(name: "mentioned_user_id")
  int? mentionedUserId;
  @JsonKey(name: "mentioned_user_name")
  String mentionedUserName;
  BusinessCommentReplies({this.businessCommentId,this.replyLiked,this.usersId,this.totalShares,this.mentionedUserId,this.mentionedUserName="",this.replyingToCommentId,this.commentType,this.commentedDatetime,this.comment,this.totalLikes,this.businessId,this.status,this.replyTimeAgo,this.replyUserName,this.replyUserProfile});
  Map<String, dynamic> toJson() => _$BusinessCommentRepliesToJson(this);
  factory BusinessCommentReplies.fromJson(json) => _$BusinessCommentRepliesFromJson(json);

}