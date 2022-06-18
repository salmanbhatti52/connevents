import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'event-service.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class EventService {
  factory EventService() => _EventService(defaultDio);


@POST('get_event_posts')
Future<CreateEventModel> post(@Body()   Map<String, dynamic> offset);

}

