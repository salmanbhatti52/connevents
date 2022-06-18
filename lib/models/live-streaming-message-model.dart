

import 'package:json_annotation/json_annotation.dart';
part 'live-streaming-message-model.g.dart';

@JsonSerializable(includeIfNull: false)
class LiveStreamingChat{
  String userName;
  String? profilePicture;
  String message;
  LiveStreamingChat({this.userName="",this.profilePicture,this.message=""});

    Map<String,dynamic> toJson()=> _$LiveStreamingChatToJson(this);
  factory LiveStreamingChat.fromJson(json)=> _$LiveStreamingChatFromJson(json);

}