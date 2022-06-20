// @dart=2.9
import 'package:camera/camera.dart';
import 'package:connevents/Camera-Pages/camera-screen.dart';
import 'package:connevents/dynamicLink/dynamic-link.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/organizerPortfolio/followers-list-page.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/provider/provider-data.dart';
import 'package:connevents/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'pages/landing/landingPage.dart';
import 'variables/globalVariables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await AppData.initiate();
  await GetPosition.initiate();
   cameras = await availableCameras();
   //FirebaseDynamicLinkService.initDynamicLinks();
   await OneSignal.shared.setAppId("3502caf3-e7b3-4352-a53e-a1e13ebe2cd0");
   await FlutterDownloader.initialize(debug: debug);
  runApp(MultiProvider(
    providers :[
      ChangeNotifierProvider(create: (_) => ProviderData())
    ],
    child:MyApp()

  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ));    return
      // GestureDetector(
      // onTap: () {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
      GetMaterialApp(
        title: 'Connevent',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
         theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        canvasColor: Colors.white,
        fontFamily: 'Gilroy',
        primaryColor: Colors.white,
        primarySwatch: Colors.green,
        textSelectionTheme: TextSelectionThemeData(cursorColor: globalGolden),
        // next line is important!
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            )
        )),
        // darkTheme: ThemeData(
        // primaryColor: Colors.black,
        // primaryColorBrightness: Brightness.dark,
        // primaryColorLight: Colors.black,
        // brightness: Brightness.dark,
        // primaryColorDark: Colors.black,
        // indicatorColor: Colors.white,
        // canvasColor: Colors.black,
        // // next line is important!
        // appBarTheme: AppBarTheme(
        //     systemOverlayStyle: SystemUiOverlayStyle(
        //       statusBarIconBrightness: Brightness.light,
        //       statusBarColor: Colors.green.shade700,
        //     )
        // ),),


        home:AppData().isAuthenticated ? TabsPage() : LandingPage(),
        // routes: {
        //    //'/': (context) => LandingPage(),
        //    '/landing': (context) => LandingPage(),
        //    '/registerType': (context) => RegisterTypePage(),
        //    '/register': (context) => RegisterPage(),
        //    '/selectCategories': (context) => SelectCategoriesPage(),
        //    '/login': (context) => LoginPage(),
        //   // '/start': (context) => LoginPage(),
        //    '/forgotPassword': (context) => ForgotPasswordPage(),
        //    '/verifyCode': (context) => VerifyCodePage(),
        //    '/resetPassword': (context) => ResetPasswordPage(),
        //    '/tabs': (context) => TabsPage(),
        //    '/home': (context) => HomePage(),
        //    '/searchFilters': (context) => SearchFiltersPage(),
        //    '/searchResults': (context) => SearchResultsPage(),
        //    '/favorites': (context) => FavoritesPage(),
        //    '/create': (context) => CreatePage(),
        //    '/createSecond': (context) => CreateSecondPage(),
        //    '/createThird': (context) => CreateThirdPage(),
        //    '/confirmCreate': (context) => ConfirmCreatePage(),
        //   '/message': (context) => MessagePage(),
        //   '/messageDetails': (context) => MessageDetailsPage(),
        //   '/menu': (context) => MenuPage(),
        //       '/help': (context) => HelpPage(),
        //   '/notifications': (context) => NotificationsPage(),
        //   '/profile': (context) => ProfilePage(),
        //   '/chosePlan': (context) => ChosePlanPage(),
        //   '/planDetails': (context) => PlanDetailsPage(),
        //   '/paymentCards': (context) => PaymentCardsPage(),
        //   '/addCard': (context) => AddCardPage(),
        //   '/orderConfirmation': (context) => OrderConfirmationPage(),
        //   '/basicMenu': (context) => BasicMenuPage(),
        //   '/wallet': (context) => WalletPage(),
        //   '/eventDetails': (context) => EventDetailsPage(),
        //   '/eventComments': (context) => EventCommentsPage(),
        //   '/reportComment': (context) => ReportCommentPage(),
        //   '/inviteToEvent': (context) => InviteToEventPage(),
        //   '/inviteContacts': (context) => InviteContactsPage(),
        //   '/inviteSent': (context) => InviteSentPage(),
        //   '/purchaseEvent': (context) => PurchaseEventPage(),
        //   '/paymentMethods': (context) => PaymentMethodsPage(),
        //   '/paymentMethodswithoutPay': (context) =>PaymentMethodsPageWithoutPayButton(),
        //   '/addCreditCard': (context) => AddCreditCardPage(),
        //   '/paymentConfirmation': (context) => PaymentConfirmationPage(),
        //   '/checkinticket': (context) => CheckInTicketPage(),
        //   '/refundticket': (context) => RefundTicketPage(),
        //   '/eventLibrary': (context) => EventLibraryPage(),
        //   '/eventGallery': (context) => EventGalleryPage(),
        //   '/ticketHistory': (context) => TicketLibraryPage(),
        //   '/eventsRoom': (context) => EventsRoomPage(),
        //   '/bookRoom': (context) => BookRoomPage(),
        //   '/eventGuestList': (context) => EventGuestListPage(),
        //  // '/eventDashboard': (context) => EventDashboardPage(),
        //   '/salesDetails': (context) => SalesDetailsPage(),
        //   '/rewards': (context) => RewardsPage(),
        //   '/refundRequests': (context) => RefundRequestsPage(),
        //   '/videoRoom': (context) => VideoRoomPage(),
        // },
      );

  // }
}}
//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
//
// List<CameraDescription> cameras=[];
//
// Future<Null> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(MaterialApp(home: new CameraApp()));
// }
//
// class CameraApp extends StatefulWidget {
//   @override
//   _CameraAppState createState() => new _CameraAppState();
// }
//
// class _CameraAppState extends State<CameraApp> {
//   CameraController? cameraController;
//
//   double scale = 1.0;
//   double zoomLevel = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     cameraController = new CameraController(cameras[0], ResolutionPreset.high);
//
//     cameraController!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }
//
//
//   @override
//   void dispose() {
//     cameraController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!cameraController!.value.isInitialized) {
//       return new Container();
//     }
//
//     var cameraPreview = new CameraPreview(cameraController!);
//
//     return Scaffold(
//           body : GestureDetector(
//             onTap:(){
//               cameraController!.setFlashMode(FlashMode.torch);
//               cameraController.
//             },
//           onVerticalDragUpdate:(DragUpdateDetails dragUpdateDetails)async{
//             if(dragUpdateDetails.delta.direction.isNegative){
//               if(await cameraController!.getMaxZoomLevel() > zoomLevel+0.1){
//                 zoomLevel+=0.03;
//                 cameraController!. setZoomLevel(this.zoomLevel);
//                 print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
//               }
//             }else{
//               if(await cameraController!.getMinZoomLevel() < zoomLevel-0.1){
//                 zoomLevel-=0.03;
//                 cameraController!. setZoomLevel(this.zoomLevel);
//                 print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
//               }
//             }
//
//           } ,
//
//
//           child: Container(
//             height: 500,
//             child: new Transform.scale(
//                 scale: scale,
//                 child: new AspectRatio(
//                     aspectRatio: cameraController!.value.aspectRatio,
//                     child: cameraPreview
//                 )
//             ),
//           )
//
//
//       ),
//     );
//   }
// }