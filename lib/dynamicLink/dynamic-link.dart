import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/eventDetails/eventDetailsPage.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseDynamicLinkService{

  static Future<String> createDynamicLink(bool short,EventDetail eventDetail) async {
    String linkMessage= "https://connevents.page.link";

    final DynamicLinkParameters parameters=DynamicLinkParameters(
        uriPrefix: linkMessage,
        link: Uri.parse('$linkMessage/${eventDetail.eventPostId}'),
        androidParameters: AndroidParameters(
        packageName: 'com.connevents.apps',
        minimumVersion: 0
        )
    );

    Uri url;
    // if(short){
       final ShortDynamicLink shortDynamicLink=await parameters.buildShortLink();
           url=shortDynamicLink.shortUrl;
           print("bilal");
           print(url);
    print("bilal");

     // }else{
     //   url= await parameters.buildUrl();
     // }
    return url.toString();

  }


  static void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async{
        //  print("deep Link ${eventDetail.toString()}");
          final Uri deepLink=dynamicLink!.link;

          var isEventDetail=deepLink.pathSegments.contains('eventDetail');
            if(isEventDetail){
              String id=deepLink.queryParameters['event_post_id']!;
              if(deepLink!=null){
               // CustomNavigator.navigateTo(context, EventDetailsPage(event: eventDetail));
                print("deep Link ${dynamicLink.toString()}");
              }
            }

        },
        onError: (OnLinkErrorException e) async{
          print("I am here");
          print(e.message);
        }
    );
  }

}