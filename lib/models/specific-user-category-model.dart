import 'package:connevents/models/model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'specific-user-category-model.g.dart';

@HiveType(typeId: 132)
@JsonSerializable(includeIfNull: false)
class SpecificUserCategoryModel extends BaseModelHive{
  @HiveField(1)
  String? status;
  @HiveField(2)
  List<UserCategoriesModel>? data;
  SpecificUserCategoryModel({this.status,this.data});
  Map<String,dynamic> toJson()=> _$SpecificUserCategoryModelToJson(this);
  factory SpecificUserCategoryModel.fromJson(json)=> _$SpecificUserCategoryModelFromJson(json);

}



@HiveType(typeId: 134)
@JsonSerializable(includeIfNull: false)
class UserCategoriesModel extends BaseModelHive{
    @HiveField(1)
  int? category_id;
    @HiveField(2)
  int? user_category_id;
   @HiveField(3)
  int? users_id;
    @HiveField(4)
  String? category;
    @HiveField(5)
    String? status;
      @HiveField(6)
  String? category_type;
    @HiveField(7)
      bool  value;
    @HiveField(8)
    int?  event_type_id;
  UserCategoriesModel({this.event_type_id,this.status,this.category,this.users_id,this.user_category_id,this.value=true,this.category_type,this.category_id});
  Map<String,dynamic> toJson()=> _$UserCategoriesModelToJson(this);
  factory UserCategoriesModel.fromJson(json)=> _$UserCategoriesModelFromJson(json);

}
