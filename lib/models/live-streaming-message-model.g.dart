// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live-streaming-message-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveStreamingChat _$LiveStreamingChatFromJson(Map<String, dynamic> json) =>
    LiveStreamingChat(
      userName: json['userName'] as String? ?? "",
      profilePicture: json['profilePicture'] as String?,
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$LiveStreamingChatToJson(LiveStreamingChat instance) {
  final val = <String, dynamic>{
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('profilePicture', instance.profilePicture);
  val['message'] = instance.message;
  return val;
}
