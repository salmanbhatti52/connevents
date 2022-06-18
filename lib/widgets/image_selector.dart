// import 'package:connevents/variables/globalVariables.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
//
//
// class ImageSelector extends StatefulWidget {
//   Widget child;
//   List<Asset> images=[];
//   final Function(List<Asset>)? onImagesPicked;
//
//
//  ImageSelector({required this.images, this.onImagesPicked,required this.child});
//   @override
//   createState() => _ImageSelectorState();
// }
//
// class _ImageSelectorState extends State<ImageSelector> {
//   int totalImages=3;
//
//   String _error = 'No Error Detected';
//
//    Future loadAssets() async {
//      print("hello");
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//
//     try {
//         resultList = await MultiImagePicker.pickImages(
//         maxImages: totalImages,
//         enableCamera: true,
//         selectedAssets: widget.images,
//         cupertinoOptions: CupertinoOptions(
//           takePhotoIcon: "chat",
//           doneButtonTitle: "Fatto",
//         ),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//
//       print(resultList.length);
//
//     } on Exception catch (e) {
//       print(e.toString());
//       error = e.toString();
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//     setState(() {
//       widget.onImagesPicked!(resultList);
//       widget.images = resultList;
//       totalImages--;
//       _error = error;
//     });
//   }
//
//
//
//
//   @override
//   initState() {
//     super.initState();
//     if (widget.images == null) {
//       widget.images = [];
//     }
//   }
//
//   @override
//   build(context) => ConstrainedBox(
//         constraints: BoxConstraints.expand(height: 150),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             widget.images.isEmpty
//                 ? GestureDetector(
//                     onTap: (){
//                       print("shah");
//                        loadAssets();
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: globalLGray,
//                             blurRadius: 3,
//                           )
//                         ],
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding * 1.4,),
//                       child: Column(
//                         children: [
//                           SvgPicture.asset('assets/icons/selectPhoto.svg', fit: BoxFit.fitWidth,),
//                           SizedBox(height: padding,),
//                           Text('Upload Photo', style: TextStyle(color: globalBlack.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.bold,),),
//                         ],
//                       ),
//                     ),
//                   )
//
//             :    ListView.builder(
//                     itemCount: widget.images.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, i) {
//                       return  SizedBox(
//                         width: 150,
//                         height: 150,
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             AssetThumb(asset: widget.images[i], width: 300, height: 300,),
//                             Positioned(
//                               top: 2,
//                               right: -2,
//                               child: SizedBox(
//                                 height: 30,
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.red,
//                                   child: IconButton(
//                                       icon: Icon(Icons.delete, color: Colors.white, size: 15,),
//                                       onPressed: () {
//                                         setState(() {
//                                           widget.images.remove(widget.images.elementAt(i));
//                                         });
//                                       }),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//
//
//
//                     }
//                   ),
//             Positioned(
//               left: 55,
//               bottom: -15,
//               child: FlatButton(
//                 padding: EdgeInsets.all(8),
//                 shape: CircleBorder(),
//                 color: Colors.primaries[0],
//                 onPressed: () async {
//                   FilePickerResult result;
//                   try {
//                     result = (await FilePicker.platform.pickFiles(
//                       type: FileType.image,
//                       allowMultiple: true,
//                       allowCompression: true,
//                     ))!;
//                   } on PlatformException catch (e) {
//                     throw e;
//                   }
//                   List<PlatformFile> pickedFiles = result.files;
//                   if (mounted && pickedFiles != null) {
//                     setState(() {
//                       pickedFiles
//                           .map((e) => widget.images!.add(e.path!))
//                           .toList();
//                     });
//                   }
//                 },
//                 child: Icon(
//                   Icons.photo_library,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }
