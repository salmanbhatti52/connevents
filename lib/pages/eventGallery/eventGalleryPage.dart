import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/my-event-library-items.dart';
import 'package:connevents/pages/eventGallery/eventGalleryPageAlerts.dart';
import 'package:connevents/pages/eventGallery/showGalleryImage.dart';
import 'package:connevents/pages/eventGallery/showGalleryVideo.dart';
import 'package:connevents/pages/eventLibrary/allow-upload-item-alert.dart';
import 'package:connevents/pages/eventLibrary/camera-gallery-picker-alert.dart';
import 'package:connevents/pages/organizerPortfolio/followers-list-page.dart';
import 'package:connevents/services/_config.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/download-alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';


class EventGalleryPage extends StatefulWidget {
   bool isPortfolio;
   EventDetail? eventDetail;
   final num? eventPostId;
   bool isCheckIn;
   EventGalleryPage({Key? key,this.eventPostId,this.isPortfolio=false,this.eventDetail,this.isCheckIn=false}) : super(key: key);

  @override
  State<EventGalleryPage> createState() => _EventGalleryPageState();
}

class _EventGalleryPageState extends State<EventGalleryPage> {


List<MyEventLibraryItems> eventLibraryItems=[];
List<MyEventLibraryItems> otherEventLibraryItems=[];
final Dio dio= Dio();
double progress=0.0;

Iterable distinct(Iterable i) {
  var set = new Set();
  return i.where((e) => set.add(e));
}

  String? imagePath;
  String fileType="";
  String eventLibraryMessage="";
  String otherEventLibraryMessage="";
  File? thumbNail;
  bool isSuccess=false;
  bool loading=false;
  Set<String> listOfUrl={};
  String tempFile="";
  bool isChecked=false;


  Future likeEventGallery(int eventLibraryItemId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_library_item', {
        "eventLibraryItemId" : eventLibraryItemId,
        "usersId" : AppData().userdetail!.users_id
      });
      getEventLibrary();
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }


  Future  getEventLibrary() async {
    var response;
    try{
      response = await DioService.post('get_my_event_library_items', {
        "usersId": AppData().userdetail!.users_id,
        "eventPostId": widget.eventPostId,
      });
      print("I m here");
      var   libraryItems=    response['data'] as List;
      eventLibraryItems  = libraryItems.map<MyEventLibraryItems>((e) => MyEventLibraryItems.fromJson(e)).toList();
      setState(() {});
      Navigator.of(context).pop();
    }
    catch (e){
      Navigator.of(context).pop();
      eventLibraryMessage  =  response['message'];
      setState(() {});
      //  showErrorToast(response['message']);
    }
  }

  Future  getOtherEventLibrary() async {
    var response;
    try{
      response = await DioService.post('get_others_event_library_items', {
        "usersId": AppData().userdetail!.users_id,
        "eventPostId": widget.eventPostId,
      });
      var   libraryItems=    response['data'] as List;
      otherEventLibraryItems  = libraryItems.map<MyEventLibraryItems>((e) => MyEventLibraryItems.fromJson(e)).toList();
      print(eventLibraryItems.length);
      setState(() {});
      print("i am here");
      print(response);
      print("i am here");

      // Navigator.of(context).pop();
    }
    catch (e){
      print("shahzaib");
      //  Navigator.of(context).pop();
      if (this.mounted){
        otherEventLibraryMessage  =  response['message'];
        setState(() {});
      }

    }


  }

  void showDialogBox() async{
  await  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CameraGalleryPickerAlert(
          fileType:(val){
            fileType=val;
            setState(() {});
          },
          thumbNail:(val){
            thumbNail=val;
          },
          onImagePicked: (val){
            imagePath=val;
            setState(() {});
            Navigator.of(context).pop();
            if(imagePath !=null)
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AllowUploadItemAlert(
                      fileName: imagePath,
                      fileType: fileType,
                      eventPostId: widget.eventPostId,
                      thumbNail: thumbNail?.path,
                      isSuccess: (val){
                        isSuccess=val;
                        print(isSuccess);
                        if(isSuccess){
                          openLoadingDialog(context, 'loading');
                          getEventLibrary();
                        }
                        setState(() {});
                      },
                    );
                  });
          },
        );

      });

  }




///------Flutter Downloader Variables---///

    List<_TaskInfo>? _tasks;
    late List<_ItemHolder> _items;
    late bool _isLoading;
    late bool _permissionReady;
    late String _localPath;
    final ReceivePort _port = ReceivePort();
    TargetPlatform? platform;


  Future<bool> saveFile(Set<String> urls,Function? progress(progress)) async{
  Set<String> tempList={};
  Directory? directory;
  String newPath="";
   try {
     if(Platform.isAndroid){
       if(await _requestPermission(Permission.storage)  && await _requestPermission(Permission.accessMediaLocation) &&  await _requestPermission(Permission.manageExternalStorage)){
          directory = (await getExternalStorageDirectory())!;
          List<String> folders =directory.path.split('/');
          for(int x=1; x<folders.length; x++){
            String folder= folders[x];
            if(folder!="Android"){
              newPath +="/" + folder;
            }
            else{
              break;
            }
          }
           newPath =newPath + "/Connevent";
           directory =Directory(newPath);
           print(directory.path);
       }else {
         return false;
       }
     }
     else{
       if(await _requestPermission(Permission.photos)){
         directory =await getTemporaryDirectory();
       }else {
         return false;
       }
     }
       if(!await directory.exists()){
       File? saveFile;
       await  directory.create(recursive: true);
       for(var i=0; i < urls.length; i++){
       List<String> name = urls.toList()[i].split('/');
       saveFile=File(directory.path+ "/${name.last}");
       print(saveFile);
       await dio.download(urls.toList()[i], saveFile.path,onReceiveProgress: (download, totalSize){
       setState(() {
         progress(download/totalSize);
       });
       });
       }
       if(Platform.isIOS){
        await ImageGallerySaver.saveFile(saveFile!.path,isReturnPathOfIOS: true);
       }
       return true;
     }
     if(await directory.exists()){
       File? saveFile;
       for(var i=0; i < urls.length; i++){
         print("shahzaib");
         List<String> name = urls.toList()[i].split('/');
        saveFile=File(directory.path+ "/${name.last}");
        print(saveFile);
        await dio.download(urls.toList()[i], saveFile.path,onReceiveProgress: (download, totalSize){
         double  progress = download/totalSize;
       });
        Navigator.of(context).pop();
       }
       if(Platform.isIOS){
        await ImageGallerySaver.saveFile(saveFile!.path,isReturnPathOfIOS: true);
       }
       return true;
     }
   }catch(e){
     print(e);
   }
   return false;
  }

  Future  download(Set<String> urls,Function? progress(progress)) async {
    setState(() {
      loading=true;
    });
    bool downloaded= await saveFile(urls,(value)=>progress(value));
    if(downloaded){
      Navigator.of(context).pop();
      showSuccessToast("All Files are Downloaded");
    }
    else print("Problem Downloading File");
    setState(() {
      loading=false;
    });

}

  Future<bool> _requestPermission(Permission permission) async {
       if(await permission.isGranted) {
         return true;
       }else {
         var result= await permission.request();
         if(result == PermissionStatus.granted){
           return true;
         }
         else{
           return false;
         }
       }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getEventLibrary();
      getOtherEventLibrary();
    });

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

  }


///----Download Images And Videos-----///


    @override
    void dispose() {
      _unbindBackgroundIsolate();
      super.dispose();
    }

  void _requestDownload({url}) async {
    var status =await Permission.storage.request();
    if(status.isGranted){
      var baseStorage = await DownloadsPathProvider.downloadsDirectory;
      Navigator.of(context).pop();
      url!.map((e) async{
        await FlutterDownloader.enqueue(
          url: e,
          headers: {"auth": "test_for_sql_encoding"},
          savedDir: baseStorage!.path,
          showNotification: true,
          openFileFromNotification: true,
           saveInPublicStorage: true,
        );
      }).toList();

    }


  }


  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];
      if(status==DownloadTaskStatus.complete){
        showSuccessToast("Save To Download");
        print("Download Complete");
      }

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == id);
        setState(() {
          task.status = status;
          task.progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.chevron_left),
                  Text('Back'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(padding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(widget.eventDetail!.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
                  if(!widget.isPortfolio)
                    GestureDetector(
                        onTap: ()async{
                          if(widget.isCheckIn)
                            showDialogBox();
                          else
                            showErrorToast("You have to check In First to upload Data");
                        },
                        child: SvgPicture.asset('assets/icons/camera.svg', width: 38, height: 30)


                    ),
                  ],
                ),
                SizedBox(height: padding),
                Text('Your content', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: padding),
                eventLibraryItems.isNotEmpty ?
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(eventLibraryItems.length, (index) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () async{
                              print(eventLibraryItems[index].fileName!);
                               bool isSuccess   = await  CustomNavigator.navigateTo(context,ShowGalleryImageScreen(eventLibraryItems:eventLibraryItems[index],image: eventLibraryItems[index].fileName!,eventLibraryItemId: eventLibraryItems[index].eventLibraryItemId,userId: eventLibraryItems[index].usersId));
                                     print(isSuccess);
                                      if(isSuccess){
                                        openLoadingDialog(context, 'loading');
                                        getEventLibrary();
                                      }

                            },
                            child:eventLibraryItems[index].fileType=="Image" ?  Hero(
                              tag: "imageHero",
                              child: Container(
                                  decoration:BoxDecoration(
                                  border: Border.all(color:Colors.black)
                              ),
                                child: Image.network(eventLibraryItems[index].fileName!,fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                  child : Center(child: CircularProgressIndicator()),
                                  errorBuilder : (context, error, stackTrace) =>
                                      Center(
                                          child: Text("No Image Available",style:TextStyle(fontSize:18))
                                      ),
                                ),
                              ),
                            ): GestureDetector(
                              onTap:() async {
                               bool isSuccess =await CustomNavigator.navigateTo(context, ShowGalleryVideoScreen(eventLibraryItems:eventLibraryItems[index]   ,video:eventLibraryItems[index].fileName!,eventLibraryItemId: eventLibraryItems[index].eventLibraryItemId,userId: eventLibraryItems[index].usersId));
                                if(isSuccess){
                                  if(isSuccess){
                                        openLoadingDialog(context, 'loading');
                                        getEventLibrary();
                                      }}
                               },
                              child: Container(
                                  alignment:Alignment.center,
                                  decoration:BoxDecoration(
                                  border: Border.all(color:Colors.black)
                              ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Image.network(eventLibraryItems[index].thumbnailName!,fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                        child : Center(child: CircularProgressIndicator()),
                                        errorBuilder : (context, error, stackTrace) =>
                                            Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left:18.0),
                                                  child: Text("No Image Available",style:TextStyle(fontSize:12)),
                                                )
                                            ),
                                      ),
                                    ),
                                    Center(child: Icon(CupertinoIcons.play,size: 40)),
                                  ],
                                ),
                              ),
                            )
                          ),
                        ),
                        Positioned(
                          right: 8.0,
                          bottom: 8,
                          child: GestureDetector(
                              onTap:(){
                                likeEventGallery(eventLibraryItems[index].eventLibraryItemId!);
                              },
                              child: eventLibraryItems[index].isLiked  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', color: Colors.green,width: 12)),
                        ),
                      ],
                    );
                  }),
                ):
                Center(child: Text(eventLibraryMessage,style: TextStyle(color: Colors.red,fontSize: 20))),
                SizedBox(height: padding * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Others', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                   if(listOfUrl.isNotEmpty && AppData().userdetail!.users_id == widget.eventDetail!.usersId)
                    GestureDetector(
                        onTap: ()  {
                            showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DownloadAlert(onTap: (){
                                      _requestDownload(url: listOfUrl);
                                    });
                                  });
                        },
                        child: Text('Download', style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                ),
                SizedBox(height: padding),
                otherEventLibraryItems.isNotEmpty ?
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(otherEventLibraryItems.length, (index) {
                    int count=1;
                    print(count++);
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () =>CustomNavigator.navigateTo(context,ShowGalleryImageScreen(image: otherEventLibraryItems[index].fileName!,eventLibraryItems:otherEventLibraryItems[index])),
                            child: otherEventLibraryItems[index].fileType=="Image" ?  Hero(
                              tag: "imageHero",
                              child: Container(
                                  width:40,
                                  height:40,
                                  decoration:BoxDecoration(
                                  border: Border.all(color:Colors.black)
                              ),
                                child: Image.network(otherEventLibraryItems[index].fileName!,fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                  child : Center(child: CircularProgressIndicator()),
                                  errorBuilder : (context, error, stackTrace) =>
                                      Center(
                                          child: Text("No Image Available",style:TextStyle(fontSize:18))
                                      ),
                                ),
                              ),
                            ): GestureDetector(
                              onTap:()=>CustomNavigator.navigateTo(context, ShowGalleryVideoScreen(video:otherEventLibraryItems[index].fileName!,eventLibraryItems:otherEventLibraryItems[index])),
                              child: Container(
                                  width:40,
                                  height:40,
                                  alignment:Alignment.center,
                                  decoration:BoxDecoration(
                                  border: Border.all(color:Colors.black)
                              ),
                                child: Stack(
                                  children: [
                                    Image.network(otherEventLibraryItems[index].thumbnailName!,fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                      child : Center(child: CircularProgressIndicator()),
                                      errorBuilder : (context, error, stackTrace) =>
                                          Center(
                                              child: Text("No Image Available",style:TextStyle(fontSize:18))
                                          ),
                                    ),
                                     Positioned(
                                      top:33,
                                      left: 8,
                                      child: Icon(CupertinoIcons.play_arrow_solid,size: 40,color: Colors.white),
                                  ),
                                  ],
                                ),
                              ),
                            )
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap:() => likeEventGallery(otherEventLibraryItems[index].eventLibraryItemId!),
                            child: otherEventLibraryItems[index].isLiked  ? SvgPicture.asset('assets/icons/heart.svg', width: 14):SvgPicture.asset('assets/icons/whiteheart.svg', color: Colors.green,width: 14),
                          ),
                        ),
                        if(AppData().userdetail!.users_id == widget.eventDetail!.usersId)
                        Positioned(
                          top: -3,
                          right: -5,
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.green),
                            child: Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                   tristate: false,
                                   activeColor: Colors.green,
                                   value: listOfUrl.contains(otherEventLibraryItems[index].fileName!),
                                   onChanged: (value){
                                    setState(() {
                                      if(listOfUrl.contains(otherEventLibraryItems[index].fileName!))
                                       listOfUrl.remove(otherEventLibraryItems[index].fileName!);
                                      else
                                       listOfUrl.add(otherEventLibraryItems[index].fileName!);
                                       print(listOfUrl);
                                    });
                                   }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ) :
                Center(child: Padding(
                  padding: const EdgeInsets.only(top:80.0),
                  child: Text(otherEventLibraryMessage,style: TextStyle(color: Colors.red,fontSize: 20)),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskInfo {
  final String? name;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name});
}

class _ItemHolder {
  final String? name;
  final _TaskInfo? task;
  _ItemHolder({this.name, this.task});
}
