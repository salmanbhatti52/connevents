import 'package:connevents/models/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user-location-model.g.dart';


@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 133)
class UserLocation extends BaseModelHive{
  @HiveField(1)
  double? latitude;
  @HiveField(2)
  double? longitude;
  @HiveField(3)
  String address;

  UserLocation({this.longitude,this.latitude,this.address=""});

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
  factory UserLocation.fromJson(json) => _$UserLocationFromJson(json);

}