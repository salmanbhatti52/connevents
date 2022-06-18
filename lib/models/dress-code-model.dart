import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'dress-code-model.g.dart';

@JsonSerializable(includeIfNull: false)

class DressCodeModel extends BaseModelHive{
  String? status;
  List<DressCodeData>? data;
  DressCodeModel({this.status,this.data});

 Map<String,dynamic> toJson()=> _$DressCodeModelToJson(this);
factory DressCodeModel.fromJson(json)=> _$DressCodeModelFromJson(json);
}


@JsonSerializable(includeIfNull: false)
class DressCodeData extends BaseModelHive{
  @JsonKey(name: 'dress_code_id')
  int? dressCodeId;
  @JsonKey(name: 'dress_code')
  String? dressCode;
  @JsonKey(name:'dress_code_color')
  String? dressCodeColor;
  String? status;

DressCodeData({this.status,this.dressCode,this.dressCodeId,this.dressCodeColor});

 Map<String,dynamic> toJson()=> _$DressCodeDataToJson(this);
factory DressCodeData.fromJson(json)=> _$DressCodeDataFromJson(json);




@override
  bool operator ==(Object other) {
    if (other is DressCodeData) {
      return other.dressCodeId == dressCodeId &&
          dressCode == other.dressCode;
    }
    return false;
  }

  @override
  int get hashCode => dressCodeId.hashCode;




}