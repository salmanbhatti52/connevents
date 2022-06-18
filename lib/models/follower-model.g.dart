// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerModel _$FollowerModelFromJson(Map<String, dynamic> json) =>
    FollowerModel(
      totalFollowers: json['total_followers'] as String?,
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FollowersList.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$FollowerModelToJson(FollowerModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('total_followers', instance.totalFollowers);
  writeNotNull('data', instance.data);
  return val;
}

FollowersList _$FollowersListFromJson(Map<String, dynamic> json) =>
    FollowersList(
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
      followedByUser: json['followedByUser'] as int?,
      followId: json['follow_id'] as int?,
      followingToUser: json['following_to_user'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$FollowersListToJson(FollowersList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('follow_id', instance.followId);
  writeNotNull('following_to_user', instance.followingToUser);
  writeNotNull('followedByUser', instance.followedByUser);
  writeNotNull('user_name', instance.userName);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('email', instance.email);
  return val;
}
