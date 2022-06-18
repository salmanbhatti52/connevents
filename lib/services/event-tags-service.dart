import 'package:connevents/models/event-tags-model.dart';
import 'package:connevents/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'event-tags-service.g.dart';


@RestApi(baseUrl: apiUrl)
abstract class EventTagsService {
  factory EventTagsService() => _EventTagsService(defaultDio);

@GET('get_all_tags')
Future<EventTagsModel> get();

@GET('get_all_tags_with_custom')
Future<EventTagsModel> getTags();

}

