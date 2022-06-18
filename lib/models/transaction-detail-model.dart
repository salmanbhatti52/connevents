import 'package:connevents/models/model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transaction-detail-model.g.dart';


@JsonSerializable(includeIfNull: false)
class TransactionDetailModel extends BaseModelHive{
  String? eventPostId;
  String? usersId;
  String? totalAmount;
  String? discount;
  String? cardId;
  String? stripeToken;
  num amount;
  int tableCount;
  String? paymentType;
  int totalPeopleTableServices;
  EarlyBirdPurchasedTicket? earlyBirdPurchasedTicket;
  RegularPurchasedTicket? regularPurchasedTicket;
  VIPPurchasedTicket? vipPurchasedTicket;
  SkippingLinePurchasedTicket? skippingLinePurchasedTicket;
  List purchasedTickets=[];

TransactionDetailModel({this.tableCount=0,this.skippingLinePurchasedTicket,this.paymentType,this.totalPeopleTableServices=0,this.stripeToken,this.cardId,this.totalAmount,this.amount=0,this.discount,required this.vipPurchasedTicket,required this.earlyBirdPurchasedTicket,required this.regularPurchasedTicket,eventPostId,this.usersId});

 Map<String,dynamic> toJson()=> _$TransactionDetailModelToJson(this);
  factory TransactionDetailModel.fromJson(json)=> _$TransactionDetailModelFromJson(json);
}

