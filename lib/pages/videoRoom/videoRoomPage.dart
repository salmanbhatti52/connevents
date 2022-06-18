import 'package:connevents/pages/videoRoom/allowPopUp.dart';
import 'package:connevents/pages/videoRoom/endingLiveAlert.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VideoRoomPage extends StatefulWidget {
  const VideoRoomPage({Key? key}) : super(key: key);

  @override
  _VideoRoomPageState createState() => _VideoRoomPageState();
}

class _VideoRoomPageState extends State<VideoRoomPage> {
  String selectedSegment = 'video';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/micbg.png',),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: selectedSegment == 'video'
                          ? Image.asset('assets/imgs/streamer.png', fit: BoxFit.cover,)
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2,),
                              child: Image.asset('assets/imgs/audioSignals.png', fit: BoxFit.fitWidth,),),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.all(padding / 2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 62, height: 62,
                                   child:ProfileImagePicker(
                                    onImagePicked: (value){},
                                    // previousImage: AppData().userdetail!.profilePicture,
                                  )),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Demetrius', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                      SizedBox(height: padding / 3,),
                                      Text('1:30:21', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 51,
                                  height: 27,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/eye.svg',
                                          color: Colors.white,
                                          width: 13,
                                          height: 11,
                                        ),
                                        Text(
                                          '11.5k',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: padding / 2,
                                ),
                                SizedBox(
                                  width: 51,
                                  height: 27,
                                  child: TextButton(
                                    onPressed: () {
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return EndingLiveAlert();
                                      //     });
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: padding / 2),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: globalLightButtonbg.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: globalGreen),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: (selectedSegment == 'video')
                                          ? BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              border: Border.all(color: globalGreen),
                                              borderRadius: BorderRadius.circular(30),
                                            )
                                          : BoxDecoration(),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedSegment = 'video';
                                          });
                                        },
                                        child: Text('Video', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: (selectedSegment == 'audio')
                                          ? BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              border: Border.all(color: globalGreen),
                                              borderRadius: BorderRadius.circular(30),
                                            )
                                          : BoxDecoration(),
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedSegment = 'audio';
                                            });
                                          },
                                          child: Text(
                                            'Audio',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 45 + padding),
                          child: ListView.builder(
                            itemCount: 10,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(padding),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: Image.asset(
                                        'assets/imgs/userProfile.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: padding,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Usernamehere',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: padding / 3,
                                        ),
                                        Text(
                                          'user’s message goes here.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: padding / 2,
                          horizontal: padding,
                        ),
                        child: SlidingUpPanel(
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 45,
                          header: Container(
                            height: 45,
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          panel: Container(
                            decoration: BoxDecoration(
                              color: globalBlack.withOpacity(0.8),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: padding / 2),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 54,
                                        child: Divider(
                                          color: globalLGray,
                                          thickness: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: padding),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/hand.svg'),
                                            SizedBox(width: padding,),
                                            Text('Show', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.bold,),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext
                                              context) {
                                                return RaiseHandAlert();
                                              });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(padding),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                child: Image.asset('assets/imgs/userProfile.png', fit: BoxFit.cover,),),
                                              SizedBox(width: padding),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Username here', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12,),),
                                                    SizedBox(height: padding / 3,),
                                                    Text('Rose hand', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: padding / 3,),
                                              Text('Accept', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,),),
                                              SizedBox(width: padding * 2,),
                                            ],

                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
