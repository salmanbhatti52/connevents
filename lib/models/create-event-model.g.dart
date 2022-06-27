// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-event-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventModel _$CreateEventModelFromJson(Map<String, dynamic> json) =>
    CreateEventModel(
      data: json['data'] == null ? null : EventData.fromJson(json['data']),
      status: json['status'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$CreateEventModelToJson(CreateEventModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

EventData _$EventDataFromJson(Map<String, dynamic> json) => EventData(
      event: (json['event'] as List<dynamic>?)
          ?.map((e) => EventDetail.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventDataToJson(EventData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('event', instance.event);
  return val;
}

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => EventDetail(
      isAdmin: json['is_admin'] as bool? ?? false,
      isEditableEvent: json['is_editable_event'] as bool? ?? false,
      isPeeksAvailable: json['is_peeks_available'] as bool? ?? false,
      isBasic: json['is_basic'] as bool? ?? false,
      totalUnreadMessagesCount: json['total_unread_messages_count'] as int?,
      roomDetails: json['room_details'] == null
          ? null
          : HostRoom.fromJson(json['room_details']),
      tblFourPeopleCost: json['tbl_four_people_cost'] as String? ?? "",
      tblEightPeopleCost: json['tbl_eight_people_cost'] as String? ?? "",
      tblSixPeopleCost: json['tbl_six_people_cost'] as String? ?? "",
      selectedTblFivePeopleCost: json['selectedTblFivePeopleCost'] as String?,
      totalFollowers: json['total_followers'] as String? ?? "",
      isFollowing: json['is_following'] as bool? ?? false,
      discount: json['discount'] as String? ?? "",
      verified: json['verified'] as String? ?? "No",
      businessLogo: json['business_logo'] as String? ?? "",
      eventTicketType: json['event_ticket_type'] as String? ?? "",
      isNotMyEvent: json['isNotMyEvent'] as bool? ?? false,
      hyperlink: json['hyperlink_not_my_event'] as String? ?? "",
      isMyEvent: json['isMyEvent'] as bool? ?? false,
      isFreeEvent: json['isFreeEvent'] as bool? ?? false,
      isSocialEvent: json['is_social_event'] as bool? ?? false,
      token: json['token'] as String? ?? "",
      meetingCode: json['meeting_code'] as String? ?? "",
      isRoomCreated: json['is_room_created'] as bool? ?? false,
      userCheckedIn: json['user_checkedin'] as bool? ?? false,
      selectedTblTenPeopleCost: json['selectedTblTenPeopleCost'] as String?,
      dressCodeColor: json['dress_code_color_code'] as String?,
      totalPostComments: json['total_post_comments'] as String?,
      isFavourite: json['isFavourite'] as String?,
      salesEndDatetime: json['sales_end_datetime'] as String?,
      regularAvailable: json['regular_available'] as int? ?? 0,
      earlyBirdAvailable: json['early_bird_available'] as int? ?? 0,
      vipAvailable: json['vip_available'] as int? ?? 0,
      skippingLineAvailable: json['skipping_line_available'] as int?,
      totalAvailableTicketQuantity:
          json['total_available_ticket_quantity'] as int?,
      distanceMiles: json['distance_miles'] as String?,
      totalLikes: json['total_likes'] as int?,
      liked: json['liked'] as String?,
      eventTagsData: json['eventTagsData'] == null
          ? null
          : TagsData.fromJson(json['eventTagsData']),
      timeAgo: json['time_ago'] as String?,
      firstThumbNail: json['firstThumbNail'] as String?,
      secondThumbNail: json['secondThumbNail'] as String?,
      thirdThumbNail: json['thirdThumbNail'] as String?,
      isTableAvailableFor4People:
          json['isTableAvailableFor4People'] as bool? ?? false,
      isTableAvailableFor6People:
          json['isTableAvailableFor6People'] as bool? ?? false,
      isTableAvailableFor8People:
          json['isTableAvailableFor8People'] as bool? ?? false,
      isTableAvailableFor10People:
          json['isTableAvailableFor10People'] as bool? ?? false,
      list: json['list'] as List<dynamic>?,
      removedTickets: json['removedTickets'] as List<dynamic>?,
      earlyBird: json['Early_bird'] == null
          ? null
          : EarlyBird.fromJson(json['Early_bird']),
      regular:
          json['Regular'] == null ? null : Regular.fromJson(json['Regular']),
      vip: json['VIP'] == null ? null : VIP.fromJson(json['VIP']),
      skippingLine: json['skipping_line'] == null
          ? null
          : SkippingLine.fromJson(json['skipping_line']),
      tableService: json['table_service'] as int? ?? 0,
      tblTenPeopleCost: json['tbl_ten_people_cost'] as String? ?? "",
      pickedEventStartDate: json['pickedEventStartDate'] == null
          ? null
          : DateTime.parse(json['pickedEventStartDate'] as String),
      pickedEventEndDate: json['pickedEventEndDate'] == null
          ? null
          : DateTime.parse(json['pickedEventEndDate'] as String),
      pickedSalesStartDate: json['pickedSalesStartDate'] == null
          ? null
          : DateTime.parse(json['pickedSalesStartDate'] as String),
      pickedSalesEndDate: json['pickedSalesEndDate'] == null
          ? null
          : DateTime.parse(json['pickedSalesEndDate'] as String),
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      locationLong: (json['location_long'] as num?)?.toDouble(),
      eventPostId: json['event_post_id'] as num?,
      status: json['status'] as String?,
      dressCodeId: json['dress_code_id'] as int?,
      dressCode: json['dress_code'] == null
          ? null
          : DressCodeData.fromJson(json['dress_code']),
      dressCodeData: json['dressCodeData'] == null
          ? null
          : DressCodeData.fromJson(json['dressCodeData']),
      category: json['category'] == null
          ? null
          : EventTypeCategories.fromJson(json['category']),
      title: json['title'] as String? ?? '',
      eventTypeData: json['event_type'] == null
          ? null
          : EventTypes.fromJson(json['event_type']),
      categoryId: json['category_id'] as int? ?? 0,
      eventTypeId: json['event_type_id'] as int? ?? 0,
      usersId: json['users_id'] as int? ?? 0,
      description: json['description'] as String?,
      discountPercent: json['discount_percent'] as String?,
      minTicketsDiscount: json['min_tickets_discount'] as String?,
      eventAddress: json['event_address'] == null
          ? null
          : EventAddress.fromJson(json['event_address']),
      eventEndDate: json['event_end_date'] as String? ?? "",
      eventEndTime: json['event_end_time'] as String? ?? "",
      eventStartDate: json['event_start_date'] as String? ?? "",
      eventStartTime: json['event_start_time'] as String? ?? "",
      salesEndDate: json['sales_end_date'] as String? ?? "",
      salesEndTime: json['sales_end_time'] as String? ?? "",
      salesStartDate: json['sales_start_date'] as String? ?? "",
      salesStartTime: json['sales_start_time'] as String? ?? "",
      eventTags: (json['event_tags'] as List<dynamic>?)
          ?.map((e) => TagsData.fromJson(e))
          .toList(),
      eventTickets: (json['event_tickets'] as List<dynamic>?)
              ?.map((e) => EventTicket.fromJson(e))
              .toList() ??
          const [],
      firstImage: json['first_image'] as String? ?? "",
      firstVideo: json['first_video'] as String? ?? "",
      refundable: json['refundable'] as int? ?? 0,
      secondImage: json['second_image'] as String? ?? "",
      secondVideo: json['second_video'] as String? ?? "",
      thirdImage: json['third_image'] as String? ?? "",
      thirdVideo: json['third_video'] as String? ?? "",
      first_video_thumbnail: json['first_video_thumbnail'] as String? ?? "",
      second_video_thumbnail: json['second_video_thumbnail'] as String? ?? "",
      third_video_thumbnail: json['third_video_thumbnail'] as String? ?? "",
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      organizerProfilePicture: json['organizer_profile_picture'] as String?,
      organizerUserName: json['organizer_user_name'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('organizer_user_name', instance.organizerUserName);
  writeNotNull('organizer_profile_picture', instance.organizerProfilePicture);
  writeNotNull('event_post_id', instance.eventPostId);
  val['users_id'] = instance.usersId;
  val['title'] = instance.title;
  writeNotNull('firstThumbNail', instance.firstThumbNail);
  writeNotNull('secondThumbNail', instance.secondThumbNail);
  writeNotNull('thirdThumbNail', instance.thirdThumbNail);
  val['first_image'] = instance.firstImage;
  val['second_image'] = instance.secondImage;
  val['third_image'] = instance.thirdImage;
  val['first_video'] = instance.firstVideo;
  val['first_video_thumbnail'] = instance.first_video_thumbnail;
  val['second_video'] = instance.secondVideo;
  val['second_video_thumbnail'] = instance.second_video_thumbnail;
  val['third_video'] = instance.thirdVideo;
  val['third_video_thumbnail'] = instance.third_video_thumbnail;
  val['event_type_id'] = instance.eventTypeId;
  val['category_id'] = instance.categoryId;
  writeNotNull(
      'pickedEventStartDate', instance.pickedEventStartDate?.toIso8601String());
  writeNotNull(
      'pickedEventEndDate', instance.pickedEventEndDate?.toIso8601String());
  writeNotNull(
      'pickedSalesStartDate', instance.pickedSalesStartDate?.toIso8601String());
  writeNotNull(
      'pickedSalesEndDate', instance.pickedSalesEndDate?.toIso8601String());
  val['event_start_date'] = instance.eventStartDate;
  val['event_start_time'] = instance.eventStartTime;
  val['event_end_date'] = instance.eventEndDate;
  val['event_end_time'] = instance.eventEndTime;
  val['sales_start_date'] = instance.salesStartDate;
  val['sales_start_time'] = instance.salesStartTime;
  val['sales_end_date'] = instance.salesEndDate;
  val['sales_end_time'] = instance.salesEndTime;
  writeNotNull('description', instance.description);
  writeNotNull('discount_percent', instance.discountPercent);
  writeNotNull('min_tickets_discount', instance.minTicketsDiscount);
  val['refundable'] = instance.refundable;
  val['table_service'] = instance.tableService;
  val['business_logo'] = instance.businessLogo;
  val['tbl_four_people_cost'] = instance.tblFourPeopleCost;
  val['tbl_six_people_cost'] = instance.tblSixPeopleCost;
  val['tbl_eight_people_cost'] = instance.tblEightPeopleCost;
  writeNotNull('selectedTblFivePeopleCost', instance.selectedTblFivePeopleCost);
  val['tbl_ten_people_cost'] = instance.tblTenPeopleCost;
  writeNotNull('selectedTblTenPeopleCost', instance.selectedTblTenPeopleCost);
  writeNotNull('dress_code_id', instance.dressCodeId);
  writeNotNull('status', instance.status);
  writeNotNull('location_long', instance.locationLong);
  writeNotNull('location_lat', instance.locationLat);
  writeNotNull('event_type', instance.eventTypeData?.toJson());
  writeNotNull('dress_code', instance.dressCode?.toJson());
  writeNotNull('category', instance.category?.toJson());
  writeNotNull('dressCodeData', instance.dressCodeData?.toJson());
  writeNotNull(
      'event_tags', instance.eventTags?.map((e) => e.toJson()).toList());
  writeNotNull('eventTagsData', instance.eventTagsData?.toJson());
  val['event_tickets'] = instance.eventTickets.map((e) => e.toJson()).toList();
  writeNotNull('event_address', instance.eventAddress?.toJson());
  writeNotNull('Early_bird', instance.earlyBird?.toJson());
  writeNotNull('Regular', instance.regular?.toJson());
  writeNotNull('VIP', instance.vip?.toJson());
  writeNotNull('skipping_line', instance.skippingLine?.toJson());
  writeNotNull('list', instance.list);
  writeNotNull('removedTickets', instance.removedTickets);
  val['isTableAvailableFor4People'] = instance.isTableAvailableFor4People;
  val['isTableAvailableFor6People'] = instance.isTableAvailableFor6People;
  val['isTableAvailableFor8People'] = instance.isTableAvailableFor8People;
  val['isTableAvailableFor10People'] = instance.isTableAvailableFor10People;
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('time_ago', instance.timeAgo);
  writeNotNull('liked', instance.liked);
  writeNotNull('total_likes', instance.totalLikes);
  writeNotNull('distance_miles', instance.distanceMiles);
  val['early_bird_available'] = instance.earlyBirdAvailable;
  writeNotNull('regular_available', instance.regularAvailable);
  writeNotNull('vip_available', instance.vipAvailable);
  writeNotNull('skipping_line_available', instance.skippingLineAvailable);
  writeNotNull(
      'total_available_ticket_quantity', instance.totalAvailableTicketQuantity);
  writeNotNull('sales_end_datetime', instance.salesEndDatetime);
  writeNotNull('isFavourite', instance.isFavourite);
  writeNotNull('total_post_comments', instance.totalPostComments);
  writeNotNull('dress_code_color_code', instance.dressCodeColor);
  val['user_checkedin'] = instance.userCheckedIn;
  val['is_room_created'] = instance.isRoomCreated;
  val['token'] = instance.token;
  val['meeting_code'] = instance.meetingCode;
  val['is_social_event'] = instance.isSocialEvent;
  val['isFreeEvent'] = instance.isFreeEvent;
  val['isMyEvent'] = instance.isMyEvent;
  val['isNotMyEvent'] = instance.isNotMyEvent;
  val['verified'] = instance.verified;
  val['discount'] = instance.discount;
  val['hyperlink_not_my_event'] = instance.hyperlink;
  val['event_ticket_type'] = instance.eventTicketType;
  val['is_following'] = instance.isFollowing;
  val['total_followers'] = instance.totalFollowers;
  writeNotNull('room_details', instance.roomDetails?.toJson());
  writeNotNull(
      'total_unread_messages_count', instance.totalUnreadMessagesCount);
  val['is_basic'] = instance.isBasic;
  val['is_peeks_available'] = instance.isPeeksAvailable;
  val['is_editable_event'] = instance.isEditableEvent;
  val['is_admin'] = instance.isAdmin;
  return val;
}
