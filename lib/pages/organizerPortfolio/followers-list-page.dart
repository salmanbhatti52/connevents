import 'dart:io';
import 'dart:ui';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/follower-model.dart';
import 'package:connevents/services/_config.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:external_path/external_path.dart';



const debug = true;
class FollowersListPage extends StatefulWidget {
  EventDetail? eventDetail;
  FollowersListPage({Key? key,this.eventDetail}) : super(key: key);

  @override
  _FollowersListPageState createState() => _FollowersListPageState();
}

class _FollowersListPageState extends State<FollowersListPage> {

  FollowerModel followers = FollowerModel();

  List<FollowersList> followersList = [];

  String totalFollowers = "";
  final Dio dio= Dio();
  String message = "";
  String newPath="";
  int _counter = 0;
  List listOfEmails = [];
  late List<List<dynamic>> employeeData;

  Future getFollowersList() async {
    var response;
    try {
      response = await DioService.post('get_organizer_followers_list', {
        "usersId": widget.eventDetail!.usersId
      });

      Navigator.of(context).pop();
      print(response);
      if (response['status'] == 'success') {
        if(mounted){
          followers = FollowerModel.fromJson(response);
          setState(() {});
        }

      }
      else if (response['status'] == 'error') {
        message = response['message'];
        setState(() {});
      }
    }
    catch (e) {
      Navigator.of(context).pop();
      // showErrorToast(response['message']);
    }
  }

  Future followersCount() async {
    var response;
    try {
      response = await DioService.post('get_followers_count', {
        "usersId": widget.eventDetail!.usersId
      });
      Navigator.of(context).pop();
      totalFollowers = response['data'];
      setState(() {});
      print(response);
    }
    catch (e) {
      // showErrorToast(response['message']);
    }
  }

  Future getFollowersExcelSheet() async {
    var response;
    try {
      response = await DioService.post('export_organizer_followers_emails', {
        "usersId": AppData().userdetail!.users_id
      });
      listOfEmails = response['data'] as List;
      print(listOfEmails.toList());
      setState(() {});

    }
    catch (e) {
      // showErrorToast(response['message']);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getFollowersExcelSheet();
      AppData().userdetail!.users_id == widget.eventDetail!.usersId ?
      getFollowersList() :
      followersCount();
    });

  }



  /// Generate CSV FIle

  void _generateCsvFile() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    // List<dynamic> associateList = [
    //   {"number": 1, "lat": "14.97534313396318", "lon": "101.22998536005622"},
    //   {"number": 2, "lat": "14.97534313396318", "lon": "101.22998536005622"},
    //   {"number": 3, "lat": "14.97534313396318", "lon": "101.22998536005622"},
    //   {"number": 4, "lat": "14.97534313396318", "lon": "101.22998536005622"}
    // ];
    //
    //
    // List<dynamic> emailAssociateList = [
    //
    //   // {"email": "dummyemail.com" },
    //   // {"email": "dummyemail.com" },
    //   // {"email": "dummyemail.com" },
    //   // {"email": "dummyemail.com" }
    // ];


    List<List<dynamic>> rows = [];

    List<dynamic> row = [];
    row.add("email");
    rows.add(row);
    for (int i = 0; i < listOfEmails.length; i++) {
      List<dynamic> row = [];
      row.add(listOfEmails[i]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    String dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    print("dir $dir");
    String file = "$dir";
    File f = File(file + "/filename.csv");

    f.writeAsString(csv);

    setState(() {
      _counter++;
    });
    showSuccessToast("Save to Download");
  }


  @override
  Widget build(BuildContext context) {
    return   AppData().userdetail!.users_id == widget.eventDetail!.usersId ? followers.data != null ? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Followers",style: TextStyle(fontSize: 16)),
                  Text(followers.totalFollowers!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: globalGreen)),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              )
                          )
                      ),
                        onPressed: () async {
                        _generateCsvFile();
                        // generateCsv();
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return DownloadDialogAlert(onPressed: (){
                        //         _requestDownload("https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg");
                        //       });
                        //     });
                        // var status= await Permission.storage.request();
                        // if(status.isGranted)
                        //    download("https://download.samplelib.com/mp4/sample-5s.mp4");
                        //getCsv();
                        // getFollowersExcelSheet();
                      }, child: Text("Export Emails"))
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: followers.data!.length,
                itemBuilder: (context,index){
                  FollowersList follower = followers.data![index];
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: globalGreen,width: 2)
                          ),
                          width: 40,
                          height: 40,
                          child: ProfileImagePicker(
                            onImagePicked: (value){},
                            previousImage:follower.profilePicture,
                          ),
                        ),
                        title: Text(follower.userName!),
                        subtitle: Text(follower.email!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: globalGreen)),
                      ),
                    ],
                  );

                })

          ],
        )
    ): Center(child: Text(message,style: TextStyle(fontSize: 18))):
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Followers",style: TextStyle(fontSize: 16)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(totalFollowers,style: TextStyle(fontSize: 20,color: globalGreen,fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        SizedBox(height:MediaQuery.of(context).size.height*0.1),
        SvgPicture.asset('assets/follower.svg')
      ],
    );
  }
}



