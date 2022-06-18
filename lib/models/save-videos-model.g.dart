// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save-videos-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveVideoAdapter extends TypeAdapter<SaveVideo> {
  @override
  final int typeId = 132;

  @override
  SaveVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveVideo(
      videos1: fields[1] as String?,
      videos2: fields[2] as String?,
      videos3: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SaveVideo obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.videos1)
      ..writeByte(2)
      ..write(obj.videos2)
      ..writeByte(3)
      ..write(obj.videos3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveVideo _$SaveVideoFromJson(Map<String, dynamic> json) => SaveVideo(
      videos1: json['videos1'] as String?,
      videos2: json['videos2'] as String?,
      videos3: json['videos3'] as String?,
    );

Map<String, dynamic> _$SaveVideoToJson(SaveVideo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('videos1', instance.videos1);
  writeNotNull('videos2', instance.videos2);
  writeNotNull('videos3', instance.videos3);
  return val;
}
