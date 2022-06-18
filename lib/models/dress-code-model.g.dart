// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dress-code-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DressCodeModel _$DressCodeModelFromJson(Map<String, dynamic> json) =>
    DressCodeModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DressCodeData.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$DressCodeModelToJson(DressCodeModel instance) {
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

DressCodeData _$DressCodeDataFromJson(Map<String, dynamic> json) =>
    DressCodeData(
      status: json['status'] as String?,
      dressCode: json['dress_code'] as String?,
      dressCodeId: json['dress_code_id'] as int?,
      dressCodeColor: json['dress_code_color'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$DressCodeDataToJson(DressCodeData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('dress_code_id', instance.dressCodeId);
  writeNotNull('dress_code', instance.dressCode);
  writeNotNull('dress_code_color', instance.dressCodeColor);
  writeNotNull('status', instance.status);
  return val;
}
