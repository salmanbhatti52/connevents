import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-ticket-model.dart';
import 'package:connevents/models/host-room-model.dart';
import 'package:connevents/models/model.dart';
import 'package:connevents/models/event-tags-model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dress-code-model.dart';
import 'event-type-model.dart';
import 'model.dart';

part 'create-event-model.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateEventModel extends BaseModelHive {
  String? status;
  EventData? data;

  CreateEventModel({this.data, this.status});

  Map<String, dynamic> toJson() => _$CreateEventModelToJson(this);

  factory CreateEventModel.fromJson(json) => _$CreateEventModelFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class EventData extends BaseModelHive {
  List<EventDetail>? event;

  EventData({this.event});

  Map<String, dynamic> toJson() => _$EventDataToJson(this);

  factory EventData.fromJson(json) => _$EventDataFromJson(json);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class EventDetail extends BaseModelHive {

  @JsonKey(name: 'organizer_user_name')
  String? organizerUserName;
  @JsonKey(name: 'organizer_profile_picture')
  String? organizerProfilePicture;
  @JsonKey(name: 'event_post_id')
  num? eventPostId;
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
  @JsonKey(name: 'first_video')
  String firstVideo;
  String first_video_thumbnail;
  @JsonKey(name: 'second_video')
  String secondVideo;
  String second_video_thumbnail;
  @JsonKey(name: 'third_video')
  String thirdVideo;
  String third_video_thumbnail;
  @JsonKey(name: 'event_type_id')
  int eventTypeId;
  @JsonKey(name: 'category_id')
  int categoryId;
  DateTime? pickedEventStartDate;
  DateTime? pickedEventEndDate;
  DateTime? pickedSalesStartDate;
  DateTime? pickedSalesEndDate;
 @JsonKey(name: 'event_start_date')
  String eventStartDate;
 @JsonKey(name: 'event_start_time')
  String eventStartTime;
 @JsonKey(name: 'event_end_date')
  String eventEndDate;
 @JsonKey(name: 'event_end_time')
  String eventEndTime;
 @JsonKey(name: 'sales_start_date')
  String salesStartDate;
 @JsonKey(name: 'sales_start_time')
  String salesStartTime;
 @JsonKey(name: 'sales_end_date')
  String salesEndDate;
 @JsonKey(name: 'sales_end_time')
  String salesEndTime;
  String? description;
  @JsonKey(name: 'discount_percent')
  String? discountPercent;
  @JsonKey(name: 'min_tickets_discount')
  String? minTicketsDiscount;
  int refundable;
  @JsonKey(name: 'table_service')
  int tableService;
  @JsonKey(name: 'business_logo')
  String businessLogo;
  @JsonKey(name: 'tbl_four_people_cost')
  String tblFourPeopleCost;
  @JsonKey(name: 'tbl_six_people_cost')
  String tblSixPeopleCost;
  @JsonKey(name: 'tbl_eight_people_cost')
  String tblEightPeopleCost;
  String? selectedTblFivePeopleCost;
  @JsonKey(name: 'tbl_ten_people_cost')
  String tblTenPeopleCost;
  String? selectedTblTenPeopleCost;
  @JsonKey(name: 'dress_code_id')
  int? dressCodeId;
  String? status;
  @JsonKey(name: 'location_long')
  double? locationLong;
  @JsonKey(name: 'location_lat')
  double? locationLat;
  @JsonKey(name: 'event_type')
  EventTypes? eventTypeData;
  @JsonKey(name: 'dress_code')
  DressCodeData? dressCode;
  EventTypeCategories? category;
  DressCodeData? dressCodeData;
  @JsonKey(name: 'event_tags')
  List<TagsData>? eventTags;
  List<String>? customEventTags;
  List<String>? showTags;
  List<String>? mixTags;
  TagsData? eventTagsData;
  @JsonKey(name: 'event_tickets')
  List<EventTicket> eventTickets;
  @JsonKey(name: 'event_address')
  EventAddress? eventAddress;
  @JsonKey(name: 'Early_bird')
  EarlyBird? earlyBird;
  @JsonKey(name: 'Regular')
  Regular? regular;
  @JsonKey(name: 'VIP')
  VIP? vip;
  @JsonKey(name: 'skipping_line')
  SkippingLine? skippingLine;
  List? list;
  List? removedTickets;
  bool isTableAvailableFor4People;
  bool isTableAvailableFor6People;
  bool isTableAvailableFor8People;
  bool isTableAvailableFor10People;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'time_ago')
  String? timeAgo;
  String? liked;
  @JsonKey(name: 'total_likes')
  int? totalLikes;
  @JsonKey(name: 'distance_miles')
  String? distanceMiles;
  @JsonKey(name: 'early_bird_available')
  int earlyBirdAvailable;
  @JsonKey(name: 'regular_available')
  int? regularAvailable;
  @JsonKey(name: 'vip_available')
  int? vipAvailable;
  @JsonKey(name: 'skipping_line_available')
  int? skippingLineAvailable;
  @JsonKey(name: 'total_available_ticket_quantity')
  int? totalAvailableTicketQuantity;
  @JsonKey(name: 'sales_end_datetime')
  String? salesEndDatetime;
  String? isFavourite;
  @JsonKey(name: 'total_post_comments')
  String? totalPostComments;
  @JsonKey(name: 'dress_code_color_code')
  String? dressCodeColor;
  @JsonKey(name: 'user_checkedin')
  bool userCheckedIn;
  @JsonKey(name: 'is_room_created')
  bool isRoomCreated;
  String token;
  @JsonKey(name: 'meeting_code')
  String meetingCode;
  @JsonKey(name: 'is_social_event')
  bool isSocialEvent;
  bool isFreeEvent;
  bool isMyEvent;
  bool isNotMyEvent;
  String verified;
  String discount;
  @JsonKey(name: 'hyperlink_not_my_event')
  String hyperlink;
  @JsonKey(name: 'event_ticket_type')
  String eventTicketType;
  @JsonKey(name: 'is_following')
  bool isFollowing;
  @JsonKey(name: 'total_followers')
  String totalFollowers;
  @JsonKey(name: 'room_details')
  HostRoom? roomDetails;
  @JsonKey(name: 'total_unread_messages_count')
  int? totalUnreadMessagesCount;
  @JsonKey(name: 'is_basic')
  bool isBasic;
  @JsonKey(name: 'is_peeks_available')
  bool isPeeksAvailable;
  @JsonKey(name: 'is_editable_event')
  bool isEditableEvent;
  @JsonKey(name: 'is_admin')
  bool isAdmin;
  String socialLink;

  EventDetail({
    this.mixTags,
    this.showTags,
    this.customEventTags,
    this.isAdmin=false,
    this.isEditableEvent=false,
    this.isPeeksAvailable=false,
    this.isBasic=false,
    this.totalUnreadMessagesCount,
    this.roomDetails,
    this.tblFourPeopleCost="",
    this.tblEightPeopleCost="",
    this.tblSixPeopleCost="",
    this.selectedTblFivePeopleCost,
    this.totalFollowers="",
    this.isFollowing=false,
    this.discount="",
    this.verified="No",
    this.businessLogo="",
    this.eventTicketType="",
    this.isNotMyEvent=false,
    this.hyperlink="",
    this.isMyEvent=false,
    this.isFreeEvent=false,
    this.isSocialEvent=false,
    this.token="",
    this.meetingCode="",
    this.isRoomCreated=false,
    this.userCheckedIn=false,
    this.selectedTblTenPeopleCost,
    this.dressCodeColor,
    this.totalPostComments,
    this.isFavourite,
    this.salesEndDatetime,
    this.regularAvailable=0,
    this.earlyBirdAvailable=0,
    this.vipAvailable=0,
    this.skippingLineAvailable,
    this.totalAvailableTicketQuantity,
    this.distanceMiles,
    this.totalLikes,
    this.liked,
    this.eventTagsData,
    this.timeAgo,
    this.firstThumbNail,
    this.secondThumbNail,
    this.thirdThumbNail,
    this.isTableAvailableFor4People=false,
    this.isTableAvailableFor6People=false,
    this.isTableAvailableFor8People=false,
    this.isTableAvailableFor10People=false,
    this.list,
    this.removedTickets,
    required this.earlyBird,
    required this.regular,
    required  this.vip,
    required  this.skippingLine,
    this.tableService=0,
    this.tblTenPeopleCost="",
    this.pickedEventStartDate,
    this.pickedEventEndDate,
    this.pickedSalesStartDate,
    this.pickedSalesEndDate,
    this.locationLat,
    this.locationLong,
    this.eventPostId,
    this.status,
    this.dressCodeId,
    this.dressCode,
    this.dressCodeData,
   // this.eventTypeData,
    this.category,
    this.title = '',
    this.eventTypeData,
    this.categoryId = 0,
    this.eventTypeId = 0,
    this.usersId = 0,
    this.description,
    this.discountPercent,
    this.minTicketsDiscount,
    required this.eventAddress,
    this.eventEndDate = "",
    this.eventEndTime = "",
    this.eventStartDate = "",
    this.eventStartTime = "",
    this.salesEndDate = "",
    this.salesEndTime = "",
    this.salesStartDate = "",
    this.salesStartTime = "",
    this.eventTags,
    this.eventTickets = const [],
    this.firstImage = "",
    this.firstVideo = "",
    this.refundable = 0,
    this.secondImage = "",
    this.secondVideo = "",
    this.thirdImage = "",
    this.thirdVideo = "",
    this.first_video_thumbnail = "",
    this.second_video_thumbnail = "",
    this.third_video_thumbnail= "",
    this.createdAt,
    this.organizerProfilePicture,
    this.organizerUserName,
    this.socialLink="",
  }) {
   // this.pickedEventStartDate= pickedEventStartDate ?? DateTime.now();
   // this.pickedEventEndDate= pickedEventEndDate ?? DateTime.now();
   // this.pickedSalesStartDate= pickedSalesStartDate ?? DateTime.now();
   // this.pickedSalesEndDate= pickedSalesEndDate ?? DateTime.now();
}


  Map<String, dynamic> toJson() => _$EventDetailToJson(this);

  factory EventDetail.fromJson(json) => _$EventDetailFromJson(json);
}
