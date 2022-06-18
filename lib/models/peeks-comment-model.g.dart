// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peeks-comment-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeeksChat _$PeeksChatFromJson(Map<String, dynamic> json) => PeeksChat(
      usersId: json['users_id'] as int?,
      commentTimeAgo: json['comment_time_ago'] as String? ?? "",
      comment: json['comment'] as String? ?? "",
      userName: json['user_name'] as String? ?? "",
      profilePicture: json['profile_picture'] as String? ?? "",
      eventPeekId: json['event_peek_id'] as int?,
      commentType: json['comment_type'] as String?,
      eventPeekCommentId: json['event_peek_comment_id'] as int?,
    );

Map<String, dynamic> _$PeeksChatToJson(PeeksChat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('event_peek_comment_id', instance.eventPeekCommentId);
  writeNotNull('event_peek_id', instance.eventPeekId);
  writeNotNull('comment_type', instance.commentType);
  writeNotNull('users_id', instance.usersId);
  val['profile_picture'] = instance.profilePicture;
  val['user_name'] = instance.userName;
  val['comment_time_ago'] = instance.commentTimeAgo;
  val['comment'] = instance.comment;
  return val;
}
