import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/refund-request.dart';
import 'package:connevents/pages/refundRequests/refundRequestsPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/fonts.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RefundRequestsPage extends StatefulWidget {
  const RefundRequestsPage({Key? key}) : super(key: key);

  @override
  State<RefundRequestsPage> createState() => _RefundRequestsPageState();
}

class _RefundRequestsPageState extends State<RefundRequestsPage> {

  List<RefundRequestList> refundRequest=[];
  String message="";

  void getRefundRequest() async{
    try {
      var response = await DioService.post('get_refund_requests' , {
        'usersId':AppData().userdetail!.users_id
      });
      print(response);
      if (response['status'] == "success") {
        var card = response['data'] as List;
        refundRequest =  card.map<RefundRequestList>((e) => RefundRequestList.fromJson(e)).toList();
        setState(() {});
        Navigator.of(context).pop();
      }
      else if (response['status'] == 'error') {
        Navigator.of(context).pop();
        message="No Request Refund Found";
        setState(() {});
      }
    }
    catch(e){
      Navigator.of(context).pop();
     // showErrorToast(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
        getRefundRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left:27.0,right: 20.0),
        child: refundRequest.isNotEmpty ?
         SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: padding/2),
                  Text('Refund Request', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
                  SizedBox(height: padding),
                  ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: refundRequest.length,
                    itemBuilder: (context,index){
                      RefundRequestList refund=refundRequest[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AcceptRefundAlert(
                                    refund: refund,
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: padding / 3),
                          margin: EdgeInsets.only(bottom: padding),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: globalLGray),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(refund.buyerUsername!, style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18)),
                                  Text('\$ ${refund.totalAmount}',style: TextStyle(color: Colors.red, fontSize: 18)),
                                ],
                              ),
                              SizedBox(height: padding / 4),
                              Text(refund.eventName!, style: TextStyle(color: globalBlack, fontSize: 18)),
                              SizedBox(height: padding / 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(refund.startingDate!),
                                      SizedBox(width: padding),
                                      SvgPicture.asset('assets/icons/clock.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(refund.startingTime!),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right, color: globalLGray),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ):
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text('Refund Request', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
            ),
            Center(child: Text(message,style: gilroyBoldRed)),
            SizedBox(height: padding),
          ],
        ),
      ),
    );
  }
}
