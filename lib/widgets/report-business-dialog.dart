import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/report-event-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/lazy_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportBusinessDialog extends StatefulWidget {
final  num businessId;
  ReportBusinessDialog({ required this.businessId});
  @override
  State createState() => new ReportBusinessDialogState();
}

class ReportBusinessDialogState extends State<ReportBusinessDialog> {
  ReportEventModel reportEvent=ReportEventModel();
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _comment;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Report Business',
          style: TextStyle(
            // fontFamily: 'BitterRegular',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: ConneventsTextField(
              icon: CupertinoIcons.mail,
              hintText: "Enter Reason",
              name: 'Report Event',
              maxLines: 4,
              keyBoardType: TextInputType.text,
              validator:(value)=> value!.isEmpty ? "Please Enter Reason" : null,
              onSaved: (value) => _comment = value!,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width/3,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: globalGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: globalGreen,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                FocusScope.of(context).requestFocus(FocusNode());
                FocusScope.of(context).requestFocus(FocusNode());
                await performLazyTask(context, () async {
                  var res =await DioService.post('report_business', {
                     "businessId":   widget.businessId,
                     "userId": AppData().userdetail!.users_id,
                     "comments": _comment
                   });

               showSuccessToast(res['data']);
                });
                Navigator.pop(context);

            //    openMessageDialog(context, 'Please check your email for resetting password.');
              } else
                setState(() => _autoValidate = true);
            },


                // Navigator.pushNamed(context, '/purchaseEvent');
              child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // PaintingButton(
          //   textColor: Colors.white,
          //   color: Theme.of(context).primaryColor,
          //   text: 'Submit',
          //   onTap: () async {
          //     if (_formKey.currentState!.validate()) {
          //       _formKey.currentState!.save();
          //       FocusScope.of(context).requestFocus(FocusNode());
          //       FocusScope.of(context).requestFocus(FocusNode());
          //       await performLazyTask(context, () async {
          //         var res;
          //
          //       });
          //       Navigator.pop(context);
          //   //    openMessageDialog(context, 'Please check your email for resetting password.');
          //     } else
          //       setState(() => _autoValidate = true);
          //   },
          // ),
        ],
      ),
    );
  }
}
