// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my-event-library-items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEventLibraryItems _$MyEventLibraryItemsFromJson(Map<String, dynamic> json) =>
    MyEventLibraryItems(
      thumbnailName: json['thumbnail_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      isLiked: json['is_liked'] as bool? ?? false,
      totalLikesOnItem: json['total_likes_on_item'] as int?,
      eventPostId: json['event_post_id'] as int?,
      usersId: json['users_id'] as int?,
      eventLibraryItemId: json['event_library_item_id'] as int?,
      fileName: json['file_name'] as String?,
      fileType: json['file_type'] as String?,
      postUserId: json['post_user_id'] as int?,
      postUserName: json['post_user_name'] as String?,
      uploadedDateTime: json['uploaded_datetime'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$MyEventLibraryItemsToJson(MyEventLibraryItems instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('event_library_item_id', instance.eventLibraryItemId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('file_name', instance.fileName);
  writeNotNull('file_type', instance.fileType);
  writeNotNull('uploaded_datetime', instance.uploadedDateTime);
  writeNotNull('post_user_id', instance.postUserId);
  writeNotNull('post_user_name', instance.postUserName);
  writeNotNull('profile_picture', instance.profilePicture);
  writeNotNull('total_likes_on_item', instance.totalLikesOnItem);
  val['is_liked'] = instance.isLiked;
  writeNotNull('thumbnail_name', instance.thumbnailName);
  return val;
}
