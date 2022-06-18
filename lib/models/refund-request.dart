import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'refund-request.g.dart';

@JsonSerializable(includeIfNull: false,explicitToJson: true)
class RefundRequest extends BaseModelHive{
  String? status;
  List<RefundRequestList>? data;
 RefundRequest({this.status,this.data});
  Map<String,dynamic> toJson()=> _$RefundRequestToJson(this);
  factory RefundRequest.fromJson(json)=> _$RefundRequestFromJson(json);

}

@JsonSerializable(includeIfNull: false,explicitToJson: true)
class RefundRequestList extends BaseModelHive{
  @JsonKey(name: 'refund_request_id')
  int? refundRequestId;
  @JsonKey(name: 'ticket_unique_number')
  int? ticketUniqueNumber;
   @JsonKey(name: 'transaction_id')
  int? transactionId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  @JsonKey(name: 'total_amount')
  double? totalAmount;
  @JsonKey(name: 'event_organizer_id')
  int? eventOrganizerId;
  @JsonKey(name: 'ticket_buyer_id')
  int? ticketBuyerId;
  @JsonKey(name: 'datetime')
  String? datetime;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'buyer_username')
  String? buyerUsername;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'starting_date')
  String? startingDate;
  @JsonKey(name: 'starting_time')
  String? startingTime;
  @JsonKey(name: 'user_tickets')
  List<int>? userTicket;

  RefundRequestList({this.ticketUniqueNumber,this.transactionId,this.userTicket,this.totalAmount,this.eventPostId,this.status,this.buyerUsername,this.datetime,this.eventName,this.eventOrganizerId,this.refundRequestId,this.startingDate,this.startingTime,this.ticketBuyerId});

  Map<String,dynamic> toJson()=> _$RefundRequestListToJson(this);
  factory RefundRequestList.fromJson(json)=> _$RefundRequestListFromJson(json);

}