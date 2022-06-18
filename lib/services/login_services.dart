// import 'package:http/http.dart' as http;

// class LoginServices {
//   static var client = http.Client();

//   static Future fetchUserData() async {
//     var response = await client.post(
//         Uri.parse('https://dev.eigix.com/connevents/api/Webservices/login/'));
//     if (response.statusCode == 200) {
//       String jsonString;
//       jsonString = response.body;
//       return loginFromJson(jsonString);
//     } else {
//       return null;
//     }
//   }
// }
