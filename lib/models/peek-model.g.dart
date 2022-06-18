// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peek-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeekModel _$PeekModelFromJson(Map<String, dynamic> json) => PeekModel(
      status: json['status'] as String?,
      totalCount: json['total_count'] as int?,
    );

Map<String, dynamic> _$PeekModelToJson(PeekModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total_count', instance.totalCount);
  writeNotNull('status', instance.status);
  return val;
}

PeekDetail _$PeekDetailFromJson(Map<String, dynamic> json) => PeekDetail(
      usersId: json['users_id'] as int?,
      eventDetail: json['event_post_details'] == null
          ? null
          : EventDetail.fromJson(json['event_post_details']),
      totalView: json['totalView'] as int? ?? 0,
      profilePicture: json['profile_picture'] as String?,
      userName: json['user_name'] as String?,
      videoUrl: json['video_url'] as String?,
      eventPostId: json['event_post_id'] as int?,
      totalLikes: json['total_likes'] as String?,
      firstName: json['first_name'] as String?,
      descriptionText: json['description_text'] as String?,
      eventTitle: json['event_title'] as String?,
      eventPeekId: json['event_peek_id'] as int?,
      totalComments: json['total_comments'] as String?,
      totalViews: json['total_views'] as String?,
      videoName: json['video_name'] as String?,
      peekThumbNail: json['peek_thumbnail'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$PeekDetailToJson(PeekDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('event_peek_id', instance.eventPeekId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('video_name', instance.videoName);
  writeNotNull('description_text', instance.descriptionText);
  writeNotNull('total_likes', instance.totalLikes);
  writeNotNull('total_comments', instance.totalComments);
  writeNotNull('total_views', instance.totalViews);
  writeNotNull('video_url', instance.videoUrl);
  writeNotNull('user_name', instance.userName);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('event_title', instance.eventTitle);
  writeNotNull('peek_thumbnail', instance.peekThumbNail);
  val['totalView'] = instance.totalView;
  writeNotNull('event_post_details', instance.eventDetail);
  return val;
}
