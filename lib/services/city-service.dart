import 'package:connevents/models/cities-model.dart';
import 'package:connevents/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'city-service.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class CityService {
  factory CityService() => _CityService(defaultDio);


@GET('get_event_cities')
Future<CityData> get();


}
