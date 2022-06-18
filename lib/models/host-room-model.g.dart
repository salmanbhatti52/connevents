// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host-room-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostRoom _$HostRoomFromJson(Map<String, dynamic> json) => HostRoom(
      usersId: json['users_id'] as int?,
      isLiveStreamingStarted: json['is_live_streaming_started'] as String?,
      eventPostId: json['event_post_id'] as int?,
      convertedEndTime: json['converted_End_time'] as String?,
      convertedStartTime: json['converted_start_time'] as String?,
      description: json['description'] as String?,
      channelName: json['channel_name'] as String?,
      hostRoomId: json['host_room_id'] as int?,
      liveDate: json['live_date'] as String?,
      liveEndTime: json['live_end_time'] as String?,
      liveStartTime: json['live_start_time'] as String?,
      role: json['role'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$HostRoomToJson(HostRoom instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('host_room_id', instance.hostRoomId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('channel_name', instance.channelName);
  writeNotNull('role', instance.role);
  writeNotNull('live_date', instance.liveDate);
  writeNotNull('live_start_time', instance.liveStartTime);
  writeNotNull('live_end_time', instance.liveEndTime);
  writeNotNull('description', instance.description);
  writeNotNull('converted_start_time', instance.convertedStartTime);
  writeNotNull('converted_End_time', instance.convertedEndTime);
  writeNotNull('is_live_streaming_started', instance.isLiveStreamingStarted);
  return val;
}
