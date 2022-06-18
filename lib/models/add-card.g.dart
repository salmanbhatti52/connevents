// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add-card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCard _$AddCardFromJson(Map<String, dynamic> json) => AddCard(
      status: json['status'] as String? ?? '',
      data: json['data'] == null ? null : CardData.fromJson(json['data']),
    )..id = json['id'] as String?;

Map<String, dynamic> _$AddCardToJson(AddCard instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['status'] = instance.status;
  writeNotNull('data', instance.data);
  return val;
}

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      cardDetails: (json['card_details'] as List<dynamic>?)
          ?.map((e) => CardDetails.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$CardDataToJson(CardData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('card_details', instance.cardDetails);
  return val;
}

CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => CardDetails(
      status: json['status'] as String? ?? "",
      expiryYears: json['expiry_years'] as String? ?? "",
      usersId: json['users_id'] as int?,
      token: json['token'] as String?,
      cardId: json['card_id'] as int?,
      cvv: json['cvv'] as String? ?? "",
      cardHolderName: json['card_holder_name'] as String? ?? "",
      cardNumber: json['card_number'] as String? ?? "",
      expiryMonths: json['expiry_months'] as String? ?? "",
    )..id = json['id'] as String?;

Map<String, dynamic> _$CardDetailsToJson(CardDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('card_id', instance.cardId);
  writeNotNull('users_id', instance.usersId);
  val['card_number'] = instance.cardNumber;
  val['cvv'] = instance.cvv;
  val['card_holder_name'] = instance.cardHolderName;
  val['expiry_months'] = instance.expiryMonths;
  val['expiry_years'] = instance.expiryYears;
  val['status'] = instance.status;
  writeNotNull('token', instance.token);
  return val;
}
