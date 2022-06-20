import 'package:connevents/utils/const.dart';
import 'package:retrofit/retrofit.dart';
import '_config.dart';
part   'create-event-service.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class CreateEventService {
  factory CreateEventService() => _CreateEventService(defaultDio);

  // @POST('persons')
  // Future<Profile> register(@Body() Map<String,dynamic> profile);
  //
  // @PATCH('persons')
  // Future<Profile> update(@Body()  Profile profile);
  // @POST('login')
  // Future<dynamic> signIn(@Body() Map<String,dynamic> data);
  // @GET('tours/get/all')
  // Future<HomeMenu> getAllTours({
  //   @Query('guide_id') int id,
  //   @Query('activation') String activation,
  //   @Query('search') String search});

  // @GET('get_busineess_detail')
  // Future<CreateEventModel> get({
  //   @Query('business_id') int businessId,
  //   @Query('user_id')   int userId
  // } );
//
// @GET('tours/{id}')
// Future<TourResponse> get(@Path('id') int tourId);


}

