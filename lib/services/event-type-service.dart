import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'event-type-service.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class EventTypeService {
  factory EventTypeService() => _EventTypeService(defaultDio);


@GET('event_types')
Future<EventTypeList> get();


}

