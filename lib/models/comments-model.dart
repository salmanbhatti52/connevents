import 'package:json_annotation/json_annotation.dart';
part 'comments-model.g.dart';
@JsonSerializable(includeIfNull: false)
class CommentsModel{
  String? status;
  @JsonKey(name: "total_post_comments")
  int? totalPostComments;
  List<Comments>? comments;
  CommentsModel({this.comments,this.status,this.totalPostComments});

  Map<String, dynamic> toJson() => _$CommentsModelToJson(this);
  factory CommentsModel.fromJson(json) => _$CommentsModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class Comments{
  @JsonKey(name: "event_comment_id")
  int? eventCommentId;
  @JsonKey(name: "event_post_id")
  int? eventPostId;
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
  List<CommentReplies>? comment_replies;


  Comments({this.status,this.totalRepliesCount,this.mentionedUserId,this.commentLiked,this.mentionedUserName="",this.eventPostId,this.totalLikes,this.comment,this.comment_replies,this.commentedDatetime,this.commentTimeAgo,this.commentType,this.commentUserName,this.commentUserProfile,this.eventCommentId,this.replyingToCommentId,this.totalShares,this.usersId});
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
  factory Comments.fromJson(json) => _$CommentsFromJson(json);
}


@JsonSerializable(includeIfNull: false)
class CommentReplies{
  @JsonKey(name: "event_comment_id")
  int? eventCommentId;
  @JsonKey(name: "event_post_id")
  int? eventPostId;
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
  CommentReplies({this.usersId,this.totalShares,this.mentionedUserId,this.mentionedUserName="",this.replyingToCommentId,this.eventCommentId,this.commentType,this.commentedDatetime,this.comment,this.totalLikes,this.eventPostId,this.status,this.replyTimeAgo,this.replyUserName,this.replyUserProfile});
  Map<String, dynamic> toJson() => _$CommentRepliesToJson(this);
  factory CommentReplies.fromJson(json) => _$CommentRepliesFromJson(json);

}