import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.status,
    required this.specificSubCategories,
  });

  String status;
  List<SpecificSubCategory> specificSubCategories;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        status: json["status"],
        specificSubCategories: List<SpecificSubCategory>.from(
            json["specific_sub_categories"]
                .map((x) => SpecificSubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "specific_sub_categories":
            List<dynamic>.from(specificSubCategories.map((x) => x.toJson())),
      };
}

class SpecificSubCategory {
  SpecificSubCategory({
    required this.categoriesId,
    required this.category,
    required this.status,
    required this.subcategories,
  });

  String categoriesId;
  String category;
  String status;
  List<Subcategory> subcategories;

  factory SpecificSubCategory.fromJson(Map<String, dynamic> json) =>
      SpecificSubCategory(
        categoriesId: json["categories_id"],
        category: json["category"],
        status: json["status"],
        subcategories: List<Subcategory>.from(
            json["subcategories"].map((x) => Subcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories_id": categoriesId,
        "category": category,
        "status": status,
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class Subcategory {
  Subcategory({
    required this.subCategoriesId,
    required this.categoriesId,
    required this.subCategory,
    required this.status,
  });

  String subCategoriesId;
  String categoriesId;
  String subCategory;
  String status;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        subCategoriesId: json["sub_categories_id"],
        categoriesId: json["categories_id"],
        subCategory: json["sub_category"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sub_categories_id": subCategoriesId,
        "categories_id": categoriesId,
        "sub_category": subCategory,
        "status": status,
      };
}
