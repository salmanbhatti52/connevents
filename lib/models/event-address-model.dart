import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';

part 'event-address-model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventAddress extends BaseModelHive {
  @JsonKey(name: 'address_id')
  int addressId;
  @JsonKey(name: 'event_post_id')
  int eventPostId;
  @JsonKey(name: 'full_address')
  String fullAddress;
  String city;
  String state;
  String zip;
  String status;

  EventAddress({
    this.status = "",
    this.eventPostId = 0,
    this.addressId= 0,
    this.city = '',
    this.fullAddress = '',
    this.state = '',
    this.zip = '',
  });

  Map<String, dynamic> toJson() => _$EventAddressToJson(this);

  factory EventAddress.fromJson(json) => _$EventAddressFromJson(json);
}
