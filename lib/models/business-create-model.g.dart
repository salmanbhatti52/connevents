// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business-create-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCreateModel _$BusinessCreateModelFromJson(Map<String, dynamic> json) =>
    BusinessCreateModel(
      data: json['data'] == null ? null : Business.fromJson(json['data']),
      status: json['status'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$BusinessCreateModelToJson(BusinessCreateModel instance) {
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

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      businessType: json['business_type'] == null
          ? null
          : BusinessType.fromJson(json['business_type']),
      fourthImage: json['fourth_image'] as String? ?? '',
      fifthImage: json['fifth_image'] as String? ?? '',
      sixthImage: json['sixth_image'] as String? ?? '',
      isFavourite: json['isFavourite'] as bool? ?? false,
      zip: json['zip'] as String? ?? "",
      address: json['address'] as String? ?? "",
      state: json['state'] as String? ?? "",
      city: json['city'] as String? ?? "",
      liked: json['liked'] as bool? ?? false,
      totalLikes: json['total_likes'] as String?,
      totalPostComments: json['total_post_comments'] as String?,
      businessIdentificationNumber:
          json['business_identification_no'] as String? ?? "1D9032ML9239",
      discount: json['discount'] as String? ?? "",
      verified: json['verified'] as String? ?? "No",
      businessLogo: json['business_logo'] as String? ?? "",
      eventTicketType: json['event_ticket_type'] as String? ?? "",
      hyperlink: json['hyperlink'] as String? ?? "",
      distanceMiles: json['distance_miles'] as String?,
      timeAgo: json['time_ago'] as String?,
      firstThumbNail: json['firstThumbNail'] as String?,
      secondThumbNail: json['secondThumbNail'] as String?,
      thirdThumbNail: json['thirdThumbNail'] as String?,
      list: json['list'] as List<dynamic>?,
      removedTickets: json['removedTickets'] as List<dynamic>?,
      businessLat: (json['business_lat'] as num?)?.toDouble(),
      businessLong: (json['business_long'] as num?)?.toDouble(),
      businessId: json['business_id'] as num?,
      status: json['status'] as String?,
      title: json['title'] as String? ?? '',
      usersId: json['users_id'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      eventAddress: json['event_address'] == null
          ? null
          : EventAddress.fromJson(json['event_address']),
      firstImage: json['first_image'] as String? ?? "",
      firstVideo: json['first_video'] as String? ?? "",
      secondImage: json['second_image'] as String? ?? "",
      secondVideo: json['second_video'] as String? ?? "",
      thirdImage: json['third_image'] as String? ?? "",
      thirdVideo: json['third_video'] as String? ?? "",
      first_video_thumbnail: json['first_video_thumbnail'] as String? ?? "",
      second_video_thumbnail: json['second_video_thumbnail'] as String? ?? "",
      third_video_thumbnail: json['third_video_thumbnail'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      organizerProfilePicture: json['organize_profile_picture'] as String?,
      organizerUserName: json['organizer_user_name'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$BusinessToJson(Business instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('organizer_user_name', instance.organizerUserName);
  writeNotNull('organize_profile_picture', instance.organizerProfilePicture);
  writeNotNull('business_id', instance.businessId);
  val['users_id'] = instance.usersId;
  val['title'] = instance.title;
  writeNotNull('firstThumbNail', instance.firstThumbNail);
  writeNotNull('secondThumbNail', instance.secondThumbNail);
  writeNotNull('thirdThumbNail', instance.thirdThumbNail);
  val['first_image'] = instance.firstImage;
  val['second_image'] = instance.secondImage;
  val['third_image'] = instance.thirdImage;
  val['fourth_image'] = instance.fourthImage;
  val['fifth_image'] = instance.fifthImage;
  val['sixth_image'] = instance.sixthImage;
  val['first_video'] = instance.firstVideo;
  val['first_video_thumbnail'] = instance.first_video_thumbnail;
  val['second_video'] = instance.secondVideo;
  val['second_video_thumbnail'] = instance.second_video_thumbnail;
  val['third_video'] = instance.thirdVideo;
  val['third_video_thumbnail'] = instance.third_video_thumbnail;
  val['description'] = instance.description;
  val['business_logo'] = instance.businessLogo;
  writeNotNull('status', instance.status);
  writeNotNull('business_long', instance.businessLong);
  writeNotNull('business_lat', instance.businessLat);
  writeNotNull('event_address', instance.eventAddress?.toJson());
  val['city'] = instance.city;
  val['state'] = instance.state;
  val['zip'] = instance.zip;
  val['address'] = instance.address;
  writeNotNull('list', instance.list);
  writeNotNull('removedTickets', instance.removedTickets);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('time_ago', instance.timeAgo);
  writeNotNull('total_likes', instance.totalLikes);
  val['liked'] = instance.liked;
  writeNotNull('total_post_comments', instance.totalPostComments);
  writeNotNull('distance_miles', instance.distanceMiles);
  val['verified'] = instance.verified;
  val['discount'] = instance.discount;
  val['hyperlink'] = instance.hyperlink;
  val['event_ticket_type'] = instance.eventTicketType;
  val['business_identification_no'] = instance.businessIdentificationNumber;
  val['isFavourite'] = instance.isFavourite;
  writeNotNull('business_type', instance.businessType?.toJson());
  return val;
}
