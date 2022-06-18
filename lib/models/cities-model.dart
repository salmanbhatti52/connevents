import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';

part 'cities-model.g.dart';

@JsonSerializable(includeIfNull: false)
class CityModel extends BaseModelHive{
  String status;
  CityData? data;

CityModel({this.status='',this.data});

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  factory CityModel.fromJson(json) => _$CityModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class CityData extends BaseModelHive{
List<City>? cities;

CityData({this.cities});

  Map<String, dynamic> toJson() => _$CityDataToJson(this);

  factory CityData.fromJson(json) => _$CityDataFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class City extends BaseModelHive{
  String? city;

  City({this.city});

    Map<String, dynamic> toJson() => _$CityToJson(this);

  factory City.fromJson(json) => _$CityFromJson(json);



}