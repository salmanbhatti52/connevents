import 'package:carousel_slider/carousel_slider.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/pages/home/event-preview-screen.dart';
import 'package:connevents/pages/home/video-player.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class CarouselSliderEventPage extends StatefulWidget {
  void Function()  onPressed;
  final EventDetail? event;
  final List<ImageData>?  images;
   CarouselSliderEventPage({Key? key,this.event,this.images,required this.onPressed}) : super(key: key);

  @override
  State<CarouselSliderEventPage> createState() => _CarouselSliderEventPageState();
}

class _CarouselSliderEventPageState extends State<CarouselSliderEventPage> {
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
                      // if(i.type=="image")
                        CustomNavigator.navigateTo(context, EventPreviewScreen(imageUrls: widget.images!,imageData: widget.images!.firstWhere((element) => element.attachment==i.attachment),eventDetail: widget.event!));
                         //else
                        //CustomNavigator.navigateTo(context, ShowVideo(video:i.media,eventDetail: widget.event!,thumbNail: i.attachment));
                    },
                  child: Builder(
                    builder: (BuildContext context) {
                      return Hero(
                        tag: 'imageHero',
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.amber),
                                child:i.type=="image" ? Image.network(i.attachment,fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ? child : Center(child: CircularProgressIndicator()),
                                  errorBuilder : (context, error, stackTrace) => Center(child: Text("No Image Available",style:TextStyle(fontSize:18))),
                                ):Image.network(i.attachment,fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ? child : Center(child: CircularProgressIndicator()),
                                  errorBuilder : (context, error, stackTrace) => Center(child: Text("No Image Available",style:TextStyle(fontSize:18))),
                                )
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                            if(i.type=="video")
                              Center(child: Icon(Icons.play_arrow_rounded,color: Colors.white,size:100))
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
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
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
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: padding, left: MediaQuery.of(context).padding.top/7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: widget.onPressed,
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
