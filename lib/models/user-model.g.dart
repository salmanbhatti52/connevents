// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 129;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      hint_flag: fields[2] as String,
      data: fields[3] as Data?,
      status: fields[1] as String?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.hint_flag)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 130;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      user: (fields[1] as List?)?.cast<UserDetail?>(),
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserDetailAdapter extends TypeAdapter<UserDetail> {
  @override
  final int typeId = 131;

  @override
  UserDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetail(
      first_name: fields[3] as String?,
      one_time_post_count: fields[20] as int,
      package_updated_at: fields[19] as String?,
      subscription_package_id: fields[18] as int?,
      profile_picture: fields[14] as String?,
      facebook_id: fields[17] as String?,
      google_access_token: fields[16] as String?,
      social_acc_type: fields[15] as String?,
      account_type: fields[13] as String?,
      status: fields[10] as String?,
      confirm_password: fields[8] as String?,
      date_added: fields[9] as String?,
      last_name: fields[4] as String?,
      password: fields[7] as String?,
      sub_categories_id: fields[12] as String?,
      verify_code: fields[11] as String?,
      email: fields[5] as String?,
      roles_id: fields[6] as int?,
      user_name: fields[2] as String?,
      users_id: fields[1] as int?,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, UserDetail obj) {
    writer
      ..writeByte(21)
      ..writeByte(1)
      ..write(obj.users_id)
      ..writeByte(2)
      ..write(obj.user_name)
      ..writeByte(3)
      ..write(obj.first_name)
      ..writeByte(4)
      ..write(obj.last_name)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.roles_id)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.confirm_password)
      ..writeByte(9)
      ..write(obj.date_added)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.verify_code)
      ..writeByte(12)
      ..write(obj.sub_categories_id)
      ..writeByte(13)
      ..write(obj.account_type)
      ..writeByte(14)
      ..write(obj.profile_picture)
      ..writeByte(15)
      ..write(obj.social_acc_type)
      ..writeByte(16)
      ..write(obj.google_access_token)
      ..writeByte(17)
      ..write(obj.facebook_id)
      ..writeByte(18)
      ..write(obj.subscription_package_id)
      ..writeByte(19)
      ..write(obj.package_updated_at)
      ..writeByte(20)
      ..write(obj.one_time_post_count)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      oneSignalId: json['oneSignalId'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      hint_flag: json['hint_flag'] as String? ?? "",
      firstName: json['firstName'] as String?,
      data: json['data'] == null ? null : Data.fromJson(json['data']),
      status: json['status'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      userPassword: json['userPassword'] as String?,
      userEmail: json['userEmail'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userName', instance.userName);
  writeNotNull('userEmail', instance.userEmail);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('userPassword', instance.userPassword);
  writeNotNull('confirmPassword', instance.confirmPassword);
  writeNotNull('oneSignalId', instance.oneSignalId);
  writeNotNull('status', instance.status);
  val['hint_flag'] = instance.hint_flag;
  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      user: (json['user'] as List<dynamic>?)
          ?.map((e) => e == null ? null : UserDetail.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user', instance.user);
  return val;
}

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
      first_name: json['first_name'] as String?,
      one_time_post_count: json['one_time_post_count'] as int? ?? 0,
      package_updated_at: json['package_updated_at'] as String?,
      subscription_package_id: json['subscription_package_id'] as int?,
      profile_picture: json['profile_picture'] as String?,
      facebook_id: json['facebook_id'] as String?,
      google_access_token: json['google_access_token'] as String?,
      social_acc_type: json['social_acc_type'] as String?,
      account_type: json['account_type'] as String?,
      status: json['status'] as String?,
      confirm_password: json['confirm_password'] as String?,
      date_added: json['date_added'] as String?,
      last_name: json['last_name'] as String?,
      password: json['password'] as String?,
      sub_categories_id: json['sub_categories_id'] as String?,
      verify_code: json['verify_code'] as String?,
      email: json['email'] as String?,
      roles_id: json['roles_id'] as int?,
      user_name: json['user_name'] as String?,
      users_id: json['users_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('users_id', instance.users_id);
  writeNotNull('user_name', instance.user_name);
  writeNotNull('first_name', instance.first_name);
  writeNotNull('last_name', instance.last_name);
  writeNotNull('email', instance.email);
  writeNotNull('roles_id', instance.roles_id);
  writeNotNull('password', instance.password);
  writeNotNull('confirm_password', instance.confirm_password);
  writeNotNull('date_added', instance.date_added);
  writeNotNull('status', instance.status);
  writeNotNull('verify_code', instance.verify_code);
  writeNotNull('sub_categories_id', instance.sub_categories_id);
  writeNotNull('account_type', instance.account_type);
  writeNotNull('profile_picture', instance.profile_picture);
  writeNotNull('social_acc_type', instance.social_acc_type);
  writeNotNull('google_access_token', instance.google_access_token);
  writeNotNull('facebook_id', instance.facebook_id);
  writeNotNull('subscription_package_id', instance.subscription_package_id);
  writeNotNull('package_updated_at', instance.package_updated_at);
  val['one_time_post_count'] = instance.one_time_post_count;
  return val;
}
