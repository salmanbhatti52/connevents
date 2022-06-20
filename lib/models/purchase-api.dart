// import 'dart:async';
//
// import 'package:flutter/services.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
//
//
// class PurchaseApi{
//
//  static final InAppPurchase _connection = InAppPurchase.instance;
//  static const _apiKey ='';
//   static String  productId="";
//   static bool  isAvailable=true;
//   static bool  isPurchased=false;
//   static StreamSubscription? subscription;
//    static  List _purchases=[];
//   static List get purchases => _purchases;
//
//   static set purchases(List value){
//      _purchases=value;
//    }
//
//    static  List _products=[];
//   static List get products => _products;
//
//   static set products(List value){
//      _products=value;
//    }
//
//
//     static Future init() async{
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(_apiKey);
//     }
//
//    static Future<List<Offering>> fetchOffers() async {
//     try{
//       final offerings = await Purchases.getOfferings();
//       final current =offerings.current;
//       return current==null ? [] :[current];
//     }on PlatformException {
//       return [];
//      }
//    }
//
//
//   static  void initialize() async {
//    isAvailable = await  _connection.isAvailable();
//    if(isAvailable){
//   await _getProducts();
//   await _getPastPurchases();
//         verifyPurchase();
//         subscription =  _connection.purchaseStream.listen((event) {
//           purchases.addAll(event);
//           verifyPurchase();
//
//         });
//    }
//    }
//
//  static void verifyPurchase(){
//     PurchaseDetails purchaseDetails=hasPurchased(productId);
//     if(purchaseDetails.status==PurchaseStatus.purchased){
//       if(purchaseDetails.pendingCompletePurchase){
//         _connection.completePurchase(purchaseDetails);
//         isPurchased=true;
//       }
//     }
//  }
//
//
//    static   hasPurchased(String productId){
//     return purchases.where((element) => element.productId==productId);
//  }
//
//
//  static Future<void> _getProducts() async {
//     Set<String> ids=Set.from([productId]);
//     ProductDetailsResponse response =await _connection.queryProductDetails(ids);
//     products =response.productDetails;
//  }
//
//  static Future<void> _getPastPurchases()  async {
//     // _connection.p
//
//  }
//
//
//
//
// //   static Future init() async{
// //     await Purchases()
// //
// //   }
// //
// //
// //   bool isAvailable = true;
// //   List<ProductDetails> productDetails = [];
// //   List<PurchaseDetails> purchasesDetails = [];
// //   StreamSubscription? subscription;
// //   int gems = 0;
// //  static final String testID = 'test_gems';
// //
// // static Future<bool> purchasePackage(Package purchase) async {
// //
// //
// //
// //   return true;
// //
// // }
// //
// //
// // static initialize() async {
// //   StreamSubscription<List<PurchaseDetails>> _subscription;
// //   final InAppPurchase _connection = InAppPurchase.instance;
// //
// //
// //
// // var  connectionAvailable = await _connection.isAvailable();
// //
// //   if (connectionAvailable) {
// //     await getListOfproductsFromOurStore();
// //     await getListOfPastPurchasesMadebyUser();
// //
// //     _verifyPurchases();
// //
// //     _subscription = _connection.purchaseUpdatedStream.listen((info) {
// //       setState(() {
// //         print('user is making a new purchase');
// //         purchases.addAll(info);
// //       });
// //     });
// //   }
// // }
// //
// // static Future<void> getListOfproductsFromOurStore() async {
// //   Set<String> ids = Set.from([testID]);
// //   ProductDetailsResponse response = await _connection.queryProductDetails(
// //       ids);
// //
// //   setState(() {
// //     productDetails = response.productDetails;
// //   });
// // }
//
//
//
//
// }