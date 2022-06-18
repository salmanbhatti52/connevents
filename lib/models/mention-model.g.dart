// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentionCommentModel _$MentionCommentModelFromJson(Map<String, dynamic> json) =>
    MentionCommentModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MentionCommentUserList.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$MentionCommentModelToJson(MentionCommentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

MentionCommentUserList _$MentionCommentUserListFromJson(
        Map<String, dynamic> json) =>
    MentionCommentUserList(
      usersId: json['users_id'] as int?,
      userName: json['user_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$MentionCommentUserListToJson(
    MentionCommentUserList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('user_name', instance.userName);
  writeNotNull('profile_picture', instance.profilePicture);
  return val;
}
