import 'dart:io';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PeeksVideo extends StatefulWidget {
  const PeeksVideo({Key? key}) : super(key: key);

  @override
  _PeeksVideoState createState() => _PeeksVideoState();
}

class _PeeksVideoState extends State<PeeksVideo> {
    String? _tempDir;
    String? thumb;
     var  response;
     int peeksCount=-1;
    List<PeekDetail> peekDetail =[];

    Future<File> getThumbnailPath(String url) async {
      await getTemporaryDirectory().then((d) => _tempDir = d.path);
       thumb = await VideoThumbnail.thumbnailFile(
          video: url,
          thumbnailPath: _tempDir,
          imageFormat: ImageFormat.JPEG,
          quality: 80);
      final file = File(thumb!);
      return file;
}



   Future getRandomPeeks() async {

    try{
       response = await DioService.post('get_random_peeks', {
          "usersId" :AppData().userdetail!.users_id,
          "userLat": AppData().userLocation!.latitude,
          "userLong": AppData().userLocation!.latitude
      });
       print("hello");
       print(response);
       print("hello");
      if(response['status']=="success"){
          var data = response['data'] as List;
          peekDetail     = data.map<PeekDetail>((e) => PeekDetail.fromJson(e)).toList();
          peeksCount=response['total_count'];
          setState(() {});
      }
      else if(response['status']=="error"){
        peeksCount=response['total_count'];
        setState(() {});
      }

       print(response);
   }
    catch (e){
     // showErrorToast(response['message']);
    }

   }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomPeeks();
  }



  @override
  Widget build(BuildContext context) {

    return  peeksCount < 1 ? SizedBox(): Container(
             height:180,
             width:MediaQuery.of(context).size.width,
             child: ListView.builder(
             physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
               itemCount: peekDetail.length,
               shrinkWrap: true,
               itemBuilder: (context,index){
               getThumbnailPath(peekDetail[index].videoUrl!);
                 return GestureDetector(
                   onTap:(){
                     CustomNavigator.navigateTo(context, TabsPage(index:1,fromPeeksTab: false,peekDetail: peekDetail[index],));
                   },
                   child: Padding(
                     padding: const EdgeInsets.only(top: 8.0,bottom:8.0,right: 16.0),
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         Container(
                           height:200,
                           width:100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20)
                           ),
                           child: ClipRRect(
                               borderRadius: BorderRadius.circular(20),
                               child: Image.network(peekDetail[index].peekThumbNail!,fit: BoxFit.cover)),

                         ),
                         Icon(Icons.play_arrow,color:Color(0xffDADADA),size: 50)
                       ],
                     ),
                   ),
                 );
               }),
               );
  }
}
