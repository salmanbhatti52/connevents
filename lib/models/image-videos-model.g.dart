// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image-videos-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageVideo _$ImageVideoFromJson(Map<String, dynamic> json) => ImageVideo(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => ImageData.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$ImageVideoToJson(ImageVideo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('list', instance.list);
  return val;
}

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
      attachment: json['attachment'] as String? ?? "",
      media: json['media'] as String? ?? "",
      type: json['type'] as String? ?? "",
    )..id = json['id'] as String?;

Map<String, dynamic> _$ImageDataToJson(ImageData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['attachment'] = instance.attachment;
  val['type'] = instance.type;
  val['media'] = instance.media;
  return val;
}
