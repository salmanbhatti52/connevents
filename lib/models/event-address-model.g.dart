// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-address-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventAddress _$EventAddressFromJson(Map<String, dynamic> json) => EventAddress(
      status: json['status'] as String? ?? "",
      eventPostId: json['event_post_id'] as int? ?? 0,
      addressId: json['address_id'] as int? ?? 0,
      city: json['city'] as String? ?? '',
      fullAddress: json['full_address'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zip: json['zip'] as String? ?? '',
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventAddressToJson(EventAddress instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['address_id'] = instance.addressId;
  val['event_post_id'] = instance.eventPostId;
  val['full_address'] = instance.fullAddress;
  val['city'] = instance.city;
  val['state'] = instance.state;
  val['zip'] = instance.zip;
  val['status'] = instance.status;
  return val;
}
