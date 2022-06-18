
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'save-videos-model.g.dart';

@HiveType(typeId: 132)
@JsonSerializable(includeIfNull: false)
class SaveVideo{
  @HiveField(1)
  String?  videos1;
  @HiveField(2)
  String?  videos2;
  @HiveField(3)
  String?  videos3;

  SaveVideo({this.videos1,this.videos2,this.videos3});
   Map<String,dynamic> toJson()=> _$SaveVideoToJson(this);
  factory SaveVideo.fromJson(json)=> _$SaveVideoFromJson(json);

}