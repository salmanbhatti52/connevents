import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'host-room-model.g.dart';

@JsonSerializable(includeIfNull: false)
class HostRoom extends BaseModelHive{
 @JsonKey(name:"host_room_id")
 int? hostRoomId;
 @JsonKey(name:"users_id")
 int? usersId;
 @JsonKey(name:"event_post_id")
 int? eventPostId;
 @JsonKey(name:"channel_name")
 String? channelName;
 int? role;
 @JsonKey(name:"live_date")
 String? liveDate;
 @JsonKey(name:"live_start_time")
 String? liveStartTime;
 @JsonKey(name:"live_end_time")
 String? liveEndTime;
 String? description;
 @JsonKey(name:"converted_start_time")
 String? convertedStartTime;
 @JsonKey(name:"converted_End_time")
 String? convertedEndTime;
 @JsonKey(name:"is_live_streaming_started")
 String? isLiveStreamingStarted;


 HostRoom({this.usersId,this.isLiveStreamingStarted,this.eventPostId,this.convertedEndTime,this.convertedStartTime,this.description,this.channelName,this.hostRoomId,this.liveDate,this.liveEndTime,this.liveStartTime,this.role});

   Map<String, dynamic> toJson() => _$HostRoomToJson(this);

  factory HostRoom.fromJson(json) => _$HostRoomFromJson(json);



}