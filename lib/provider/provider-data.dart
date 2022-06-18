import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
   int _unreadMessages=0;
   String _status='error';

   int get unreadMessages => _unreadMessages;
   String get status => _status;



   Future get  getUnreadMessages async {
     try{
       var response = await DioService.post('get_unread_messages_count' ,{
         "usersId": AppData().userdetail!.users_id
       });
       if(response['status']=='success'){
         _unreadMessages = response['data'];
         _status = response['status'];
          notifyListeners();
       }else{
         _unreadMessages = response['data'];
         _status = response['status'];
         notifyListeners();
       }


     }
     catch(e){
       print(e.toString());
       showSuccessToast(e.toString());
     }
   }




}