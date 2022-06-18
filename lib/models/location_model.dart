// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'location_model.g.dart';
//
// @JsonSerializable()
// @HiveType(typeId: 127)
// class LocationModel {
//   @HiveField(0) String city;
//   @HiveField(1) String address;
//   @HiveField(2) double? latitude;
//
//   @HiveField(3) double? longitude;
//
//   LocationModel({
//     this.city="",
//     this.address="",
//     this.latitude,
//     this.longitude
//   });
//
//   Map<String, dynamic> toJson() => _$LocationModelToJson(this);
//   factory LocationModel.fromJson(json) => _$LocationModelFromJson(json);
// }