import 'package:connevents/models/register_model.dart';
import 'package:http/http.dart' as http;

class RegisterServices {
  static var client = http.Client();

  static Future fetchRegisterData() async {
    var response = await client.post(
        Uri.parse('https://dev.eigix.com/connevents/api/Webservices/signup/'));
    //print('response is: ${response.body}');
    if (response.statusCode == 200) {
      String jsonString;
      jsonString = response.body;
      return registerFromJson(jsonString);
    } else {
      return null;
    }
  }
}
