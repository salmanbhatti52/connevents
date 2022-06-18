import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'report-event-model.g.dart';

@JsonSerializable(includeIfNull: false)

class ReportEventModel{
String? success;
String? data;
String? comment;

ReportEventModel({this.data,this.success,this.comment});

Map<String,dynamic> toJson()=> _$ReportEventModelToJson(this);
factory ReportEventModel.fromJson(json)=> _$ReportEventModelFromJson(json);

}