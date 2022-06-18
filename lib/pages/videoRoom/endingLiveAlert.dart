import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class EndingLiveAlert extends StatefulWidget {
  int hostRoomId;
  RtcEngine? engine;
  AgoraRtmChannel? channel;
  String eventHostName;

  EndingLiveAlert({required this.hostRoomId,this.eventHostName="",this.engine,this.channel});

  @override
  State<EndingLiveAlert> createState() => _EndingLiveAlertState();
}

class _EndingLiveAlertState extends State<EndingLiveAlert> {

  Future liveStreamEnded() async {


      try{
      var    res=    await DioService.post('end_live_stream_explicitly', {
           "hostRoomId" : widget.hostRoomId
      });

      }
      catch(e){
        showErrorToast(e.toString());
         Navigator.of(context).pop();
      }
    }



  Widget yesButtons(text, color,void Function()? onPressed) {
    return RaisedButton(
      textColor: Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
      onPressed:onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  Widget cancelButtons(text, color,void Function()? onPressed) {
    return RaisedButton(
      textColor: Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 3,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, size) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 60),
              Center(
                child: Wrap(
                  children: [
                     widget.eventHostName == AppData().userdetail!.user_name ?
                 Text("Are you sure to ending the meeting?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16))
             : Text("Are you sure to leave the meeting?",style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                  ],
                ),
              ),
             SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButtons("NO", Colors.red,()=>Navigator.of(context).pop()),
                    SizedBox(width: 10),
                    yesButtons("YES", globalGreen,()async{
                      if(widget.eventHostName == AppData().userdetail!.user_name){
                       openLoadingDialog(context, "loading");
                       await    liveStreamEnded();
                       await widget.engine!.leaveChannel();
                       await widget.channel!.leave();
                       CustomNavigator.pushReplacement(context, TabsPage(index: 0));
                      }
                      else{
                       await widget.engine!.leaveChannel();
                       await widget.channel!.leave();
                       CustomNavigator.pushReplacement(context, TabsPage(index: 0));
                      }

                    }),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
