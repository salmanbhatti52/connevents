// class PaymentService {
//
//   Dio dio=Dio();
//
//   var logger = Logger(printer: PrettyPrinter());
//
//   Future<dynamic> charge(Map<String, dynamic> data) async {
//     Map<String, dynamic> charge = {
//       "source": data["token"],
//       "amount": data["amount"],
//       "currency": data["currency"],
//     };
//     final response = await Dio.post('/stripe/payment/charge', charge);
//     if (response.containsKey("results")) {
//       return ChargeResult.fromMap(response["results"]);
//     } else {
//       String errorMessage = response["errors"][0]["description"];
//       return errorMessage;
//     }
//   }
// }