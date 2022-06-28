import 'package:connevents/models/save-videos-model.dart';
import 'package:connevents/models/specific-user-category-model.dart';
import 'package:connevents/models/user-location-model.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthData {
  static Profile? _profile;
  static UserLocation? _userLocation;
  static SaveVideo? _saveVideo;
  static Data? _data;
  static UserDetail? _userdetail;
  static List<UserCategoriesModel>? _userCategory;
  static String? _accessToken;
  static String? _unreadMessage;
  static String? _payerId;
  static SharedPreferences? prefs;
  static bool _isGoogleLogin=false;
  static bool _isFacebookLogin=false;

  static Future<void> initiate() async {

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(DataAdapter());
    Hive.registerAdapter(UserDetailAdapter());
  //  Hive.registerAdapter(UserCategoriesModelAdapter());
    Hive.registerAdapter(SaveVideoAdapter());
    Hive.registerAdapter(UserLocationAdapter());
    // Uncomment to clear profile
    // Hive.openBox('profiles').then((value) => value.clear());
    final box = await Hive.openLazyBox<Profile>('profiles');
    final box1 = await Hive.openLazyBox<Data>('data');
    final box2 = await Hive.openLazyBox<UserDetail>('userDetail');
    final box4 = await Hive.openLazyBox<SaveVideo>('saveVideo');
    final box3 = await Hive.openLazyBox<List<UserCategoriesModel>>('userCategory');
    final box5 = await Hive.openLazyBox<UserLocation>('userLocation');
    // Uncomment to clear profile
    // await box.clear();
    prefs = await SharedPreferences.getInstance();
    _unreadMessage = prefs!.getString('access_token');
    _payerId = prefs!.getString('payer_id');

    if (box.isNotEmpty) {
      _profile = await box.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');

    if (box1.isNotEmpty) {
      _data = await box1.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');

    if (box2.isNotEmpty) {
      _userdetail = await box2.getAt(0);
    }
    _accessToken = prefs!.getString('access_token');


        if (box3.isNotEmpty) {
      _userCategory = await box3.get(1);
    }
    _accessToken = prefs!.getString('access_token');

          if (box4.isNotEmpty) {
      _saveVideo = await box4.get(0);
    }
    _accessToken = prefs!.getString('access_token');


        if (box5.isNotEmpty) {
      _userLocation = await box5.get(0);
    }
    _accessToken = prefs!.getString('access_token');


  }



  Future<void> signOut() async {
    _profile = null;
    _accessToken = null;
     FacebookAuth.i.logOut();
     GoogleSignIn().signOut();
    SharedPreferences.getInstance().then((value) => value.clear());
    await Hive.lazyBox<UserDetail>('userDetail').clear();
    await Hive.lazyBox<Data>('data').clear();
    await Hive.lazyBox<Profile>('profiles').clear();
    await Hive.lazyBox<SaveVideo>('saveVideo').clear();
    await Hive.lazyBox<UserLocation>('userLocation').clear();
    await Hive.lazyBox<List<UserCategoriesModel>>('userCategory').clear();
  }


  List<UserCategoriesModel>? get userCategory => _userCategory;
  set userCategory(List<UserCategoriesModel>? prof) {
    _userCategory = prof;
    Hive.lazyBox<List<UserCategoriesModel>>('userCategory').clear().then((value) {
      Hive.lazyBox<List<UserCategoriesModel>>('userCategory')
          .add(prof!)
          .then((value) => prof.take);
    });
  }


  Profile? get profile => _profile;
  set profile(Profile? prof) {
    _profile = prof;
    Hive.lazyBox<Profile>('profiles').clear().then((value) {
      Hive.lazyBox<Profile>('profiles')
          .add(prof!)
          .then((value) => prof.save());
    });
  }


   UserLocation? get userLocation => _userLocation;
  set userLocation(UserLocation? loc) {
    _userLocation = loc;
    Hive.lazyBox<UserLocation>('userLocation').clear().then((value) {
      Hive.lazyBox<UserLocation>('userLocation')
          .add(loc!)
          .then((value) => loc.save());
    });
  }





  // SaveVideo? get saveVideo => _saveVideo;
  // set saveVideo(SaveVideo? video) {
  //   _saveVideo = video;
  //   Hive.lazyBox<SaveVideo>('saveVideo').clear().then((value) {
  //     Hive.lazyBox<SaveVideo>('saveVideo')
  //         .add(video!)
  //         .then((value) => video.save());
  //   });
  // }




  Data? get data => _data;
  set data(Data? data) {
    _data = data;
    Hive.lazyBox<Data>('data').clear().then((value) {
      Hive.lazyBox<Data>('data')
          .add(data!)
          .then((value) => data.save());
    });
        }



        UserDetail?  get  userdetail => _userdetail;
        set userdetail(UserDetail? userdetail) {
          _userdetail = userdetail;
          Hive.lazyBox<UserDetail>('userDetail').clear().then((value) {
            Hive.lazyBox<UserDetail>('userDetail')
                .add(userdetail!)
                .then((value) => userdetail.save());
          });
        }
  // Future updateUserProfile() async {
  //   if(this.isAuthenticated) {
  //     this.user = ( await UserDetailService().get(userId: this.user.user_id)).userdetail;
  //   }
  // }

  bool get isGoogleLogin=> _isGoogleLogin;
    set isGoogleLogin(bool isGoogle){
      _isGoogleLogin=isGoogle;
      SharedPreferences.getInstance().then((value) => value.setBool('loginGoogle', isGoogle));
    }

  bool get isFacebookLogin=> _isFacebookLogin;
  set isFacebookLogin(bool isFacebook){
    _isGoogleLogin=isFacebook;
    SharedPreferences.getInstance().then((value) => value.setBool('loginFacebook', isFacebook));
  }

  String get accessToken => _accessToken!;
  set accessToken(String token) {
    _accessToken = token;
    SharedPreferences.getInstance().then((value) => value.setString('access_token', token));
  }

  String get unreadMessage => _unreadMessage!;
  set unreadMessage(String count){
    _unreadMessage=count;
    SharedPreferences.getInstance().then((value) => value.setString('unread_message', count.toString()));

  }

  String get payerId => _payerId!;
  set payerId(String payerId){
    _payerId=payerId;
    SharedPreferences.getInstance().then((value) => value.setString('unread_message', payerId.toString()));

  }






  bool get isAuthenticated => _userdetail != null;
}
