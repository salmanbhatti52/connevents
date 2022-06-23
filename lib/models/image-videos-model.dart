
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image-videos-model.g.dart';
@JsonSerializable(includeIfNull: false)
class ImageVideo extends BaseModelHive{

  List<ImageData>? list;
  ImageVideo({this.list});
Map<String, dynamic> toJson() => _$ImageVideoToJson(this);

factory ImageVideo.fromJson(json) => _$ImageVideoFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class ImageData extends BaseModelHive{
  String attachment;
  String type;
  String media;

ImageData({this.attachment="",this.media="",this.type=""});

Map<String, dynamic> toJson() => _$ImageDataToJson(this);

factory ImageData.fromJson(json) => _$ImageDataFromJson(json);


}