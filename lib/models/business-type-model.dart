import 'package:json_annotation/json_annotation.dart';

part 'business-type-model.g.dart';

@JsonSerializable(includeIfNull: false)
class BusinessType {

  int? id;
  String? type;
  String? status;
  BusinessType({this.id,this.status,this.type});

  Map<String, dynamic> toJson() => _$BusinessTypeToJson(this);
  factory BusinessType.fromJson(json) => _$BusinessTypeFromJson(json);

  @override
  bool operator ==(Object other) {
    if (other is BusinessType) {
      return other.id == id;}
    return false;
  }
  @override
  int get hashCode => id.hashCode;

}