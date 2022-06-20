import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/invited-contacts-model.dart';
import 'package:connevents/pages/InviteContacts/invite-contacts-detail.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sms/flutter_sms.dart';

class InviteContactsPage extends StatefulWidget {
  EventDetail? eventDetail;
  InviteContactsPage({Key? key,this.eventDetail}) : super(key: key);

  @override
  State<InviteContactsPage> createState() => _InviteContactsPageState();
}

class _InviteContactsPageState extends State<InviteContactsPage> {
   Iterable<Contact> _contacts=[];
    Iterable<Contact> contacts =[];
   List<Contact> _searchList=[];
   List contactList=[];
   List<String> inviteList=[];
   List<InvitedContacts> inviteContactsList=[];
   bool isCheck=false;
   bool isSearch=false;


   CheckBoxTask task = CheckBoxTask();

    void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
          .catchError((onError) {
        print(onError);
      });
    print(_result);
    }




   Future getRecentInvitedContacts() async {
      openLoadingDialog(context, 'loading');
      try{
         var response = await DioService.post('get_recent_invited_contacts', {
           "usersId" : AppData().userdetail!.users_id
      });
         Navigator.of(context).pop();
         showSuccessToast(response['data']);
      }
      catch(e){
        Navigator.of(context).pop();
        showSuccessToast(e.toString());
      }
    }

   Future storeInvitedContacts(list) async {
      openLoadingDialog(context, 'loading');
      try{
         var response = await DioService.post('store_invited_contacts', {
           "invitedContacts" : list,
      });
         Navigator.of(context).pop();
         showSuccessToast(response['data']);
      }
      catch(e){
        Navigator.of(context).pop();
        showSuccessToast(e.toString());
      }
    }

   Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print("i am here");
      await  getContacts();
      // if (routeName != null) {
      //   Navigator.of(context).pushNamed(routeName);
      // }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

   Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

   void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future getContacts() async {
    contacts = await ContactsService.getContacts();
   print(contacts.toList().length);
    setState(() {
     _contacts = contacts;
    });
  }

  onSearch(String search){
      isSearch=true;
      bool isDisplayName=false;
      setState(() {
     _contacts = contacts.where((element){
       if(element.displayName!=null){
     isDisplayName =   element.displayName!.toLowerCase().contains(search);
       }
       return isDisplayName;
     }).toList();
      });
  }

   @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 2,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () =>Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.chevron_left, color: globalGreen),
                    Text('Back', style: TextStyle(color: globalGreen, fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                   _sendSMS('https://play.google.com/store/apps/details?id=com.connevents.apps&hl=en&gl=US',inviteList);
                   //Navigator.pushNamedAndRemoveUntil(context, '/inviteSent', ModalRoute.withName('/eventDetails'));
                },
                child: Text('SEND', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: padding,bottom:padding, left: padding * 1.28,right: padding),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Friends', style: TextStyle(color: globalBlack, fontSize: 24, fontWeight: FontWeight.bold)),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: globalLGray.withOpacity(0.7),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: TextStyle(color: globalBlack,height: 1.5),
                        onChanged: (value) => onSearch(value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: globalBlack.withOpacity(0.5),
                          ),
                          hintText: 'Search For People',
                          hintStyle: TextStyle(color: globalBlack.withOpacity(0.5),height: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.symmetric(
              //       vertical: padding, horizontal: padding * 2),
              //   child: Text(
              //     'Recent',
              //     style: TextStyle(
              //       color: globalBlack,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // Container(
              //   child: Column(
              //     children: [
              //       for (var i = 0; i < 3; i++)
              //         Container(
              //           padding: EdgeInsets.only(
              //             left: padding,
              //             right: padding * 2,
              //           ),
              //           height: 71,
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               border: Border(
              //                   bottom: BorderSide(
              //                 color: globalBlack.withOpacity(0.1),
              //               ))),
              //           child: Row(
              //             children: [
              //               Checkbox(
              //                 value: true,
              //                 onChanged: (val) => {},
              //                 side: BorderSide(
              //                   color: globalBlack.withOpacity(0.7),
              //                 ),
              //               ),
              //               Image.asset(
              //                 'assets/imgs/userProfile.png',
              //                 width: 56,
              //                 height: 56,
              //               ),
              //               SizedBox(
              //                 width: padding / 2,
              //               ),
              //               Expanded(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'Bill Anderson',
              //                       style: TextStyle(
              //                           color: globalBlack, fontSize: 18),
              //                     ),
              //                     SizedBox(
              //                       height: padding / 2,
              //                     ),
              //                     Text(
              //                       '+48 698 55 11',
              //                       style: TextStyle(
              //                           color: globalBlack, fontSize: 14),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 93,
              //                 height: 37,
              //                 child: TextButton(
              //                     onPressed: () {
              //                       CustomNavigator.navigateTo(context, InviteSentPage());
              //                     },
              //                     style: TextButton.styleFrom(
              //                       backgroundColor: globalGreen,
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(30),
              //                       ),
              //                     ),
              //                     child: Text(
              //                       'SEND',
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     )),
              //               )
              //             ],
              //           ),
              //         )
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 1.283),
                child: Text('All Contacts', style: TextStyle(color: globalBlack, fontSize: 20, fontWeight: FontWeight.bold,),
                ),
              ),
              _contacts.isNotEmpty ?
              Container(
                padding: EdgeInsets.only(bottom: padding, left: 13),
                child: Column(
                  children: [
                    ListView.builder(
                      padding:EdgeInsets.zero,
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap:true,
                     itemCount:_contacts.length,
                       itemBuilder: (context,index) {
                         Contact contact = _contacts.elementAt(index);
                         return InviteContactsDetail(contactList: contactList,contact: contact,eventDetail: widget.eventDetail);
                       } )
                  ],
                ),
              ):
              Center(child:isSearch ? Text("No User Found") : const CircularProgressIndicator() )
            ],
          ),
        ),
      ),
    );
  }
}


class CheckBoxTask extends ChangeNotifier{
   List _contactList=[];
   List<String> inviteList = [];

   List get listContact => _contactList;
   notifyListeners();

   void checkBox(contact){
    if(_contactList.contains(contact.identifier)){
     inviteList.remove(contact.phones!.last.value.toString());
    _contactList.remove(contact.identifier);
    notifyListeners();
   }
  else{
    _contactList.add(contact.identifier);
    inviteList.add(contact.phones!.last.value.toString());
    notifyListeners();
  }
     print("here");
  print(listContact);
   print("here");
  print(_contactList.contains(contact.identifier));
  print(_contactList.toList());
  print(inviteList.toList());
  }
}


