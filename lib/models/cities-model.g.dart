// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      status: json['status'] as String? ?? '',
      data: json['data'] == null ? null : CityData.fromJson(json['data']),
    )..id = json['id'] as String?;

Map<String, dynamic> _$CityModelToJson(CityModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['status'] = instance.status;
  writeNotNull('data', instance.data);
  return val;
}

CityData _$CityDataFromJson(Map<String, dynamic> json) => CityData(
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$CityDataToJson(CityData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('cities', instance.cities);
  return val;
}

City _$CityFromJson(Map<String, dynamic> json) => City(
      city: json['city'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$CityToJson(City instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('city', instance.city);
  return val;
}
