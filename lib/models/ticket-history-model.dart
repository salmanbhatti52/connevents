
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ticket-history-model.g.dart';

@JsonSerializable(includeIfNull: false)

class TicketHistoryModel  extends BaseModelHive{
String? status;
List<TicketHistoryModel>? data;
TicketHistoryModel({this.status,this.data});

 Map<String,dynamic> toJson()=> _$TicketHistoryModelToJson(this);
  factory TicketHistoryModel.fromJson(json)=> _$TicketHistoryModelFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class TicketHistoryList extends BaseModelHive{
  @JsonKey(name: 'ticket_unique_number')
  String? ticketUniqueNumber;
  @JsonKey(name: 'event_title')
  String? eventTitle;
  @JsonKey(name: 'purchase_date')
  String? purchaseDate;
  @JsonKey(name: 'purchase_time')
  String? purchaseTime;
  @JsonKey(name: 'location_long')
  double? locationLong;
  @JsonKey(name: 'location_lat')
  double? locationLat;
  @JsonKey(name: 'amount')
  double? amount;

  TicketHistoryList({this.locationLong,this.amount,this.locationLat,this.eventTitle,this.purchaseDate,this.purchaseTime,this.ticketUniqueNumber});
   Map<String,dynamic> toJson()=> _$TicketHistoryListToJson(this);
  factory TicketHistoryList.fromJson(json)=> _$TicketHistoryListFromJson(json);


}