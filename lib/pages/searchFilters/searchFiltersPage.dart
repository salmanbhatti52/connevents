// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:connevents/pages/eventDetails/eventDetailsPage.dart';
// import 'package:connevents/pages/home/homePageAlerts.dart';
// import 'package:connevents/variables/globalVariables.dart';
// import 'package:connevents/widgets/custom-navigator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class SearchFiltersPage extends StatefulWidget {
//   const SearchFiltersPage({Key? key}) : super(key: key);
//
//   @override
//   _SearchFiltersPageState createState() => _SearchFiltersPageState();
// }
//
// class _SearchFiltersPageState extends State<SearchFiltersPage> {
//   List filters = <String>[
//     'Kids friendly',
//     'Pets friendly',
//     'Alcoholic',
//     'Non-Alcoholic',
//     'attribute',
//     'attribute',
//     'attribute',
//     'attribute',
//     'attribute',
//   ];
//   bool showSearchBar = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         padding: EdgeInsets.only(
//           top: MediaQuery.of(context).padding.top,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: padding,
//                 horizontal: padding * 2,
//               ),
//               child: showSearchBar
//                   ? Container(
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: TextField(
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(top: padding),
//                           hintText: 'Type here...',
//                           hintStyle: TextStyle(
//                             color: Colors.white.withOpacity(0.7),
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           prefixIcon: IconButton(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.search,
//                               color: Colors.white,
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 showSearchBar = !showSearchBar;
//                               });
//                             },
//                             icon: Icon(
//                               Icons.close,
//                               color: Colors.white,
//                             ),
//                           ),
//                           fillColor: globalGreen,
//                           filled: true,
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     )
//                   : Row(
//                       children: [
//                         Expanded(
//                           child: SizedBox(
//                             height: 25,
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: globalLightButtonbg,
//                                 padding: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return LocationSearchAlert();
//                                     });
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     'City',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   SvgPicture.asset(
//                                     'assets/icons/downArrow.svg',
//                                     color: globalGreen,
//                                     width: 10,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: padding / 2,
//                         ),
//                         Expanded(
//                           child: SizedBox(
//                             height: 25,
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: globalLightButtonbg,
//                                 padding: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return CalendarAlert();
//                                     });
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     'Date',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   SvgPicture.asset(
//                                     'assets/icons/downArrow.svg',
//                                     color: globalGreen,
//                                     width: 10,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: padding / 2,
//                         ),
//                         Expanded(
//                           child: SizedBox(
//                             height: 25,
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: globalLightButtonbg,
//                                 padding: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return SelectCategories();
//                                     });
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     'Category',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   SvgPicture.asset(
//                                     'assets/icons/downArrow.svg',
//                                     color: globalGreen,
//                                     width: 10,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: padding / 2,
//                         ),
//                         Expanded(
//                           child: SizedBox(
//                             height: 25,
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 backgroundColor: globalLightButtonbg,
//                                 padding: EdgeInsets.zero,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   showSearchBar = !showSearchBar;
//                                 });
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/icons/search.svg',
//                                     color: globalGreen,
//                                     width: 12,
//                                   ),
//                                   Text(
//                                     'Search',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: padding,
//                     horizontal: padding * 2,
//                   ),
//                   decoration: BoxDecoration(color: globallightbg),
//                   child: Column(
//                     children: [
//                       Container(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child: Wrap(
//                                   children: [
//                                     for (var i = 0; i < filters.length; i++)
//                                       Wrap(
//                                         children: [
//                                           Container(
//                                             width: 22,
//                                             height: 22,
//                                             margin: EdgeInsets.only(bottom: padding / 2),
//                                             decoration: BoxDecoration(
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: globalLGray,
//                                                   blurRadius: 3,
//                                                 )
//                                               ],
//                                               color: Colors.white,
//                                             ),
//                                             child: Checkbox(
//                                               checkColor: Colors.transparent,
//                                               fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
//                                               value: true,
//                                               onChanged: (bool? value) {},
//                                             ),
//                                           ),
//                                           SizedBox(width: padding / 2),
//                                           Text(filters[i], style: TextStyle(height: 2, color: globalBlack, fontSize: 12,)),
//                                           SizedBox(width: padding),
//                                         ],
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: padding,
//                             ),
//                             SvgPicture.asset(
//                               'assets/icons/filter.svg',
//                               width: 16,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: Text(
//                           'Clear Filter',
//                           style: TextStyle(
//                             color: globalGolden,
//                             fontSize: 12,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: padding / 2,
//                       ),
//                       for (int i = 0; i < 10; i++) EventCard(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class EventCard extends StatefulWidget {
//   const EventCard({Key? key}) : super(key: key);
//
//   @override
//   _EventCardState createState() => _EventCardState();
// }
//
// class _EventCardState extends State<EventCard> {
//   int currentSlide = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: padding,
//         bottom: padding / 2,
//       ),
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               CarouselSlider(
//                 items: [1, 2, 3, 4, 5, 6].map((i) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(color: Colors.amber),
//                         child: Image.asset(
//                           'assets/imgs/show.png',
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//                 options: CarouselOptions(
//                     height: 170.0,
//                     viewportFraction: 1,
//                     enlargeCenterPage: false,
//                     enableInfiniteScroll: true,
//                     autoPlay: false,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         currentSlide = index;
//                       });
//                     }),
//               ),
//               Positioned.fill(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [1, 2, 3, 4, 5, 6].map((url) {
//                       int index = [1, 2, 3, 4, 5, 6].indexOf(url);
//                       return Container(
//                         width: 7.0,
//                         height: 7.0,
//                         margin: EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 2.0),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white, width: 1),
//                           shape: BoxShape.circle,
//                           color: currentSlide == index
//                               ? Colors.white
//                               : Colors.grey,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: SvgPicture.asset('assets/icons/star.svg', width: 28,),
//                 ),
//               ),
//             ],
//           ),
//           Divider(
//             color: Colors.red,
//             thickness: 8,
//             height: 8,
//           ),
//           Container(
//             padding: EdgeInsets.all(padding / 2),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Lorem ipsum dolor sit',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: padding / 2,
//                       ),
//                       Text(
//                         '30 miles away',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: padding / 2,
//                 ),
//                 SizedBox(
//                   height: 37,
//                   width: 106,
//                   child: TextButton(
//                     onPressed: () {
//                       CustomNavigator.navigateTo(context, EventDetailsPage());
//                       // Navigator.of(context).pushNamed('/eventDetails');
//                     },
//                     child: Text(
//                       'Buy Ticket',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     style: TextButton.styleFrom(
//                       backgroundColor: globalGreen,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: padding / 2),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset('assets/icons/comments.svg', width: 18,),
//                     SizedBox(width: padding / 2,),
//                     Text('54', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SvgPicture.asset('assets/icons/heart.svg', width: 18,),
//                     SizedBox(width: padding / 2,),
//                     Text('150 Likes',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '30 mins ago',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: globalLGray.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Column(
//                     children: [
//                       Text(
//                         'Join Host', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5)),
//                       ),
//                       SizedBox(height: padding / 4),
//                       SvgPicture.asset('assets/icons/video.svg', width: 18, color:Colors.red),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: padding,
//           )
//         ],
//       ),
//     );
//   }
// }
