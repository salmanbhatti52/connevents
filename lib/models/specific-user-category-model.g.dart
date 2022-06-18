// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific-user-category-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecificUserCategoryModelAdapter
    extends TypeAdapter<SpecificUserCategoryModel> {
  @override
  final int typeId = 132;

  @override
  SpecificUserCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpecificUserCategoryModel(
      status: fields[1] as String?,
      data: (fields[2] as List?)?.cast<UserCategoriesModel>(),
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, SpecificUserCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecificUserCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserCategoriesModelAdapter extends TypeAdapter<UserCategoriesModel> {
  @override
  final int typeId = 134;

  @override
  UserCategoriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCategoriesModel(
      event_type_id: fields[8] as int?,
      status: fields[5] as String?,
      category: fields[4] as String?,
      users_id: fields[3] as int?,
      user_category_id: fields[2] as int?,
      value: fields[7] as bool,
      category_type: fields[6] as String?,
      category_id: fields[1] as int?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, UserCategoriesModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.category_id)
      ..writeByte(2)
      ..write(obj.user_category_id)
      ..writeByte(3)
      ..write(obj.users_id)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.category_type)
      ..writeByte(7)
      ..write(obj.value)
      ..writeByte(8)
      ..write(obj.event_type_id)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCategoriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificUserCategoryModel _$SpecificUserCategoryModelFromJson(
        Map<String, dynamic> json) =>
    SpecificUserCategoryModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserCategoriesModel.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$SpecificUserCategoryModelToJson(
    SpecificUserCategoryModel instance) {
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

UserCategoriesModel _$UserCategoriesModelFromJson(Map<String, dynamic> json) =>
    UserCategoriesModel(
      event_type_id: json['event_type_id'] as int?,
      status: json['status'] as String?,
      category: json['category'] as String?,
      users_id: json['users_id'] as int?,
      user_category_id: json['user_category_id'] as int?,
      value: json['value'] as bool? ?? true,
      category_type: json['category_type'] as String?,
      category_id: json['category_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserCategoriesModelToJson(UserCategoriesModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('category_id', instance.category_id);
  writeNotNull('user_category_id', instance.user_category_id);
  writeNotNull('users_id', instance.users_id);
  writeNotNull('category', instance.category);
  writeNotNull('status', instance.status);
  writeNotNull('category_type', instance.category_type);
  val['value'] = instance.value;
  writeNotNull('event_type_id', instance.event_type_id);
  return val;
}
