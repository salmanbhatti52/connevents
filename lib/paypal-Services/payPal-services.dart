import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:http_auth/http_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PayPalServices{
 // String domain='https://api.sandbox.paypal.com';
  //String clientId = 'ATk_blwcyxAi3luRCvJdmYYtt9lumgdP7zcNWx75rTN04CHan2dgv4_vDp_upRSbPzrRzFUdDoajFot0';
  //String secret   = 'EImfCGc6Sl06DL2qVUo5_OPxRDxKLe6uvBzGVadhwFgoG_84obcVOQv2ndtE8hpH_10mBvXebvuvnsjW';
  var payPalBody;

  Future<String> getAccessToken() async{
    
    var payPalResponse   =await http.get(Uri.parse('${apiUrl}get_paypal_config'));
     payPalBody = convert.jsonDecode(payPalResponse.body);
     print("PaPalBody");
     print(payPalBody['data']);
    print("PaPalBody");

     if(payPalBody!=null){
       try{
         var client= BasicAuthClient(payPalBody['data']['client_id'] , payPalBody['data']['secret']);
         var response =await client.post(Uri.parse('${payPalBody['data']['domain']}/v1/oauth2/token?grant_type=client_credentials'));
         if(response.statusCode==200){
           final body=convert.jsonDecode(response.body);
           return body['access_token'];
         }
       }catch(e){
         print(e.toString());
         rethrow;
       }
     }


    return "0";
  }

  Future<Map<String,String>> createPayPalPayment(transaction,accessToken) async{

    var res = convert.jsonEncode(transaction);
    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try{
      var response = await http.post(Uri.parse('${payPalBody['data']['domain']}/v1/payments/payment'),
          headers: headers,
        body: res
      );
       print("Body");
      print(response.body);
      print("Body");

      final body= convert.jsonDecode(response.body);
      if(response.statusCode==201){
        if(body['links']!=null && body['links'].length>0){
          List list=body['links'];
          String executeUrl="";
          String approvalUrl="";
          List links=body['links'];
          final item = links.firstWhere((element) => element['rel']=='approval_url',orElse: ()=>null);
          if(item!=null){
            approvalUrl=item['href'];
          }
          final item1 = links.firstWhere((element) => element['rel']=='execute',orElse: ()=>null);
          if(item1!=null){
            executeUrl=item1['href'];
          }
          return {"executeUrl":executeUrl,"approvalUrl": approvalUrl};
        }
        throw Exception('0');
      }
      else {
        throw Exception(body['message']);
      }

    }catch(e){
      rethrow;
    }
  }

  Future<String>  executePayment(url,payerId,accessToken) async {
    var payId = convert.jsonEncode({
      'payer_id': payerId
    });
    print("executive Payments");
    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    print("executive Payments");
    try{
     var response =await http.post(
       Uri.parse(url), headers: headers, body: payId
     );
     print("executive Payments Response");
     print(response.body);
     print("executive Payments Response");
     final body = convert.jsonDecode(response.body);
     print("PayPal Response");
     print(body);
     print("PayPal Response");

     Map<String,dynamic> json = body;
     json['usersId'] = AppData().userdetail!.users_id;
     var responses = await DioService.post('store_paypal_transaction_details', json);
    print(responses);
     showSuccessToast("Amount Successfully WithDraw");

     if(response.statusCode==200){
       return body['id'];
     }
     return "0";
    }catch(e){
      rethrow;
    }
  }
}