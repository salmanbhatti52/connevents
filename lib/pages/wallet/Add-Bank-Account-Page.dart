import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/bank-detail-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/bank-textfield.dart';
import 'package:connevents/widgets/lazy_task.dart';
import 'package:flutter/material.dart';

class AddBankAccountPage extends StatefulWidget {
  int? amount;
   AddBankAccountPage({Key? key,this.amount}) : super(key: key);

  @override
  _AddBankAccountPageState createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {

  BankDetail bankDetail=BankDetail();
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate=false;


  @override
  Widget build(BuildContext context) {
    print("shahzaib");
    print(widget.amount);
    print("shahzaib");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:20),
            Text("Add Bank Account",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsets.only(top:12.0,bottom: 12.0,left:20,right: 20),
                child: Column(
                  children: [
                    BankTextField(
                      hintText: "Account Holder",
                      validator:(value)=> value!.isEmpty ? "Please Enter Your Name" : null,
                      keyBoardType: TextInputType.text,
                      onSaved: (value)=>setState(() =>   bankDetail.accountHolderName =value),
                    ),
                    BankTextField(
                      hintText: "Bank Name",
                      validator:(value)=> value!.isEmpty ? "Please Enter Bank Name" : null,
                      keyBoardType: TextInputType.text,
                      onSaved: (value)=>setState(() =>   bankDetail.bankName =value),
                    ),
                    BankTextField(
                      hintText: "Account No",
                      validator:(value)=> value!.isEmpty ? "Please Enter Account No" : null,
                      keyBoardType: TextInputType.number,
                      onSaved: (value)=>setState(() =>   bankDetail.accountNo =value),
                    ),
                    BankTextField(
                      hintText: "Amount",
                      validator:(value)=> value!.isEmpty ? "Please Enter Amount" : null,
                      keyBoardType: TextInputType.number,
                      onSaved: (value)=>setState(() =>   bankDetail.withdrawAmount =value),
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                ),
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if(int.parse(bankDetail.withdrawAmount!) > widget.amount!){
                      return showErrorToast("You don't have enough balance \n Current Amount : \$${widget.amount}");
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                    FocusScope.of(context).requestFocus(FocusNode());
                    Map<String,dynamic> json=bankDetail.toJson();
                    json['usersId'] =AppData().userdetail!.users_id;
                    json['withdrawType'] ="BankAccount";

                      await performLazyTask(context, () async {
                      var res =await DioService.post('store_withdraw_details', json);
                      print(res);
                      showSuccessToast(res['data']);
                    });
                    Navigator.of(context).pop(true);
                  //  openMessageDialog(context, '');
                  } else
                    setState(() => _autoValidate = true);
                },


                // Navigator.pushNamed(context, '/purchaseEvent');
                child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
