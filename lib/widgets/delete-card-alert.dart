import 'package:connevents/models/add-card.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class DeleteCardAlert extends StatefulWidget {
  CardDetails? userCardDetail;
  Function(bool num)? isDeleted;
   DeleteCardAlert({Key? key,this.userCardDetail,this.isDeleted}) : super(key: key);

  @override
  _DeleteCardAlertState createState() => _DeleteCardAlertState();
}

class _DeleteCardAlertState extends State<DeleteCardAlert> {
  Future<bool> acceptDeleteRequest() async{
   bool isDeleted=false;
    openLoadingDialog(context, "deleting");
    try{
      var res = await DioService.post('delete_card_details', {
        "userId": widget.userCardDetail!.usersId,
        "cardId": widget.userCardDetail!.cardId
      });
      if(res['status']=='success'){
        isDeleted=true;
        setState(() {});
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSuccessToast(res['data']);
      }
      else if(res['status']=='error'){
        isDeleted=false;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSuccessToast(res['message']);
      }

    }
    catch(e){
      isDeleted=false;
      Navigator.of(context).pop();
      showErrorToast(e.toString());
    }

    return isDeleted;

  }



  Widget Buttons(text, color,void Function() onTap) {
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
      onPressed: onTap,
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
              Text("Are you sure you want to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              Text("delete a Card?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons("CANCEL", Colors.red,()=>Navigator.of(context).pop()),
                    SizedBox(width: 10),
                    Buttons("ACCEPT", globalGreen,()async{
                 bool   result =   await acceptDeleteRequest();
                     widget.isDeleted!(result);
                   //  print(widget.isDeleted!(await acceptDeleteRequest()));
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
              onTap: () =>Navigator.pop(context),
              child: Icon(Icons.close, size: 30, color: globalGreen),
            ),
          ),
        ],
      ),
    );
  }

}
