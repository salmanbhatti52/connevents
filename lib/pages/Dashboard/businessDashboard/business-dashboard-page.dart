import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/businessEdit/businessEditFirstPage/Business-Edit-First-Page.dart';
import 'package:connevents/pages/salesDetails/salesDetailsPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/fonts.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';

class BusinessDashboardPage extends StatefulWidget {
  const BusinessDashboardPage({Key? key}) : super(key: key);

  @override
  _BusinessDashboardPageState createState() => _BusinessDashboardPageState();
}

class _BusinessDashboardPageState extends State<BusinessDashboardPage> {

List<Business> businessList=[];
String message="";


  Future userBusiness() async {
   //  try{
      var response = await DioService.post('user_business_posts', {
        "userId": AppData().userdetail!.users_id
      });
      if(response['status']=='success'){
        var jsonData =  response['data'] as List;
          businessList =jsonData.map<Business>((e) => Business.fromJson(e)).toList();
          setState(() {});
          print(businessList.last.toJson());
          Navigator.of(context).pop();
      }
      else if (response['status']=='error'){
        Navigator.of(context).pop();
        message= response['message'];
              }
    // }
    // catch(e){
    //   Navigator.of(context).pop();
    //   showSuccessToast(e.toString());
    // }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading");
      userBusiness();
       });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppData().userdetail!.user_name!, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalBlack,)),
         businessList.isNotEmpty ?
         ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:businessList.length,
            itemBuilder: (context,index){
              Business business= businessList[index];
              return Column(
                children: [
                  ListTile(

                    contentPadding: EdgeInsets.only(left: 0),
                    leading: CircleAvatar(backgroundImage: NetworkImage(business.businessLogo)),
                    trailing: Container(
                      width:MediaQuery.of(context).size.width*0.28,
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){
                            CustomNavigator.navigateTo(context, BusinessEditFirstPage(
                              business: business,
                            ));
                          }, icon: Icon(Icons.edit,color: globalGreen)),
                          IconButton(onPressed: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CancelBusinessAlert(business:business);
                                });
                          },icon: Icon(Icons.delete,color: Colors.red)),

                        ],
                      ),
                    ),
                    title: Text(business.title,style:TextStyle(fontSize: 20))),
                    Divider()
                ],
              );
            },
        ) : Padding(
          padding: const EdgeInsets.only(left:10.0),
          child: Container(
             height: MediaQuery.of(context).size.height/2,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Center(child: Text("No Results Found",style: gilroyBoldRed)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
