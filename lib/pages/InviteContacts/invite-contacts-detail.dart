import 'package:connevents/dynamicLink/dynamic-link.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class InviteContactsDetail extends StatefulWidget {
  EventDetail? eventDetail;
  Contact contact;
  List contactList=[];

   InviteContactsDetail({Key? key,this.eventDetail,required this.contactList,required this.contact}) : super(key: key);

  @override
  _InviteContactsDetailState createState() => _InviteContactsDetailState();
}

class _InviteContactsDetailState extends State<InviteContactsDetail> {
  List<String> inviteList=[];


   void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
          .catchError((onError) {
        print(onError);
      });
    print(_result);
    }


  @override
  Widget build(BuildContext context) {
    return Row(
           children: [
             Container(
                   width:40,
                   child:Checkbox(
                    value: widget.contactList.contains(widget.contact.identifier),
                    onChanged : (val)  {
                      if(widget.contactList.contains(widget.contact.identifier)){
                           inviteList.remove(widget.contact.phones!.last.value.toString());
                           widget.contactList.remove(widget.contact.identifier);
                           setState(() {});
                         }
                        else{
                          widget.contactList.add(widget.contact.identifier);
                          inviteList.add(widget.contact.phones!.first.value.toString());

                          setState(() {});
                        }

                     // context.read<CheckBoxTask>().checkBox(contact);
                    },
                    side: BorderSide(color: globalBlack.withOpacity(0.7))),
               ),
             Expanded(
             child: Container(
               child: Material(
                 color:Colors.white,
                 child: ListTile(
                   contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                     leading: (widget.contact.avatar != null && widget.contact.avatar!.isNotEmpty)
                         ? CircleAvatar(backgroundImage: MemoryImage(widget.contact.avatar!))
                         : CircleAvatar(
                       child: Text(widget.contact.initials()), backgroundColor: Theme.of(context).accentColor,
                     ),
                     title: widget.contact.displayName != null ?
                     Text(widget.contact.displayName!, style: TextStyle(color: globalBlack, fontSize: 18)) :
                     SizedBox(),
                     // subtitle: Column(
                     //   children: [
                     //     for (var i in widget.contact.phones!) Text(i.label!)
                     //   ],
                     // ),
                     trailing: TextButton(
                         onPressed: () async{
                           List<String> contactNumber=[];


                           contactNumber.add(widget.contact.phones!.first.value.toString());
                           String link= await   FirebaseDynamicLinkService.createDynamicLink(false, widget.eventDetail!);
                           //  inviteContactsList.add(InvitedContacts(
                           //   contactName:contact.phones!.first.value == contact.displayName ? " ": contact.displayName,
                           //   contactNumber: contact.phones!.first.value,
                           //   senderId: AppData().userdetail!.users_id.toString()
                           // ));
                           _sendSMS('https://play.google.com/store/apps/details?id=com.connevents.apps&hl=en&gl=US',contactNumber);


                        //    inviteContactsList.add(InvitedContacts(
                        //      contactName:contact.phones!.first.value == contact.displayName ? " ": contact.displayName,
                        //      contactNumber: contact.phones!.first.value,
                        //      senderId: AppData().userdetail!.users_id.toString()
                        //    ));
                        // //  await storeInvitedContacts(inviteContactsList);
                        //     await  SocialShare.shareSms('https://play.google.com/store/apps/details?id=com.connevent.app&hl=en&gl=US');
                        //     print(inviteContactsList.first.toJson());
                       //      CustomNavigator.navigateTo(context, InviteSentPage());
                         },
                         style: TextButton.styleFrom(
                           backgroundColor: globalGreen,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(30),
                           ),
                         ),
                         child: Text('SEND', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))),
                   ),
                 ),
               ),
             ),
           ],
         );
  }
}
