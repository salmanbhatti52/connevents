import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:connevents/models/transaction-detail-model.dart';
import 'package:connevents/pages/ticket/refundTicketPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/tbl-service-container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class PaymentConfirmationPage extends StatefulWidget {
  String regularController;
  String vipController;
  String earlyBirdController;
  String skippingLineController;
  double discountPercent;
  double amount;
  final bool isTableFor10People;
  final bool isTableFor4People;
   final bool isTableFor8People;
  final bool isTableFor6People;
  final TransactionDetailModel transactionDetailModel;
  final EventDetail  event;
   PaymentConfirmationPage({Key? key,this.skippingLineController="",this.discountPercent=0.0,this.amount=0,this.earlyBirdController="",this.regularController="",this.vipController="",this.isTableFor10People=false,this.isTableFor8People=false,this.isTableFor6People=false,this.isTableFor4People=false,required this.event,required this.transactionDetailModel}) : super(key: key);

  @override
  State<PaymentConfirmationPage> createState() => _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {

  double   connEventFees=0.0;
  double   stripeFees=0.0;
  double totalFeesAndTax=0.0;
  double totalAmount=0.0;
  @override
  Widget build(BuildContext context) {

   connEventFees= (0.5+  (((widget.transactionDetailModel.regularPurchasedTicket!.amount+  widget.transactionDetailModel.earlyBirdPurchasedTicket!.amount   + widget.transactionDetailModel.vipPurchasedTicket!.amount)/100) * 1.5) );
   if(widget.transactionDetailModel.paymentType=="Card"){
      var temp  =(widget.transactionDetailModel.regularPurchasedTicket!.amount+  widget.transactionDetailModel.earlyBirdPurchasedTicket!.amount  + widget.transactionDetailModel.vipPurchasedTicket!.amount) + connEventFees;
         stripeFees =     ((temp/100)*2.9) + 0.3;
   }

     totalFeesAndTax=(connEventFees + stripeFees);
     totalAmount   =(double.parse(widget.transactionDetailModel.totalAmount!) + totalFeesAndTax);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                color: globalGreen,
              ),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(padding * 2),
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Orders', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    SizedBox(height: padding),
                    if(widget.earlyBirdController.isNotEmpty)
                    if(widget.transactionDetailModel.earlyBirdPurchasedTicket!.amount > 0)
                      Container(
                      padding: EdgeInsets.symmetric(vertical: padding / 2),
                      child: Row(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Early Bird Ticket', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,)),
                              SizedBox(width: padding),
                              Text('${widget.transactionDetailModel.earlyBirdPurchasedTicket!.quantity.toString()} x \$${int.parse(widget.event.earlyBird!.price!)}', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w500,)),
                            ],
                          ),
                        ),
                        Text('\$${widget.transactionDetailModel.earlyBirdPurchasedTicket!.amount}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,))
                      ]),
                    ),
                    if(widget.regularController.isNotEmpty)
                    if(widget.transactionDetailModel.regularPurchasedTicket!.amount > 0)
                      Container(
                      padding: EdgeInsets.symmetric(vertical: padding / 2),
                      child: Row(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Regular Ticket', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(width: padding),
                              Text("${widget.transactionDetailModel.regularPurchasedTicket!.quantity.toString()} x \$${widget.event.regular!.price}", style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w500,)),
                            ],
                          ),
                        ),
                        Text('\$${widget.transactionDetailModel.regularPurchasedTicket!.amount}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,))
                      ]),
                    ),
                   if(widget.vipController.isNotEmpty)
                   if(widget.transactionDetailModel.vipPurchasedTicket!.amount > 0)
                   Container(
                      padding: EdgeInsets.symmetric(vertical: padding / 2),
                      child: Row(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('VIP', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(width: padding),
                              Text("${widget.transactionDetailModel.vipPurchasedTicket!.vipQuantity.toString()} x \$${widget.event.vip!.price} ", style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w500,)),
                            ],
                          ),
                        ),
                        Text("\$${widget.transactionDetailModel.vipPurchasedTicket!.vipQuantity * num.parse(widget.event.vip!.price!)}"   , style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),

                    if(widget.skippingLineController.isNotEmpty)
                      if(widget.transactionDetailModel.skippingLinePurchasedTicket!.amount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: padding / 2),
                          child: Row(children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text('Skipping Line', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                                  SizedBox(width: padding),
                                  Text("${widget.transactionDetailModel.skippingLinePurchasedTicket!.skippingQuantity.toString()} x \$${widget.event.skippingLine!.price} ", style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w500,)),
                                ],
                              ),
                            ),
                            Text("\$${widget.transactionDetailModel.skippingLinePurchasedTicket!.skippingQuantity * num.parse(widget.event.skippingLine!.price!)}"   , style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                            ),
                            )
                          ]),
                        ),

     ///---------------------------Table Services For Later Use------------------///

                      // if(widget.isTableFor4People)
                      // tblServiceContainer('Table Service For 4 People',widget.event.tblFourPeopleCost),
                      // if(widget.isTableFor6People)
                      // tblServiceContainer('Table Service For 6 People',widget.event.tblSixPeopleCost),
                      // if(widget.isTableFor8People)
                      // tblServiceContainer('Table Service For 8 People',widget.event.tblEightPeopleCost),
                      // if(widget.isTableFor10People)
                      // tblServiceContainer('Table Service For 10 People',widget.event.tblTenPeopleCost),

                     Padding(
                       padding: const EdgeInsets.only(left:12.0),
                       child: Container(
                        padding: EdgeInsets.symmetric(vertical: padding / 2),
                        child: Row(
                            children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text('ConnEvent Fees', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.w500,)),
                                // Padding(
                                //   padding: const EdgeInsets.only(left:8.0),
                                //   child: Tooltip(
                                //     triggerMode: TooltipTriggerMode.tap,
                                //     waitDuration: Duration(seconds: 0),
                                //     showDuration: Duration(seconds: 5),
                                //     padding: EdgeInsets.all(5),
                                //     height: 25,
                                //     textStyle: TextStyle(
                                //         fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                                //         decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Theme.of(context).primaryColor),
                                //         message: "ConnEvents' fee is nonrefundable",
                                //         child: Icon(CupertinoIcons.info, size: 15.0, color: Colors.black),
                                //   ),
                                // ),

                              ],
                            ),
                          ),
                          Text('\$${connEventFees.toStringAsFixed(2)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                    ),
                     ),

                    if(widget.transactionDetailModel.paymentType=="Card")
                    Padding(
                      padding: const EdgeInsets.only(left:12.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: padding / 2),
                        child: Row(
                            children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text('Stripe Fees', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.w500,)),
                              ],
                            ),
                          ),
                          Text('\$${stripeFees.toStringAsFixed(2)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: Container(
                        padding: EdgeInsets.symmetric(vertical: padding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text('Total Fees', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                          Text('\$${(connEventFees + stripeFees).toStringAsFixed(2)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,))
                        ]),
                    ),
                      ),

                    //     Container(
                    //   padding: EdgeInsets.symmetric(vertical: padding / 2),
                    //   child: Row(
                    //       children: [
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           Text('Fees & Tax Total', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.w500,)),
                    //         ],
                    //       ),
                    //     ),
                    //     Text('\$${totalFeesAndTax.toStringAsFixed(2)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                    //       ),
                    //     )
                    //   ]),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Purchase Total',style:TextStyle(fontSize: 18)),
                      Text('\$${widget.amount+ num.parse((connEventFees + stripeFees).toStringAsFixed(2))}',style:TextStyle(fontSize: 16,color: globalGreen,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height:20),
                  Container(
                    padding: EdgeInsets.all(padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: globalLGray,
                          blurRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal,)),
                            Text('\$${widget.amount+ num.parse((connEventFees + stripeFees).toStringAsFixed(2))}', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: padding / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal,)),
                            Text('- \$ ${widget.discountPercent.toStringAsFixed(1)}', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: padding / 2),
                        Divider(color: globalBlack),
                        SizedBox(height: padding / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal)),
                            Text('\$ ${totalAmount.toStringAsFixed(2)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: padding * 2),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async{
                        var response;
                        try{
                        openLoadingDialog(context,"buying");
                        if(widget.transactionDetailModel.paymentType=="Conncash"){
                         response  = await DioService.post('user_purchase_tickets_conncash', {
                         "eventPostId":  widget.transactionDetailModel.eventPostId,
                         "usersId":      widget.transactionDetailModel.usersId,
                         "conneventFees":  connEventFees,
                         "totalAmount":    totalAmount.toStringAsFixed(2),
                        if(widget.transactionDetailModel.discount!=null)
                        "discount": widget.transactionDetailModel.discount,
                        "paymentType":    widget.transactionDetailModel.paymentType,
                        "purchasedTickets":  widget.transactionDetailModel.purchasedTickets,
                        //  if(widget.transactionDetailModel.totalPeopleTableServices > 0)
                        // "totalPeopleTableServices" : widget.transactionDetailModel.totalPeopleTableServices,
                        //  "totalReservedTables" : widget.transactionDetailModel.tableCount,
                        //  'tblFourPplService': widget.isTableFor4People ? 'yes' : 'no',
                        //  'tblsixPplService': widget.isTableFor6People ? 'yes': 'no',
                        //  'tblEightPplService':widget.isTableFor8People ? 'yes': 'no',
                        //  'tblTenPplService':widget.isTableFor10People ? 'yes': 'no',
                     });
                     }
                      else{
                        print(widget.transactionDetailModel.toJson());
                         response  = await DioService.post('user_purchase_tickets_card', {
                         "eventPostId":  widget.transactionDetailModel.eventPostId,
                         "usersId":      widget.transactionDetailModel.usersId,
                         "totalAmount":    totalAmount.toStringAsFixed(2),
                         "stripeFees":     stripeFees,
                         "conneventFees":  connEventFees,
                        if(widget.transactionDetailModel.discount!=null)
                        "discount": widget.transactionDetailModel.discount,
                        "cardId":         widget.transactionDetailModel.cardId,
                        "stripeToken":         widget.transactionDetailModel.stripeToken,
                        "paymentType":    widget.transactionDetailModel.paymentType,
                        "purchasedTickets":  widget.transactionDetailModel.purchasedTickets,
                         //   if(widget.transactionDetailModel.totalPeopleTableServices > 0)
                         // "totalPeopleTableServices": widget.transactionDetailModel.totalPeopleTableServices,
                         // "totalReservedTables" : widget.transactionDetailModel.tableCount,
                         // 'tblFourPplService': widget.isTableFor4People ? 'yes' : 'no',
                         // 'tblsixPplService': widget.isTableFor6People ? 'yes': 'no',
                         // 'tblEightPplService':widget.isTableFor8People ? 'yes': 'no',
                         // 'tblTenPplService':widget.isTableFor10People ? 'yes': 'no',
                     });
                        }
                      print(response);
                      if(response['status']=="success"){
                        var purchasedDetail = response ;
                        PurchasedTicket purchased =  PurchasedTicket.fromJson(purchasedDetail);
                        print(purchased);
                        Navigator.of(context).pop();
                        showSuccessToast("Congratulations! Ticket has been successfully purchased");
                      //  CustomNavigator.pushReplacement(context, TabsPage());
                        CustomNavigator.navigateTo(context, RefundTicketPage(
                          purchasedData: purchased,
                          totalAmount: totalAmount.toStringAsFixed(2),
                          event: widget.event,
                        ));
                      }
                      else if (response['status']=="error"){
                            print(response);
                            Navigator.of(context).pop();
                            showErrorToast(response['message']);
                      }
                        }
                        catch(e){
                        print(response);
                        Navigator.of(context).pop();
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: globalGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Proceed to confirm'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
