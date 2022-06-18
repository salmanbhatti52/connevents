
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'follower-model.g.dart';

@JsonSerializable(includeIfNull: false)

class FollowerModel extends BaseModelHive{
 String? status;
 @JsonKey(name:"total_followers")
 String? totalFollowers;
 List<FollowersList>? data;

 FollowerModel({this.totalFollowers,this.status,this.data});

   Map<String, dynamic> toJson() => _$FollowerModelToJson(this);

  factory FollowerModel.fromJson(json) => _$FollowerModelFromJson(json);
}



@JsonSerializable(includeIfNull: false)
class FollowersList extends BaseModelHive {

   @JsonKey(name:"follow_id")
   int? followId;
   @JsonKey(name:"following_to_user")
   int? followingToUser;
   @JsonKey(name:"followedByUser")
   int? followedByUser;
   @JsonKey(name:"user_name")
   String? userName;
   @JsonKey(name:"profile_picture")
   String? profilePicture;
   String? email;

   FollowersList({this.userName,this.email,this.profilePicture,this.followedByUser,this.followId,this.followingToUser});

      Map<String, dynamic> toJson() => _$FollowersListToJson(this);
      factory FollowersList.fromJson(json) => _$FollowersListFromJson(json);


}