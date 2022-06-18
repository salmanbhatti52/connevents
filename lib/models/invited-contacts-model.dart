import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'invited-contacts-model.g.dart';


@JsonSerializable(includeIfNull: false)
class InvitedContacts extends BaseModelHive{
  String? senderId;
  String? contactName;
  String? contactNumber;

  InvitedContacts({this.contactName,this.contactNumber,this.senderId});

  Map<String,dynamic> toJson()=> _$InvitedContactsToJson(this);
  factory InvitedContacts.fromJson(json)=> _$InvitedContactsFromJson(json);


}