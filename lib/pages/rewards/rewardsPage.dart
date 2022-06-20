import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-concash-model.dart';
import 'package:connevents/pages/rewards/rewardsDetailsPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {

  UserConCashDetail userConCashDetail = UserConCashDetail();


  Future redeemPoints() async {
         openLoadingDialog(context, "loading");
    try{
      var response = await DioService.post('redeem_conncash_points', {
        "usersId": AppData().userdetail!.users_id,
      });
         if(response['status']=='success'){
           showSuccessToast(response['data']);
           getUserConCash();
           Navigator.of(context).pop();

          setState(() {});
      } else if(response['status']=='error'){
          Navigator.of(context).pop();
          showErrorToast(response['message']);
      }
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }


  void getUserConCash() async{

    try {
      var response = await DioService.post('get_user_conncash_points', {
        "usersId": AppData().userdetail!.users_id
      });
      if (response['status'] == "success") {
        var card = response['data'];
        if(this.mounted){
          userConCashDetail   =  UserConCashDetail.fromJson(card);
         setState(() {});
        }

      }
      else if (response['status'] == 'error') {
        showErrorToast(response['message']);
      }
    }
    catch(e){
      showErrorToast(e.toString());
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserConCash();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () =>Navigator.pop(context),
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: globallightbg),
        padding: EdgeInsets.all(padding * 2),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unlock Your Reward'),
                  Container(
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 84) * 283 / 500),
                    child: Text(  userConCashDetail.totalConncash.toString() , style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold,),),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: SliderComponentShape.noThumb,
                      showValueIndicator: ShowValueIndicator.never,
                    ),
                    child: Slider(value: userConCashDetail.totalConncash > 500  ? 500 : userConCashDetail.totalConncash, onChanged: (val) {}, min: 0, max:  500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('500', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: padding * 3,),
                  Text('How to earn points', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: globalBlack,),),
                  SizedBox(height: padding),
                  Text('\u2022 Earn points when you purchased tickets', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: globalBlack.withOpacity(0.7),),),
                  SizedBox(height: padding),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Row(
                      children: [
                        Text('\u2022'),
                        Text(' Earn points when your invites purchased tickets', textAlign: TextAlign.start, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: globalBlack.withOpacity(0.7),),),
                      ],
                    ),
                  ),
                  SizedBox(height: padding),
                  SizedBox(height: padding * 2),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: globalLGray, blurRadius: 5),
                      ],
                    ),
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1 purchase \$10-\$20', style: TextStyle(color: globalBlack, fontSize: 12,),),
                            Text('5 Reward points', style: TextStyle(color: globalGreen, fontSize: 12, fontWeight: FontWeight.bold,),),
                          ],
                        ),
                        SizedBox(height: padding,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('1 purchase \$20 and more', style: TextStyle(color: globalBlack, fontSize: 12,),),
                            Text('10 Reward points', style: TextStyle(color: globalGreen, fontSize: 12, fontWeight: FontWeight.bold,),),
                          ],
                        ),
                        SizedBox(height: padding,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('500 Reward points', style: TextStyle(color: globalBlack, fontSize: 12,),),
                            Text('\$5.00', style: TextStyle(color: globalGreen, fontSize: 12, fontWeight: FontWeight.bold,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: padding * 2,
                  ),
                  Center(
                    child: Text('Current ConnCash', style: TextStyle(color: globalBlack, fontSize: 14,),),
                  ),
                  SizedBox(height: padding / 2),
                  userConCashDetail.concashDollars !=null ?
                  Center(
                    child: Text('\$${userConCashDetail.concashDollars ?? 0}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold),),
                  ):
                      Center(child: SizedBox( width:20,height: 20,child: CircularProgressIndicator(strokeWidth: 2)))
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  bool  isRedeemSuccessfully=false;
                 // redeemPoints();
                     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RedeemAlert(
                           isRedeemed:(val){
                            isRedeemSuccessfully=val;
                             if(isRedeemSuccessfully){
                             getUserConCash();
                             showSuccessToast("Points Redeemed Successfully");
                           }
                          },
                        );
                      });

                },
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Redeem', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
