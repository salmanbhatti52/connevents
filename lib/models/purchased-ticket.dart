  import 'package:connevents/models/model.dart';
  import 'package:json_annotation/json_annotation.dart';
  import 'model.dart';
  part 'purchased-ticket.g.dart';

  @JsonSerializable(includeIfNull: false)
  class PurchasedTicket extends BaseModelHive{
  String? status;

  List<PurchasedData>? data;

  PurchasedTicket({this.data,this.status,});
  Map<String,dynamic> toJson()=> _$PurchasedTicketToJson(this);
  factory PurchasedTicket.fromJson(json)=> _$PurchasedTicketFromJson(json);

  }

  @JsonSerializable(includeIfNull: false,explicitToJson: true)
  class PurchasedData extends BaseModelHive{
  @JsonKey(name: 'user_ticket_id')
  int? userTicketId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  @JsonKey(name: 'users_id')
  int? usersId;
  @JsonKey(name: 'ticket_id')
  int? ticketId;
  int? quantity;
  double? amount;
  int? discount;
  @JsonKey(name: 'transaction_date')
  String? transactionDate;
  @JsonKey(name: 'payment_type')
  String? paymentType;
  String? status;
  @JsonKey(name: 'ticket_unique_number')
  String? ticketUniqueNumber;
  @JsonKey(name: 'transaction_id')
  int? transactionId;
  @JsonKey(name: 'ticket_name')
  String? ticketName;


  PurchasedData({this.ticketName,this.status,this.ticketUniqueNumber,this.transactionId,this.eventPostId,this.usersId,this.paymentType,this.amount,this.quantity,this.discount,this.ticketId,this.transactionDate,this.userTicketId});

  Map<String,dynamic> toJson()=> _$PurchasedDataToJson(this);
  factory PurchasedData.fromJson(json)=> _$PurchasedDataFromJson(json);

  }

  @JsonSerializable(includeIfNull: false,explicitToJson: true)
  class EarlyBirdPurchasedTicket extends BaseModelHive{
  int? userTicketId;
  int? eventPostId;
  int? usersId;
  int? ticketId;
  int quantity;
  num amount;
  int? discount;
  String? transactionDate;
  String? status;

  EarlyBirdPurchasedTicket({this.status,this.eventPostId,this.usersId,this.amount=0,this.quantity=0,this.discount,this.ticketId,this.transactionDate,this.userTicketId});

  Map<String,dynamic> toJson()=> _$EarlyBirdPurchasedTicketToJson(this);
  factory EarlyBirdPurchasedTicket.fromJson(json)=> _$EarlyBirdPurchasedTicketFromJson(json);

  }


  @JsonSerializable(includeIfNull: false,explicitToJson: true)
  class RegularPurchasedTicket extends BaseModelHive{
  int? userTicketId;
  int? eventPostId;
  int? usersId;
  int? ticketId;
  int quantity;
  num amount;
  int? discount;
  String? transactionDate;
  String? status;

  RegularPurchasedTicket({this.status,this.eventPostId,this.usersId,this.amount=0,this.quantity=0,this.discount,this.ticketId,this.transactionDate,this.userTicketId});

  Map<String,dynamic> toJson()=> _$RegularPurchasedTicketToJson(this);
  factory RegularPurchasedTicket.fromJson(json)=> _$RegularPurchasedTicketFromJson(json);

  }


  @JsonSerializable(includeIfNull: false,explicitToJson: true)
  class VIPPurchasedTicket extends BaseModelHive{
  int? userTicketId;
  int? eventPostId;
  int? usersId;
  int? ticketId;
  int quantity;
  int vipQuantity;
  num amount;
  int? discount;
  String? transactionDate;
  String? status;

  VIPPurchasedTicket({this.status,this.vipQuantity=0,this.eventPostId,this.usersId,this.amount=0,this.quantity=0,this.discount,this.ticketId,this.transactionDate,this.userTicketId});

  Map<String,dynamic> toJson()=> _$VIPPurchasedTicketToJson(this);
  factory VIPPurchasedTicket.fromJson(json)=> _$VIPPurchasedTicketFromJson(json);
  }

  @JsonSerializable(includeIfNull: false,explicitToJson: true)
  class SkippingLinePurchasedTicket extends BaseModelHive{
    int? userTicketId;
    int? eventPostId;
    int? usersId;
    int? ticketId;
    int quantity;
    int skippingQuantity;
    num amount;
    int? discount;
    String? transactionDate;
    String? status;

    SkippingLinePurchasedTicket({this.status,this.skippingQuantity=0,this.eventPostId,this.usersId,this.amount=0,this.quantity=0,this.discount,this.ticketId,this.transactionDate,this.userTicketId});

    Map<String,dynamic> toJson()=> _$SkippingLinePurchasedTicketToJson(this);
    factory SkippingLinePurchasedTicket.fromJson(json)=> _$SkippingLinePurchasedTicketFromJson(json);
  }

