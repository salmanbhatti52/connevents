import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessImageScreen extends StatefulWidget {
  final Business? business;
 final String image;
  const BusinessImageScreen({Key? key,required this.image, this.business}) : super(key: key);

  @override
  State<BusinessImageScreen> createState() => _BusinessImageScreenState();
}

class _BusinessImageScreenState extends State<BusinessImageScreen> {
  @override
  Widget build(BuildContext context) {

    List list =widget.image.split('/');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          if(AppData().userdetail!.users_id==widget.business!.usersId)
            IconButton(onPressed: (){
            final action = CupertinoActionSheet(
           actions: <Widget>[
            CupertinoActionSheetAction(
           child: Text("Delete Image", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,),),
             isDefaultAction: true,
             onPressed: ()async{
                openLoadingDialog(context, "deleting");
                var response  = await DioService.post('created_business_delete_image',{
               "fileName": list.last.toString(),
               "businessId" : widget.business!.businessId.toString()
              });
                print(response);
               if(response['status']=='success'){
                 showSuccessToast(response['message']);
                 Navigator.of(context).pop();
                 CustomNavigator.pushReplacement(context, TabsPage());
               }else{
                 showSuccessToast(response['message']);
                 Navigator.of(context).pop();
               }
        }
      ),
 // if(AppData().userdetail!.users_id != widget.eventDetail.usersId)  CupertinoActionSheetAction(
 //        child: Text("Report Image",
 //          style: TextStyle(color: Colors.blue,
 //            fontSize: 18,
 //            fontWeight: FontWeight.w500,
 //          ),
 //        ),
 //        isDefaultAction: true,
 //        onPressed: (){}
 //      ),
    ],
  );
                    showCupertinoModalPopup(context: context, builder: (context) => action);
          }, icon: Icon(Icons.more_horiz))
        ],
      ),
      backgroundColor: Colors.black,
      body:widget.image.isNotEmpty? GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Center(
            child: Container(
                width: double.infinity,
                child: Image.network(widget.image,fit: BoxFit.cover)),
          )
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ):Center(
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No Image Available",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )
    );
  }
}
