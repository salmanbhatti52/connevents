
import 'package:connevents/dynamicLink/dynamic-link.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/InviteContacts/InviteContactsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';

class InviteToEventPage extends StatefulWidget {
  EventDetail? eventDetail;
   InviteToEventPage({Key? key,this.eventDetail}) : super(key: key);

  @override
  State<InviteToEventPage> createState() => _InviteToEventPageState();
}

class _InviteToEventPageState extends State<InviteToEventPage> {




  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future copyFile() async {
    print("hellloooo");
    final path = await _localPath;
    Clipboard.setData(new ClipboardData(text: "content://$_localPath/logo.png"));
    return path;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextButton(
          onPressed: () =>Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: globalGreen),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16)),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(padding * 2),
        decoration: BoxDecoration(color: globallightbg),
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Invite Friends ',
                    style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'and get reward points when purchase tickets', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 230,
              padding: EdgeInsets.symmetric(vertical: padding * 2),
              child: SvgPicture.asset('assets/imgs/invite.svg', fit: BoxFit.contain)),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: padding),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            color: globalGreen,
                            width: 2,
                          ),
                        ),
                        child: Text('Copy Link', style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.w700)),
                        onPressed: () async{
                          String link= await   FirebaseDynamicLinkService.createDynamicLink(false, widget.eventDetail!);
                          bool?  isCopied  =  await SocialShare.copyToClipboard('$link \n You were invited to this event on ConnEvents. Join ConnEvents and connect with friends and other events lovers all around the world.');
                       if(isCopied!)
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Link Copied')));
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: padding),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(color: globalGreen, width: 2)),
                        child: Text('Invite via Social Apps', style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.w700)),
                        onPressed: () async{

                    // String path='https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';
                          // Directory tempDir = await getApplicationDocumentsDirectory();
                          // String tempPath = tempDir.path;
                          // File file = File(tempDir.path);
                          // final byteData = await rootBundle.load('assets/logo.png');
                          // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                          // await SocialShare.shareInstagramStory(file.path);
                          // Navigator.of(context).pop();
                          String link= await   FirebaseDynamicLinkService.createDynamicLink(false, widget.eventDetail!);
                          await SocialShare.shareOptions('$link  \n You were invited to this event on ConnEvents. Join ConnEvents and connect with friends and other events lovers all around the world.');
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: padding),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            color: globalGreen,
                            width: 2,
                          ),
                        ),
                        child: Text('Invite via Phone number',
                          style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.w700)),
                          onPressed: () {
                          CustomNavigator.navigateTo(context, InviteContactsPage(eventDetail: widget.eventDetail));
                          // Navigator.pushNamed(context, '/inviteContacts');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
