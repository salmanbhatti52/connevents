
import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checked-in-event-detail-model.g.dart';

@JsonSerializable(includeIfNull: false)
class CheckedInEventDetail extends BaseModelHive{
  @JsonKey(name:'event_post_id')
  int? eventPostId;
  String? title;

  CheckedInEventDetail({this.eventPostId,this.title});

  Map<String, dynamic> toJson() => _$CheckedInEventDetailToJson(this);
  factory CheckedInEventDetail.fromJson(json) => _$CheckedInEventDetailFromJson(json);
  @override
  bool operator ==(Object other) {
    if (other is CheckedInEventDetail) {
      return other.eventPostId == eventPostId;
    }
    return false;
  }
  @override
  int get hashCode => eventPostId.hashCode;

}