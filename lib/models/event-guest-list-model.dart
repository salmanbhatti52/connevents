import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event-guest-list-model.g.dart';


@JsonSerializable(includeIfNull: false)
class EventGuestList extends BaseModelHive{

  @JsonKey(name: 'ticket_unique_number')
  String? ticketUniqueNumber;
  @JsonKey(name: 'transaction_id')
  int? transactionId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  @JsonKey(name: 'total_amount')
  double? totalAmount;
  @JsonKey(name: 'list_of_ids')
  List? listOfId;
  @JsonKey(name: 'location_long')
  double? locationLong;
  @JsonKey(name: 'location_lat')
  double? locationLat;
  String? ticket;
  @JsonKey(name: 'user_name')
  String? userName;
  String? title;
  @JsonKey(name: 'purchase_date')
  String? purchaseDate;
  @JsonKey(name: 'purchase_time')
  String? purchaseTime;
  @JsonKey(name: 'event_start_date')
  String? eventStartDate;
  @JsonKey(name: 'event_start_time')
  String? eventStartTime;
  @JsonKey(name: 'is_checked_in')
  bool? isCheckedIn;
  int? quantity;


  EventGuestList({this.isCheckedIn,this.quantity,this.locationLat,this.locationLong,this.listOfId,this.totalAmount,this.eventPostId,this.ticket,this.transactionId,this.title,this.ticketUniqueNumber,this.purchaseTime,this.purchaseDate,this.eventStartDate,this.userName,this.eventStartTime});

  Map<String,dynamic> toJson()=> _$EventGuestListToJson(this);
  factory EventGuestList.fromJson(json)=> _$EventGuestListFromJson(json);



}