import 'package:connevents/models/business-type-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'business-create-model.g.dart';

@JsonSerializable(includeIfNull: false)
class BusinessCreateModel extends BaseModelHive{
  String? status;
  Business? data;

  BusinessCreateModel({this.data, this.status});

  Map<String, dynamic> toJson() => _$BusinessCreateModelToJson(this);

  factory BusinessCreateModel.fromJson(json) => _$BusinessCreateModelFromJson(json);

}

@JsonSerializable(includeIfNull: false,explicitToJson: true)
class Business extends BaseModelHive{

  @JsonKey(name: 'organizer_user_name')
  String? organizerUserName;
  @JsonKey(name: 'organize_profile_picture')
  String? organizerProfilePicture;
  @JsonKey(name: 'business_id')
  num? businessId;
  @JsonKey(name: 'users_id')
  int usersId;
  String title;
  String? firstThumbNail;
  String? secondThumbNail;
  String? thirdThumbNail;
  @JsonKey(name: 'first_image')
  String firstImage;
  @JsonKey(name: 'second_image')
  String secondImage;
  @JsonKey(name: 'third_image')
  String thirdImage;
  @JsonKey(name: 'fourth_image')
  String fourthImage;
  @JsonKey(name: 'fifth_image')
  String fifthImage;
  @JsonKey(name: 'sixth_image')
  String sixthImage;
  @JsonKey(name: 'first_video')
  String firstVideo;
  String first_video_thumbnail;
  @JsonKey(name: 'second_video')
  String secondVideo;
  String second_video_thumbnail;
  @JsonKey(name: 'third_video')
  String thirdVideo;
  String third_video_thumbnail;
  String description;
  @JsonKey(name: 'business_logo')
  String businessLogo;
  String? status;
  @JsonKey(name: 'business_long')
  double? businessLong;
  @JsonKey(name: 'business_lat')
  double? businessLat;
  @JsonKey(name: 'event_address')
  EventAddress? eventAddress;
  String city;
  String state;
  String zip;
  String address;
  List? list;
  List? removedTickets;
  DateTime? createdAt;
  @JsonKey(name: 'time_ago')
  String? timeAgo;
  @JsonKey(name: 'total_likes')
  String? totalLikes;
  @JsonKey(name: 'liked')
  bool liked;
  @JsonKey(name: 'total_post_comments')
  String? totalPostComments;
  @JsonKey(name: 'distance_miles')
  double? distanceMiles;
  String verified;
  String discount;
  String hyperlink;
  @JsonKey(name: 'event_ticket_type')
  String eventTicketType;
  @JsonKey(name: 'business_identification_no')
  String businessIdentificationNumber;
   bool isFavourite;
  @JsonKey(name: 'business_type')
  BusinessType? businessType;


   Business({
     this.businessType,
     this.fourthImage='',
     this.fifthImage='',
     this.sixthImage='',
    this.isFavourite=false,
    this.zip="",
    this.address="",
    this.state="",
    this.city="",
    this.liked=false,
    this.totalLikes,
    this.totalPostComments,
    this.businessIdentificationNumber="1D9032ML9239",
    this.discount="",
    this.verified="No",
    this.businessLogo="",
    this.eventTicketType="",
    this.hyperlink="",
    this.distanceMiles,
    this.timeAgo,
    this.firstThumbNail,
    this.secondThumbNail,
    this.thirdThumbNail,
    this.list,
    this.removedTickets,
    this.businessLat,
    this.businessLong,
    this.businessId,
    this.status,
    this.title = '',
    this.usersId = 0,
    this.description="",
    required this.eventAddress,
    this.firstImage = "",
    this.firstVideo = "",
    this.secondImage = "",
    this.secondVideo = "",
    this.thirdImage = "",
    this.thirdVideo = "",
    this.first_video_thumbnail = "",
    this.second_video_thumbnail = "",
    this.third_video_thumbnail= "",
    this.createdAt,
    this.organizerProfilePicture,
    this.organizerUserName
  });


  Map<String, dynamic> toJson() => _$BusinessToJson(this);

 factory Business.fromJson(json) => _$BusinessFromJson(json);

}
