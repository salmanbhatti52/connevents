
import 'package:connevents/models/model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'event-ticket-model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventTicket extends BaseModelHive{
  int? ticket_id;
  int? event_post_id;
  String? ticket;
  int? quantity;
  int? price;
  String? status;
  String? closing_date;
  EarlyBirdPurchasedTicket? earlyBirdPurchasedTicket;
  RegularPurchasedTicket? regularPurchasedTicket;
  VIPPurchasedTicket? vipPurchasedTicket;


  EventTicket({this.status,this.price,this.event_post_id,this.regularPurchasedTicket,this.vipPurchasedTicket,this.earlyBirdPurchasedTicket,this.quantity,this.ticket,this.ticket_id,this.closing_date});

    Map<String,dynamic> toJson()=> _$EventTicketToJson(this);
  factory EventTicket.fromJson(json)=> _$EventTicketFromJson(json);




}


