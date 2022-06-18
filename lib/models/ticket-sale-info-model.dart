
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket-sale-info-model.g.dart';

@JsonSerializable(includeIfNull: false)
class TicketSalesModel extends BaseModelHive{
  String? status;
  TicketSaleInfo? data;

  TicketSalesModel({this.data,this.status});


  Map<String, dynamic> toJson() => _$TicketSalesModelToJson(this);
factory TicketSalesModel.fromJson(json) => _$TicketSalesModelFromJson(json);
}


@JsonSerializable(includeIfNull: false)

class TicketSaleInfo extends BaseModelHive{
  @JsonKey(name:"ticket_id")
  int? ticketId;
  @JsonKey(name:"event_post_id")
  int? eventPostId;
  String? ticket;
  int? quantity;
  @JsonKey(name:"total_quantity")
  int? totalQuantity;
  double? price;
  @JsonKey(name:"closing_date")
  String? closingDate;
  String? status;
  @JsonKey(name:"total_sales")
  int? totalSales;
  @JsonKey(name:"sold_tickets")
  int soldTickets;
  @JsonKey(name:"total_checkins")
  int? totalCheckins;
  @JsonKey(name:"checkins")
  int checkins;
  @JsonKey(name:"total_reserved_tables")
  int? totalReservedTables;
  @JsonKey(name:"total_table_service")
  int? totalTableService;
  TicketSaleInfo({this.totalCheckins,this.totalTableService,this.totalReservedTables,this.checkins=0, this.status,this.quantity,this.soldTickets=0,this.eventPostId,this.totalQuantity,this.closingDate,this.price,this.ticket,this.ticketId,this.totalSales});

  Map<String, dynamic> toJson() => _$TicketSaleInfoToJson(this);
factory TicketSaleInfo.fromJson(json) => _$TicketSaleInfoFromJson(json);


}