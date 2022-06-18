import 'package:json_annotation/json_annotation.dart';

part 'event-dummy-ticket.g.dart';

@JsonSerializable(includeIfNull: false)
class EarlyBird {
  @JsonKey(name: 'ticket_id')
  int? ticketId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  String ticket;
  String? quantity;
  String? price;
  @JsonKey(name: 'closing_date')
  String closingDate;
  String earlyBird;
  bool isVisible;
 late DateTime selectedDate;
  EarlyBird({this.quantity="",this.ticketId,this.eventPostId,this.isVisible=false,this.earlyBird='' ,this.ticket= "" , this.price="", this.closingDate="",
  DateTime? selectedDate
  }) {
    this.selectedDate= selectedDate ?? DateTime.now();

}

  Map<String, dynamic> toJson() => _$EarlyBirdToJson(this);

  factory EarlyBird.fromJson(json) {

    json['quantity']=json['quantity'].toString();
    json['price']=json['price'].toString();
    var data= _$EarlyBirdFromJson(json);
    return data;
  }
}

@JsonSerializable(includeIfNull: false)
class Regular {
   @JsonKey(name: 'ticket_id')
 int? ticketId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  String ticket;
  String? quantity;
  String? price;
  bool isVisible;
  Regular({this.quantity="", this.isVisible=false,this.ticket="", this.price="",this.eventPostId,this.ticketId});
  Map<String, dynamic> toJson() => _$RegularToJson(this);
  factory Regular.fromJson(json){
    json['quantity']=json['quantity'].toString() ;
    json['price']= json['price'].toString();
    print(json['price']);
    var data= _$RegularFromJson(json);
    return  data;
  }
}

@JsonSerializable(includeIfNull: false)
class VIP {
  @JsonKey(name: 'ticket_id')
  int? ticketId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  String ticket;
  String? quantity;
  String? price;
  bool isVisible;

  VIP({this.quantity="", this.isVisible=false,this.ticket="", this.price="",this.ticketId,this.eventPostId});

  Map<String, dynamic> toJson() => _$VIPToJson(this);

  factory VIP.fromJson(json){
     json['quantity']=json['quantity'].toString();
    json['price']=json['price'].toString();
    var data=_$VIPFromJson(json);
    return data;
  }
}


@JsonSerializable(includeIfNull: false)
class SkippingLine {
  @JsonKey(name: 'ticket_id')
  int? ticketId;
  @JsonKey(name: 'event_post_id')
  int? eventPostId;
  String ticket;
  String? quantity;
  String? price;
  bool isVisible;

  SkippingLine({this.quantity="", this.isVisible=false,this.ticket="", this.price="",this.ticketId,this.eventPostId});

  Map<String, dynamic> toJson() => _$SkippingLineToJson(this);

  factory SkippingLine.fromJson(json){
    json['quantity']=json['quantity'].toString();
    json['price']=json['price'].toString();
    var data=_$SkippingLineFromJson(json);
    return data;
  }
}

