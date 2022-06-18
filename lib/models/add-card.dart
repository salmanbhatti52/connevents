import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'add-card.g.dart';

@JsonSerializable(includeIfNull: false)
class AddCard extends BaseModelHive{
 String status;
 CardData? data;

AddCard({this.status='',this.data});

Map<String, dynamic> toJson() => _$AddCardToJson(this);
factory AddCard.fromJson(json) => _$AddCardFromJson(json);
}

@JsonSerializable(includeIfNull: false)
 class CardData extends BaseModelHive{
  @JsonKey(name: 'card_details')
  List<CardDetails>? cardDetails;
  CardData({this.cardDetails});
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
  factory CardData.fromJson(json) => _$CardDataFromJson(json);

}

@JsonSerializable(includeIfNull: false)
class CardDetails extends BaseModelHive{
  @JsonKey(name: 'card_id')
  int? cardId;
  @JsonKey(name: 'users_id')
  int? usersId;
  @JsonKey(name: 'card_number')
  String cardNumber;
  String cvv;
  @JsonKey(name: 'card_holder_name')
  String cardHolderName;
  @JsonKey(name: 'expiry_months')
  String expiryMonths;
  @JsonKey(name: 'expiry_years')
  String expiryYears;
  String status;
  String? token;

  CardDetails({this.status="",this.expiryYears="",this.usersId,this.token,this.cardId,this.cvv="",this.cardHolderName="",this.cardNumber="",this.expiryMonths=""});
  Map<String, dynamic> toJson() => _$CardDetailsToJson(this);
  factory CardDetails.fromJson(json) => _$CardDetailsFromJson(json);

}