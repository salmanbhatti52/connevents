import 'package:carousel_slider/carousel_slider.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page.dart';
import 'package:connevents/pages/home/businessPage/business-detail.dart';
import 'package:connevents/pages/home/businessPage/business-preview-screen.dart';
import 'package:connevents/pages/home/parse-media.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:connevents/widgets/report-business-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connevents/models/business-create-model.dart';


class NearbyBusinessPage extends StatefulWidget {
  final List<Business> business;
  final Function()? onTapEnableLocation;
  final Function(bool isBusinessFavourite,num businessId)? onTapFavourite;

  const NearbyBusinessPage({Key? key,required this.business,this.onTapFavourite,this.onTapEnableLocation}) : super(key: key);
  @override
  State<NearbyBusinessPage> createState() => _NearbyBusinessPageState();
}

class _NearbyBusinessPageState extends State<NearbyBusinessPage> {
  int currentSlide = 0;
  int totalLikes=0;
  bool isLiked=false;

  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();



  Future likeBusinessPost(num eventPostId,int index) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_unlike_business_post' , {
        "businessId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
      widget.business[index].liked=response['data'];
      if(widget.business[index].liked)   widget.business[index].totalLikes = (int.parse(widget.business[index].totalLikes!)+1).toString() ;
      else widget.business[index].totalLikes = (int.parse(widget.business[index].totalLikes!)-1).toString();

      setState(() {});

      Navigator.of(context).pop();
      //  showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.business.length,
            itemBuilder: (context,index){
              Business business= widget.business[index];
              return  Container(
                margin: EdgeInsets.only( bottom: padding / 2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          items: businessParseMedia(business).map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap:()  {
                                    CustomNavigator.navigateTo(context, BusinessPreviewScreen(imageUrls: businessParseMedia(business),imageData: businessParseMedia(business).firstWhere((element) => element.attachment==i.attachment),business:business));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(color: Colors.white),
                                          child: Image.network(i.attachment,fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                            child : Center(child: CircularProgressIndicator()),
                                            errorBuilder : (context, error, stackTrace) =>
                                                Center(child: Text("No Image Available",style:TextStyle(fontSize:18))
                                                ),
                                          )
                                      ),
                                      if(i.type=="video")
                                        Center(child: Icon(Icons.play_arrow_rounded,color: Colors.grey,size:100))
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              height: 170.0,
                              viewportFraction: 1,
                              enlargeCenterPage: false,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentSlide = index;
                                });
                              }),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: businessParseMedia(business).map((url) {
                                int index = businessParseMedia(business).indexOf(url);
                                return Container(
                                  width: 7.0,
                                  height: 7.0,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 1),
                                    shape: BoxShape.circle,
                                    color: currentSlide == index ? Colors.white : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xffF3960B),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${business.discount}%",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                                  Text("DISCOUNT",style: TextStyle(color: Colors.white,fontSize: 6)),
                                ],
                              ),
                            )
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () =>widget.onTapFavourite!(business.isFavourite,business.businessId!),
                              icon: SvgPicture.asset(business.isFavourite  ?   'assets/icons/favYellow.svg' : 'assets/icons/Fav.svg',width: 40)),
                        ),

                        if(AppData().userdetail!.users_id != business.usersId)
                          Positioned(
                              top: 5,
                              left: 5,
                              child: PopupMenuButton(
                                  child: Center(
                                      child: Icon(Icons.more_vert,color:Colors.green)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6.0),
                                        ),
                                  ),
                                  onSelected: (value){
                                    if(value==1)
                                      showDialog(context: context,builder:(ctx)=> ReportBusinessDialog(businessId : business.businessId!));
                                    print(value.toString());
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        height:20,
                                        padding: EdgeInsets.only(left:18,top: 0,bottom: 0),
                                        value: 1,
                                        child: Container(
                                            width: MediaQuery.of(context).size.width/3,
                                            child: Center(child: Text('Report Business',style:TextStyle(fontSize: 17))))),
                                  ]
                              )
                          ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(padding / 2),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: ProfileImagePicker(
                                onImagePicked: (value){},
                                previousImage: business.businessLogo,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(business.title, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
                                    if(business.verified == "Yes")
                                      Padding(
                                        padding: const EdgeInsets.only(left:3.0),
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.all(Radius.circular(70))),
                                            height: 15,width: 15, child: SvgPicture.asset('assets/imgs/verify.svg')),
                                      ),
                                  ],
                                ),
                                business.distanceMiles !=null ?
                                Text('${business.distanceMiles!}', style: TextStyle(color: Colors.black, fontSize: 14)):
                                TextButton(onPressed: widget.onTapEnableLocation,
                                    child: Text("Enable Location")),
                              ],
                            ),
                          ),
                          SizedBox(width: padding / 2),
                          SizedBox(
                            height: 37,
                            width: 106,
                            child: TextButton(
                              onPressed: () async{
                                CustomNavigator.navigateTo(context, BusinessDetailsPage(business: business,link: business.hyperlink,images: businessParseMedia(business)));
                              },
                              child: Text("View", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                              style: TextButton.styleFrom(
                                backgroundColor: globalGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: padding / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              CustomNavigator.navigateTo(context, BusinessCommentsPage(business: business,images: businessParseMedia(business)));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/comments.svg', width: 18),
                                SizedBox(width: padding / 2),
                                Text(business.totalPostComments!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5))),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap:() {
                                    likeBusinessPost(business.businessId! , index);
                                  },
                                  child: business.liked  ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18)),
                              SizedBox(width: padding / 2),
                              Text("${business.totalLikes} Like", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                            ],
                          ),
                          Text("${business.timeAgo}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0)
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<PermissionStatus> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    return status;
  }
}