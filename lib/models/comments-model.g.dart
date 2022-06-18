// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsModel _$CommentsModelFromJson(Map<String, dynamic> json) =>
    CommentsModel(
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comments.fromJson(e))
          .toList(),
      status: json['status'] as String?,
      totalPostComments: json['total_post_comments'] as int?,
    );

Map<String, dynamic> _$CommentsModelToJson(CommentsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('total_post_comments', instance.totalPostComments);
  writeNotNull('comments', instance.comments);
  return val;
}

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      status: json['status'] as String?,
      totalRepliesCount: json['total_replies_count'] as int?,
      mentionedUserId: json['mentioned_user_id'] as int?,
      commentLiked: json['comment_liked'] as String?,
      mentionedUserName: json['mentioned_user_name'] as String? ?? "",
      eventPostId: json['event_post_id'] as int?,
      totalLikes: json['total_likes'] as int?,
      comment: json['comment'] as String?,
      comment_replies: (json['comment_replies'] as List<dynamic>?)
          ?.map((e) => CommentReplies.fromJson(e))
          .toList(),
      commentedDatetime: json['commented_datetime'] as String?,
      commentTimeAgo: json['comment_time_ago'] as String?,
      commentType: json['comment_type'] as String?,
      commentUserName: json['comment_user_name'] as String?,
      commentUserProfile: json['comment_user_profile'] as String?,
      eventCommentId: json['event_comment_id'] as int?,
      replyingToCommentId: json['replying_to_comment_id'] as int?,
      totalShares: json['total_shares'] as int?,
      usersId: json['users_id'] as int?,
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('event_comment_id', instance.eventCommentId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('comment', instance.comment);
  writeNotNull('comment_type', instance.commentType);
  writeNotNull('replying_to_comment_id', instance.replyingToCommentId);
  writeNotNull('total_likes', instance.totalLikes);
  writeNotNull('total_shares', instance.totalShares);
  writeNotNull('commented_datetime', instance.commentedDatetime);
  writeNotNull('status', instance.status);
  writeNotNull('comment_user_profile', instance.commentUserProfile);
  writeNotNull('comment_user_name', instance.commentUserName);
  writeNotNull('total_replies_count', instance.totalRepliesCount);
  writeNotNull('comment_time_ago', instance.commentTimeAgo);
  writeNotNull('comment_liked', instance.commentLiked);
  writeNotNull('mentioned_user_id', instance.mentionedUserId);
  val['mentioned_user_name'] = instance.mentionedUserName;
  writeNotNull('comment_replies', instance.comment_replies);
  return val;
}

CommentReplies _$CommentRepliesFromJson(Map<String, dynamic> json) =>
    CommentReplies(
      usersId: json['users_id'] as int?,
      totalShares: json['total_shares'] as int?,
      mentionedUserId: json['mentioned_user_id'] as int?,
      mentionedUserName: json['mentioned_user_name'] as String? ?? "",
      replyingToCommentId: json['replying_to_comment_id'] as int?,
      eventCommentId: json['event_comment_id'] as int?,
      commentType: json['comment_type'] as String?,
      commentedDatetime: json['commented_datetime'] as String?,
      comment: json['comment'] as String?,
      totalLikes: json['total_likes'] as int?,
      eventPostId: json['event_post_id'] as int?,
      status: json['status'] as String?,
      replyTimeAgo: json['reply_time_ago'] as String?,
      replyUserName: json['reply_user_name'] as String?,
      replyUserProfile: json['reply_user_profile'] as String?,
    )..replyLiked = json['reply_liked'] as String?;

Map<String, dynamic> _$CommentRepliesToJson(CommentReplies instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('event_comment_id', instance.eventCommentId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('comment', instance.comment);
  writeNotNull('comment_type', instance.commentType);
  writeNotNull('replying_to_comment_id', instance.replyingToCommentId);
  writeNotNull('total_likes', instance.totalLikes);
  writeNotNull('total_shares', instance.totalShares);
  writeNotNull('commented_datetime', instance.commentedDatetime);
  writeNotNull('status', instance.status);
  writeNotNull('reply_user_profile', instance.replyUserProfile);
  writeNotNull('reply_user_name', instance.replyUserName);
  writeNotNull('reply_time_ago', instance.replyTimeAgo);
  writeNotNull('reply_liked', instance.replyLiked);
  writeNotNull('mentioned_user_id', instance.mentionedUserId);
  val['mentioned_user_name'] = instance.mentionedUserName;
  return val;
}
