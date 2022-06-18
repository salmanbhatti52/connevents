// import 'package:connevents/models/model.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'model.dart';
//
// part 'category-model.g.dart';
//
// @JsonSerializable(includeIfNull: false)
// class CategoryModel extends BaseModelHive {
//   String? status;
//   List<CategoryData>? data;
//
//   CategoryModel({this.status, this.data});
//
//   Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
//
//   factory CategoryModel.fromJson(json) => _$CategoryModelFromJson(json);
// }
//
// @JsonSerializable(includeIfNull: false)
// class CategoryData extends BaseModelHive {
//   @JsonKey(name: 'category_id')
//   int? categoryId;
//   @JsonKey(name: 'user_category_id')
//   int? userCategoryId;
//   @JsonKey(name: 'usersId')
//   int? usersId;
//   String? category;
//   String? status;
//   @JsonKey(name: 'category_type')
//   String? categoryType;
//   bool value;
//
//   CategoryData(
//       {this.status,
//       this.category,
//       this.value = false,
//       this.categoryType,
//       this.categoryId});
//
//   Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
//
//   factory CategoryData.fromJson(json) => _$CategoryDataFromJson(json);
//
//   @override
//   bool operator ==(Object other) {
//     if (other is CategoryData) {
//       return other.categoryId == categoryId &&
//           userCategoryId == other.userCategoryId;
//     }
//     return false;
//   }
//
//   @override
//   int get hashCode => categoryId.hashCode;
// }
