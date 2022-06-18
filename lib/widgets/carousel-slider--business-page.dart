import 'package:carousel_slider/carousel_slider.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/pages/home/businessPage/business-photo-view.dart';
import 'package:connevents/pages/home/businessPage/business-video-screen.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:connevents/models/business-create-model.dart';


class CarouselSliderBusinessPage extends StatefulWidget {
  final Business? business;
  final List<ImageData>?  images;
  const CarouselSliderBusinessPage({Key? key,this.business,this.images}) : super(key: key);

  @override
  State<CarouselSliderBusinessPage> createState() => _CarouselSliderBusinessPageState();
}

class _CarouselSliderBusinessPageState extends State<CarouselSliderBusinessPage> {
  VideoPlayerController? videoPlayerController;
   int currentSlide = 0;


  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            CarouselSlider(
              items: widget.images!.map((i) {
                return GestureDetector(
                    onTap: (){
                      if(i.type=="image")
                        CustomNavigator.navigateTo(context, BusinessImageScreen(image: i.attachment,business:  widget.business!));
                      else
                        CustomNavigator.navigateTo(context, BusinessShowVideo(video:i.media,business:  widget.business!,thumbNail: i.attachment));
                    },
                  child: Builder(
                    builder: (BuildContext context) {
                      return Hero(
                        tag: 'imageHero',
                        child: Stack(
                          children: [
                            Container(
                              width:double.infinity,
                              decoration: BoxDecoration(color: Colors.white),
                              child:i.type=="image" ? Image.network(i.attachment,fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ? child : Center(child: CircularProgressIndicator()),
                                errorBuilder : (context, error, stackTrace) => Center(child: Text("No Image Available",style:TextStyle(fontSize:18))),
                              ):Image.network(i.attachment,fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ? child : Center(child: CircularProgressIndicator()),
                                errorBuilder : (context, error, stackTrace) => Center(child: Text("No Image Available",style:TextStyle(fontSize:18))),
                              )
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0,
                viewportFraction: 1,
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentSlide = index;
                  });
                },
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images!.map((url) {
                    int index = widget.images!.indexOf(url);
                    return Container(
                      width: 7.0,
                      height: 7.0,
                      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        shape: BoxShape.circle,
                        color: currentSlide == index
                            ? Colors.white
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: padding, left:  MediaQuery.of(context).padding.top/7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: SvgPicture.asset('assets/icons/backbtn.svg', width: 28, height: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
              ],
            );
  }
}
