import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:connevents/models/transaction-detail-model.dart';
import 'package:connevents/pages/eventDetails/widget/carousel-slider-page.dart';
import 'package:connevents/pages/paymentMethods/paymentMethodsPage.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/services.dart';
import 'package:connevents/models/event-address-model.dart';

class PurchaseEventPage extends StatefulWidget {
 final EventDetail  event;
 final List<ImageData>?  images;
 final int? differenceEarlyBirdDate;
  const PurchaseEventPage({Key? key,this.differenceEarlyBirdDate,required this.event,this.images}) : super(key: key);

  @override
  _PurchaseEventPageState createState() => _PurchaseEventPageState();
}

class _PurchaseEventPageState extends State<PurchaseEventPage> {
  final key = GlobalKey<FormState>();
  TransactionDetailModel transactionDetailModel=TransactionDetailModel(vipPurchasedTicket: VIPPurchasedTicket(),regularPurchasedTicket: RegularPurchasedTicket(),earlyBirdPurchasedTicket: EarlyBirdPurchasedTicket(),skippingLinePurchasedTicket: SkippingLinePurchasedTicket());

  TextEditingController regularController=TextEditingController();
  TextEditingController vipController=TextEditingController();
  TextEditingController skippingLineController=TextEditingController();
  TextEditingController earlyBirdController=TextEditingController();
  EventDetail event= EventDetail(vip: VIP(), eventAddress: EventAddress(), regular: Regular(), earlyBird: EarlyBird(),skippingLine: SkippingLine());


  int currentSlide = 0;

  int regularTicketValue=0;
  int earlyBirdTicketValue=0;
  int vipTicketValue=0;
  int skippingLineTicketValue=0;


  bool isTableFor4People=false;
  bool isTableFor6People=false;
  bool isTableFor8People=false;
  bool isTableFor10People=false;
  double amount=0;
  double totalAmount=0.0;
  double earlyBirdAmount=0.0;
  double vipAmount=0.0;
  double regularAmount=0.0;
  double skippingAmount=0.0;
  double discountAmount=0.0;

   String? method(String? str) {
    if (str != null && str.length > 0 && str.characters.characterAt(str.length - 1) == 'x') {
        str = str.substring(0, str.length - 1);
    }
    return str;
}



  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
    event=widget.event;
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Container(
        child: Column(
          children: [
           CarouselSliderEventPage(event: event,images: widget.images,onPressed: (){
             event= EventDetail(vip: VIP(), eventAddress: EventAddress(), regular: Regular(), earlyBird: EarlyBird(),skippingLine: SkippingLine());
             Navigator.of(context).pop();
           }),
            Form(
            key: key,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.red),
                padding: EdgeInsets.only(top: padding / 2),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: globallightbg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                    children: [
                      Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(padding),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: padding / 4),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(event.title, softWrap: true, style: TextStyle(color: globalBlack, fontSize: 24, fontWeight: FontWeight.bold,),),
                                  ),
                                ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: padding / 2),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ticket Prices', softWrap: true, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                             if(event.earlyBird != null && widget.differenceEarlyBirdDate! > -1)
                             Container(
                             padding: EdgeInsets.only(top: padding / 2),
                             child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text('Early Bird', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
                                      SizedBox(width: padding / 1.3),
                                      Text('\$${event.earlyBird!.price}' , style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                           if(event.earlyBirdAvailable < 1)
                            Text("sold",style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: padding / 4),
                                Container(
                                      width: 70,
                                      height: 22,
                                      decoration:
                                          BoxDecoration(boxShadow: [
                                          BoxShadow(
                                          color: globalLGray,
                                          blurRadius: 3,
                                        )
                                      ]),
                                      child: TextFormField(
                                        controller: earlyBirdController,
                                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                                        onSaved: (value) =>  transactionDetailModel.earlyBirdPurchasedTicket!.quantity=int.tryParse(value!)!,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        enabled: event.earlyBirdAvailable > 0 ? true : false,
                                        onChanged: (value){
                                         earlyBirdTicketValue = int.tryParse(value)??0;
                                          if(earlyBirdTicketValue > 10){
                                            earlyBirdController.text= earlyBirdController.text.substring(0, value.length-1);
                                               earlyBirdController.selection= TextSelection.fromPosition(TextPosition(offset: earlyBirdController.text.length));
                                           earlyBirdTicketValue=int.tryParse(earlyBirdController.text)??0;
                                            return showErrorToast("You can't select more than 10 tickets per purchase");
                                          }
                                          if(value.isNotEmpty){
                                             if(int.tryParse(value)! > num.tryParse(event.earlyBird!.quantity!)!){
                                               earlyBirdController.text= earlyBirdController.text.substring(0, value.length-1);
                                               earlyBirdController.selection= TextSelection.fromPosition(TextPosition(offset: earlyBirdController.text.length));
                                           return showErrorToast("You can't select more than available ${event.earlyBird!.quantity!} Early Bird tickets");
                                          }
                                            setState(() {});

                                             setState(() {
                                            earlyBirdAmount   = double.parse(event.earlyBird!.price!) * double.tryParse(value)!;
                                            if(isTableFor4People && isTableFor10People && isTableFor6People && isTableFor8People) {
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + double.parse(event.tblTenPeopleCost) + double.parse(event.tblSixPeopleCost) + double.parse(event.tblEightPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100));
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                 }
                                               }
                                                 else  {
                                                     totalAmount= double.tryParse(amount.toString())!;
                                                     discountAmount = 0.0;
                                             }
                                            }

                                            else if(isTableFor4People) {
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;

                                                }
                                                else {
                                                  print("hyy");
                                                  totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                  discountAmount = 0.0;
                                                  print(totalAmount);
                                                }
                                              }
                                              else  totalAmount= double.tryParse(amount.toString())!;
                                            }

                                             else if(isTableFor10People){
                                               amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                               if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                     transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   print("hyy");
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                    transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                   print(totalAmount);
                                                 }
                                               }
                                                 else
                                                   {
                                                     totalAmount= double.tryParse(amount.toString())!;
                                                     discountAmount = 0.0;
                                                   }
                                           }

                                             else if(isTableFor6People){
                                             amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                   transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else  {totalAmount= double.tryParse(amount.toString())!;
                                                     discountAmount = 0.0;
                                               }
                                         }

                                             else if(isTableFor8People){
                                             amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                   transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {

                                                 totalAmount= double.tryParse(amount.toString())!;
                                                  transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else
                                                 {
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 discountAmount = 0.0;
                                                 }
                                         }

                                             else {
                                             amount= regularAmount + earlyBirdAmount + vipAmount;
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                     transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                   print(totalAmount);
                                                 }
                                               }
                                                 else
                                                   {
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   discountAmount = 0.0;
                                                   }
                                            }
                                          });
                                          }
                                          else if(value.isEmpty){
                                            setState(() {
                                              earlyBirdTicketValue=0;
                                               earlyBirdAmount = 0;
                                               if(isTableFor4People) {
                                               amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                 if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue+ (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0) >= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   print("hyy");
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;

                                                   print(totalAmount);
                                                 }
                                               }
                                                 else  {totalAmount= double.tryParse(amount.toString())!;
                                                     discountAmount = 0.0;
                                                 }
                                               }
                                            else if(isTableFor10People){
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                   print(totalAmount);
                                                 }
                                               }
                                                 else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                 }
                                                                }

                                            else if(isTableFor8People){
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   print("hyy");
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                   print(totalAmount);
                                                 }
                                               }
                                                 else {
                                                      totalAmount = double.tryParse(amount.toString())!;
                                                      discountAmount = 0.0;
                                                                  }
                                                                }

                                            else if(isTableFor6People){
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                    discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   print("hyy");
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount = 0.0;
                                                   print(totalAmount);
                                                 }
                                               }
                                                 else {
                                                totalAmount = double.tryParse(amount.toString())!;
                                                discountAmount = 0.0;
                                              }
                                            }
                                            else {
                                              amount  =  regularAmount + earlyBirdAmount + vipAmount;
                                              if(event.minTicketsDiscount!.isNotEmpty){
                                                  if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
                                                    totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                    transactionDetailModel.discount= event.discountPercent;
                                                }
                                                  else {
                                                   print("hyy");
                                                   totalAmount= double.tryParse(amount.toString())!;
                                                   transactionDetailModel.discount = 0.toString();
                                                   discountAmount  =  0.0;
                                                   print(totalAmount);
                                                 }
                                               }

                                                 else {
                                                      totalAmount = double.tryParse(amount.toString())!;
                                                      discountAmount = 0.0;
                                                                  }
                                                                }
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                           if( event.regular  != null &&    ((event.regular  != null && widget.differenceEarlyBirdDate! <= -1) || event.earlyBirdAvailable < 1))
                            Container(
                              padding: EdgeInsets.only(top: padding / 2),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('Regular Ticket', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack)),
                                        SizedBox(width: padding / 1.3),
                                        Text('\$${event.regular!.price}' , style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                if(event.regularAvailable! < 1)
                                  Text("sold",style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(width: padding / 4),
                                  Container(
                                    width: 70,
                                    height: 22,
                                    decoration:
                                        BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ]),
                                    child: TextFormField(
                                      controller: regularController,
                                      onSaved: (value) =>  transactionDetailModel.regularPurchasedTicket!.quantity=int.tryParse(value!)!,
                                      textAlign: TextAlign.center,
                                        enabled: event.regularAvailable! > 0 ? true  : false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                      ),

                                        onChanged: (value){
                                        regularTicketValue=int.tryParse(value)??0;
                                         if(regularTicketValue > 10){
                                          regularController.text= regularController.text.substring(0, value.length-1);
                                             regularController.selection= TextSelection.fromPosition(TextPosition(offset: regularController.text.length));
                                           regularTicketValue=int.tryParse(regularController.text)??0;
                                        print(regularTicketValue);
                                          return showErrorToast("You can't select more than 10 tickets per purchase");
                                        }
                                         if(value.isNotEmpty){
                                            if(int.tryParse(value)! > num.tryParse(event.regular!.quantity!)!){
                                              regularController.text= regularController.text.substring(0, value.length-1);
                                             regularController.selection= TextSelection.fromPosition(TextPosition(offset: regularController.text.length));
                                         return showErrorToast("You can't select more than available ${event.regular!.quantity!} regular tickets");
                                        }
                                           regularTicketValue=int.tryParse(value)!;
                                           setState(() {
                                           regularAmount = double.parse(event.regular!.price!) * double.parse(value);

                                            if(isTableFor4People&&isTableFor10People&&isTableFor4People&&isTableFor6People) {
                                              amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost)+double.parse(event.tblTenPeopleCost) + double.parse(event.tblSixPeopleCost)+double.parse(event.tblEightPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                  totalAmount = double.tryParse(amount.toString())!;
                                                  discountAmount = 0.0;
                                                }
                                              }
                                             else if(isTableFor4People) {
                                            amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                            if(event.minTicketsDiscount!.isNotEmpty){
                                              if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                transactionDetailModel.discount= event.discountPercent;
                                              }
                                              else {
                                                print("hyy");
                                                totalAmount= double.tryParse(amount.toString())!;
                                                transactionDetailModel.discount = 0.toString();
                                                discountAmount = 0.0;
                                                print(totalAmount);
                                              }
                                            }
                                            else {
                                              totalAmount = double.tryParse(amount.toString())!;
                                              discountAmount = 0.0;
                                            }
                                          }
                                             else if(isTableFor10People) {
                                              amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 print(totalAmount);
                                                 discountAmount = 0.0;
                                               }
                                             }
                                               else {
                                                  totalAmount = double.tryParse(amount.toString())!;
                                                  discountAmount = 0.0;
                                                }
                                              }
                                              else if(isTableFor8People) {
                                                  amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                                    if(event.minTicketsDiscount!.isNotEmpty){
                                                    if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                      discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                      totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                      transactionDetailModel.discount= event.discountPercent;
                                                  }
                                                    else {
                                                     totalAmount= double.tryParse(amount.toString())!;
                                                     transactionDetailModel.discount = 0.toString();
                                                     discountAmount = 0.0;
                                                     print(totalAmount);
                                                   }
                                                 }
                                                   else {
                                                      totalAmount = double.tryParse(amount.toString())!;
                                                      discountAmount = 0.0;
                                                    }
                                                  }
                                               else if(isTableFor6People) {
                                                    amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                                      if(event.minTicketsDiscount!.isNotEmpty){
                                                      if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                        discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                        totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                        transactionDetailModel.discount= event.discountPercent;
                                                    }
                                                      else {
                                                       totalAmount= double.tryParse(amount.toString())!;
                                                       transactionDetailModel.discount = 0.toString();
                                                       discountAmount = 0.0;
                                                       print(totalAmount);
                                                     }
                                                   }
                                                     else {
                                                        totalAmount = double.tryParse(amount.toString())!;
                                                        discountAmount = 0.0;
                                                      }
                                                    }


                                          else {
                                               amount  =  regularAmount + earlyBirdAmount + vipAmount;

                                      if(event.minTicketsDiscount!.isNotEmpty){
                                         if( regularTicketValue  + earlyBirdTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                print("i am here");
                                                print(amount);
                                                discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount = amount - (amount *  (int.parse(event.discountPercent!) / 100));
                                                  transactionDetailModel.discount= event.discountPercent;
                                                 print(totalAmount);
                                               }
                                         else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }

                                             }else {
                                              totalAmount = double.tryParse(amount.toString())!;
                                              discountAmount = 0.0;
                                      }
                                                              }
                                           });
                                        }
                                        else if(value.isEmpty){
                                          setState(() {
                                            regularTicketValue=0;
                                             regularAmount=0;
                                              if(isTableFor4People){
                                                amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                 if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;

                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                  totalAmount = double.tryParse(amount.toString())!;
                                                  discountAmount = 0.0;
                                               }
                                                              }

                                          else if(isTableFor10People){
                                            amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);

                                            if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                      totalAmount = double.tryParse(amount.toString())!;
                                                      discountAmount = 0.0;
                                                                }
                                                              }

                                          else if(isTableFor6People){
                                            amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);

                                            if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                                }
                                                              }

                                          else if(isTableFor8People){
                                            amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);

                                            if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                  totalAmount = double.tryParse(amount.toString())!;
                                                  discountAmount = 0.0;
                                               }
                                                              }
                                         else {
                                         amount  =  regularAmount + earlyBirdAmount + vipAmount;
                                         print(amount);
                                                 if(event.minTicketsDiscount!.isNotEmpty){
                                                   print("i m here");
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                          }
                                          });
                                        }
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),

                           if(event.vip  != null)
                            Container(
                              padding: EdgeInsets.only(top: padding / 2),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('VIP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
                                        SizedBox(width: padding / 1.3),
                                        Text('\$${event.vip!.price}', style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                               if(event.vipAvailable! < 1)
                                Text("sold",style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(width: padding / 4),
                                  Container(
                                    width: 70,
                                    height: 22,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ]),
                                    child: TextFormField(
                                      controller: vipController,
                                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                                      onSaved: (value) =>  transactionDetailModel.vipPurchasedTicket!.quantity=int.tryParse(value!)!,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                        enabled: event.vipAvailable! > 0 ? true : false,
                                        decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value){
                                        vipTicketValue=int.tryParse(value)??0;
                                        if(vipTicketValue > 10){
                                          vipController.text= vipController.text.substring(0, value.length-1);
                                             vipController.selection= TextSelection.fromPosition(TextPosition(offset: vipController.text.length));
                                          vipTicketValue= int.tryParse(vipController.text)?? 0;
                                          return showErrorToast("You can't select more than 10 tickets per purchase");
                                        }

                                         if(value.isNotEmpty){
                                            if(int.tryParse(value)! > num.tryParse(event.vip!.quantity!)!){
                                          vipController.text= vipController.text.substring(0, value.length-1);
                                          vipController.selection= TextSelection.fromPosition(TextPosition(offset: vipController.text.length));
                                         return showErrorToast("You can't select more than available ${event.vip!.quantity!} VIP tickets");
                                        }
                                            vipTicketValue= int.tryParse(value)!;
                                            transactionDetailModel.vipPurchasedTicket!.vipQuantity=int.tryParse(value)!;

                                           setState(() {
                                          vipAmount   = double.parse(event.vip!.price!) * double.tryParse(value)!;
                                          if(isTableFor4People&&isTableFor10People&&isTableFor6People&&isTableFor8People){
                                            amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) +double.parse(event.tblTenPeopleCost)+ double.parse(event.tblSixPeopleCost) +double.parse(event.tblEightPeopleCost);
                                            if(event.minTicketsDiscount!.isNotEmpty){
                                              if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                transactionDetailModel.discount= event.discountPercent;
                                              }
                                              else {
                                                print("hyy");
                                                totalAmount= double.tryParse(amount.toString())!;
                                                transactionDetailModel.discount = 0.toString();
                                                discountAmount = 0.0;
                                                print(totalAmount);
                                              }
                                            }
                                            else  totalAmount= double.tryParse(amount.toString())!;
                                          }
                                          else if(isTableFor4People){
                                            amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                  }
                                                                }
                                          else if(isTableFor10People) {
                                           amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                  }
                                                                }

                                           else if(isTableFor8People) {
                                           amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                  }
                                                                }

                                           else if(isTableFor6People) {
                                           amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                                if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                  }
                                                                }
                                          else {
                                          amount = regularAmount + earlyBirdAmount + vipAmount;
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                               }
                                                                }
                                        });
                                        }
                                        else if(value.isEmpty ){
                                          setState(() {
                                            vipTicketValue=0;
                                            transactionDetailModel.vipPurchasedTicket!.vipQuantity=0;
                                             vipAmount=0;
                                              if(isTableFor4People) {
                                                amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                  if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                                  }
                                                                }
                                              else if(isTableFor10People) {
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                               }
                                                                }

                                              else if(isTableFor8People) {
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                      totalAmount = double.tryParse(amount.toString())!;
                                                      discountAmount = 0.0;
                                                    }
                                                                }

                                               else if(isTableFor6People) {
                                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                             if(event.minTicketsDiscount!.isNotEmpty){
                                                if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                  discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                  totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                  transactionDetailModel.discount= event.discountPercent;
                                              }
                                                else {
                                                 print("hyy");
                                                 totalAmount= double.tryParse(amount.toString())!;
                                                 transactionDetailModel.discount = 0.toString();
                                                 discountAmount = 0.0;
                                                 print(totalAmount);
                                               }
                                             }
                                               else {
                                                    totalAmount = double.tryParse(amount.toString())!;
                                                    discountAmount = 0.0;
                                               }
                                                                }

                                              else {
                                               amount  =  regularAmount + earlyBirdAmount + vipAmount;
                                                 if(event.minTicketsDiscount!.isNotEmpty){
                                                      if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                        discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                        totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                        transactionDetailModel.discount= event.discountPercent;
                                                    }
                                                      else {
                                                       print("hyy");
                                                       totalAmount= double.tryParse(amount.toString())!;
                                                       transactionDetailModel.discount = 0.toString();
                                                       discountAmount = 0.0;
                                                       print(totalAmount);
                                                     }
                                                   }

                                                     else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                                }
                                          });
                                        }

                                      },

                                    ),
                                  ),
                                ],
                              )),

                                  if(event.skippingLine  != null)
                                    Container(
                                        padding: EdgeInsets.only(top: padding / 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text('Skipping Line', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
                                                  SizedBox(width: padding / 1.3),
                                                  Text('\$${event.skippingLine!.price}', style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700,
                                                  ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if(event.skippingLineAvailable! < 1)
                                              Text("sold",style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(width: padding / 4),
                                            Container(
                                              width: 70,
                                              height: 22,
                                              decoration: BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: globalLGray,
                                                  blurRadius: 3,
                                                )
                                              ]),
                                              child: TextFormField(
                                                controller: skippingLineController,
                                                inputFormatters: [LengthLimitingTextInputFormatter(2)],
                                                onSaved: (value) =>  transactionDetailModel.vipPurchasedTicket!.quantity=int.tryParse(value!)!,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                enabled: event.skippingLineAvailable! > 0 ? true : false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value){
                                                  skippingLineTicketValue=int.tryParse(value)??0;
                                                  if(skippingLineTicketValue > 10){
                                                    skippingLineController.text= skippingLineController.text.substring(0, value.length-1);
                                                    skippingLineController.selection= TextSelection.fromPosition(TextPosition(offset: skippingLineController.text.length));
                                                    skippingLineTicketValue= int.tryParse(skippingLineController.text)?? 0;
                                                    return showErrorToast("You can't select more than 10 tickets per purchase");
                                                  }

                                                  if(value.isNotEmpty){
                                                    if(int.tryParse(value)! > num.tryParse(event.skippingLine!.quantity!)!){
                                                      skippingLineController.text= skippingLineController.text.substring(0, value.length-1);
                                                      skippingLineController.selection= TextSelection.fromPosition(TextPosition(offset: skippingLineController.text.length));
                                                      return showErrorToast("You can't select more than available ${event.skippingLine!.quantity!} Skipping Line tickets");
                                                    }
                                                    skippingLineTicketValue= int.tryParse(value)!;
                                                    transactionDetailModel.skippingLinePurchasedTicket!.skippingQuantity=int.tryParse(value)!;

                                                    setState(() {

                                                      skippingAmount   = double.parse(event.skippingLine!.price!) * double.tryParse(value)!;
                                                      if(isTableFor4People&&isTableFor10People&&isTableFor6People&&isTableFor8People){
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) +double.parse(event.tblTenPeopleCost)+ double.parse(event.tblSixPeopleCost) +double.parse(event.tblEightPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else  totalAmount= double.tryParse(amount.toString())!;
                                                      }
                                                      else if(isTableFor4People){
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                      else if(isTableFor10People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }

                                                      else if(isTableFor8People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }

                                                      else if(isTableFor6People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                      else {
                                                        amount = regularAmount + earlyBirdAmount + vipAmount + skippingAmount;
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + skippingLineTicketValue+ (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                    });
                                                  }
                                                  else if(value.isEmpty ){
                                                    setState(() {
                                                      vipTicketValue=0;
                                                      transactionDetailModel.skippingLinePurchasedTicket!.skippingQuantity=0;
                                                      skippingAmount=0;
                                                      if(isTableFor4People) {
                                                        amount = regularAmount + earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                      else if(isTableFor10People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                      else if(isTableFor8People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                      else if(isTableFor6People) {
                                                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost);
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }
                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }

                                                      else {
                                                        amount  =  regularAmount + earlyBirdAmount + vipAmount + skippingAmount;
                                                        if(event.minTicketsDiscount!.isNotEmpty){
                                                          if(earlyBirdTicketValue + regularTicketValue + vipTicketValue + skippingLineTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0)>= int.parse(event.minTicketsDiscount!)){
                                                            discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
                                                            totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
                                                            transactionDetailModel.discount= event.discountPercent;
                                                          }
                                                          else {
                                                            print("hyy");
                                                            totalAmount= double.tryParse(amount.toString())!;
                                                            transactionDetailModel.discount = 0.toString();
                                                            discountAmount = 0.0;
                                                            print(totalAmount);
                                                          }
                                                        }

                                                        else {
                                                          totalAmount = double.tryParse(amount.toString())!;
                                                          discountAmount = 0.0;
                                                        }
                                                      }
                                                    });
                                                  }

                                                },

                                              ),
                                            ),
                                          ],
                                        )),


   ///=--------------------------Table Services For Later Use------------------------///

              //               if(event.tblFourPeopleCost.isNotEmpty)
              //               Container(
              //                 padding: EdgeInsets.symmetric(vertical: padding / 2),
              //                 child: Row(
              //                 children: [
              //                   Expanded(
              //                     child: Row(
              //                       children: [
              //                         Text('Table Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
              //                         SizedBox(width: padding / 1.3),
              //                         Text('(up to 4 people)', style: TextStyle(color: globalBlack, fontSize: 10, fontWeight: FontWeight.w700,),),
              //                          SizedBox(width: padding / 1.3),
              //                         Text(" \$${event.tblFourPeopleCost.toString()}",  style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
              //                       ],
              //                     ),
              //                   ),
              //                 Container(
              //                   width: 22,
              //                   height: 22,
              //                   decoration: BoxDecoration(
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: globalLGray,
              //                         blurRadius: 3,
              //                       )
              //                     ],
              //                     color: Colors.white,
              //                   ),
              //                   child: Checkbox(
              //                     checkColor: Colors.transparent,
              //                     fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
              //                     value: isTableFor4People,
              //                     onChanged: (value) {
              //
              //                       var fourPeopleCost=0.0;
              //                       var tenPeopleCost=0.0;
              //                       var sixPeopleCost=0.0;
              //                       var eightPeopleCost=0.0;
              //                       setState(() {
              //                         if(value!){
              //                           print(event.vipAvailable);
              //                           if(event.vipAvailable! < 4)
              //                             return showErrorToast('Only ${event.vipAvailable} Skipping Line Table Available');
              //                             transactionDetailModel.tableCount++;
              //                             print(value);
              //                            isTableFor4People=value;
              //                       // if(regularTicketValue +  earlyBirdTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0) > 10){
              //                       //   isTableFor4People=!isTableFor4People;
              //                       //    return showErrorToast("You can't select more than 10 tickets per purchase");
              //                       // }
              //
              //                            if(isTableFor4People){
              //                              event.vipAvailable = event.vipAvailable!-4;
              //                              print(event.vipAvailable);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + tenPeopleCost + eightPeopleCost + sixPeopleCost;
              //                            if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //                            else if(isTableFor10People){
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + fourPeopleCost + sixPeopleCost + eightPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                            else if(isTableFor8People){
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + fourPeopleCost + sixPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                           else if(isTableFor6People){
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + fourPeopleCost + tenPeopleCost + eightPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                         else {
              //                        amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                         if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                         }
              //                         else{
              //                           event.vipAvailable = event.vipAvailable!+4;
              //                           print( event.vipAvailable);
              //                           transactionDetailModel.tableCount--;
              //                              isTableFor4People=value;
              //                               if(isTableFor4People){
              //                                 print(event.vipAvailable);
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost) ;
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost) ;
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost) ;
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + tenPeopleCost +eightPeopleCost +sixPeopleCost ;
              //                                if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //                               else if(isTableFor10People){
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + fourPeopleCost + eightPeopleCost + sixPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                               else if(isTableFor6People){
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + fourPeopleCost + eightPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                               else if(isTableFor8People){
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + fourPeopleCost + sixPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                         else {
              //                        amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                         if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //
              //                         }
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //               if(event.tblSixPeopleCost.isNotEmpty)
              //               Container(
              //                 padding: EdgeInsets.symmetric(vertical: padding / 2),
              //                 child: Row(
              //                 children: [
              //                   Expanded(
              //                     child: Row(
              //                       children: [
              //                         Text('Table Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
              //                         SizedBox(width: padding / 1.3),
              //                         Text('(up to 6 people)', style: TextStyle(color: globalBlack, fontSize: 10, fontWeight: FontWeight.w700,),),
              //                          SizedBox(width: padding / 1.3),
              //                         Text(" \$${event.tblSixPeopleCost.toString()}",  style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
              //                       ],
              //                     ),
              //                   ),
              //                 Container(
              //                   width: 22,
              //                   height: 22,
              //                   decoration: BoxDecoration(
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: globalLGray,
              //                         blurRadius: 3,
              //                       )
              //                     ],
              //                     color: Colors.white,
              //                   ),
              //                   child: Checkbox(
              //                     checkColor: Colors.transparent,
              //                     fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
              //                     value: isTableFor6People,
              //                     onChanged: (value) {
              //
              //                       var fourPeopleCost=0.0;
              //                       var tenPeopleCost=0.0;
              //                       var sixPeopleCost=0.0;
              //                       var eightPeopleCost=0.0;
              //                       setState(() {
              //                         if(value!){
              //                           if(event.vipAvailable! < 6)
              //                             return showErrorToast('Only ${event.vipAvailable} Skipping Line Table Available');
              //                           transactionDetailModel.tableCount++;
              //                           print(value);
              //                           isTableFor6People=value;
              //                       //     if(regularTicketValue +  earlyBirdTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0) > 10){
              //                       //   isTableFor6People=!isTableFor6People;
              //                       //    return showErrorToast("You can't select more than 10 tickets per purchase");
              //                       // }
              //                            if(isTableFor6People){
              //                              event.vipAvailable = event.vipAvailable!-6;
              //                              print(event.vipAvailable );
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor8People)   eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + tenPeopleCost + fourPeopleCost + eightPeopleCost;
              //                            if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //                            else if(isTableFor10People){
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor8People)   eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + fourPeopleCost + eightPeopleCost + sixPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                            else if(isTableFor8People){
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              if(isTableFor10People)   tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + fourPeopleCost + sixPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                            else if(isTableFor4People){
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor10People)   tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + int.parse(event.tblFourPeopleCost) + eightPeopleCost + sixPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                           else {
              //                          amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                           if(event.minTicketsDiscount!.isNotEmpty){
              //                                 if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                   discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                   totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                               }
              //                                 else {
              //                                  print("hyy");
              //                                  totalAmount= double.tryParse(amount.toString())!;
              //                                  discountAmount = 0.0;
              //                                  print(totalAmount);
              //                                }
              //                              }
              //                                else  totalAmount= double.tryParse(amount.toString())!;
              //                           }
              //                         }
              //                         else{
              //                           event.vipAvailable = event.vipAvailable!+6;
              //                           print(event.vipAvailable);
              //                           transactionDetailModel.tableCount--;
              //                              isTableFor6People=value;
              //                               if(isTableFor4People){
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + int.parse(event.tblFourPeopleCost) + tenPeopleCost + sixPeopleCost + eightPeopleCost;
              //                                if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //                         else if(isTableFor10People){
              //                                if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + int.parse(event.tblTenPeopleCost) + sixPeopleCost + eightPeopleCost + fourPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                         else if(isTableFor6People){
              //
              //                                if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + tenPeopleCost + eightPeopleCost + fourPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                         else if(isTableFor4People){
              //                                if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                                 if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + sixPeopleCost + eightPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //
              //                         else {
              //                        amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                         if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                         }
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //               if(event.tblEightPeopleCost.isNotEmpty)
              //               Container(
              //                 padding: EdgeInsets.symmetric(vertical: padding / 2),
              //                 child: Row(
              //                 children: [
              //                   Expanded(
              //                     child: Row(
              //                       children: [
              //                         Text('Table Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
              //                         SizedBox(width: padding / 1.3),
              //                         Text('(up to 8 people)', style: TextStyle(color: globalBlack, fontSize: 10, fontWeight: FontWeight.w700,),),
              //                          SizedBox(width: padding / 1.3),
              //                         Text(" \$${event.tblEightPeopleCost.toString()}",  style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
              //                       ],
              //                     ),
              //                   ),
              //                 Container(
              //                   width: 22,
              //                   height: 22,
              //                   decoration: BoxDecoration(
              //                     boxShadow: [
              //                       BoxShadow(
              //                         color: globalLGray,
              //                         blurRadius: 3,
              //                       )
              //                     ],
              //                     color: Colors.white,
              //                   ),
              //                   child: Checkbox(
              //                     checkColor: Colors.transparent,
              //                     fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
              //                     value: isTableFor8People,
              //                     onChanged: (value) {
              //
              //                      var fourPeopleCost=0.0;
              //                       var tenPeopleCost=0.0;
              //                       var sixPeopleCost=0.0;
              //                       var eightPeopleCost=0.0;
              //                       setState(() {
              //                         if(value!){
              //                           if( event.vipAvailable! < 8)
              //                             return showErrorToast('Only ${event.vipAvailable} Skipping Line Table Available');
              //                            transactionDetailModel.tableCount++;
              //                           print(value);
              //                           isTableFor8People=value;
              //                       //       if(regularTicketValue +  earlyBirdTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0) > 10){
              //                       //   isTableFor8People=!isTableFor8People;
              //                       //    return showErrorToast("You can't select more than 10 tickets per purchase");
              //                       // }
              //                            if(isTableFor8People){
              //                              event.vipAvailable = event.vipAvailable!-8;
              //                              print(event.vipAvailable);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + tenPeopleCost + sixPeopleCost + fourPeopleCost;
              //                            if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //
              //                           else if(isTableFor10People){
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + eightPeopleCost + sixPeopleCost + fourPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                           else if(isTableFor6People){
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + eightPeopleCost + tenPeopleCost + fourPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                           else if(isTableFor4People){
              //                              if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                              if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                              if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                              amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + eightPeopleCost + tenPeopleCost + sixPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //                         else {
              //                        amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                         if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                         }
              //                         else{
              //                           event.vipAvailable = event.vipAvailable!+8;
              //                           print(event.vipAvailable);
              //                            transactionDetailModel.tableCount--;
              //                              isTableFor8People=value;
              //                               if(isTableFor8People){
              //
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost) ;
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost) ;
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost) ;
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + tenPeopleCost + sixPeopleCost + fourPeopleCost;
              //                                if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                            }
              //                              else if(isTableFor10People){
              //                                  if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost) ;
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost) ;
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost) ;
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + eightPeopleCost + sixPeopleCost + fourPeopleCost;
              //                                if(event.minTicketsDiscount!.isNotEmpty){
              //                                     if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                       discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                       totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                                   }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                              else if(isTableFor6People){
              //                                  if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost) ;
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost) ;
              //                                 if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost) ;
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + eightPeopleCost + tenPeopleCost + fourPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount = amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                              else if(isTableFor4People){
              //                                  if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost) ;
              //                                 if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost) ;
              //                                 if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost) ;
              //                                 amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + eightPeopleCost + sixPeopleCost + tenPeopleCost;
              //                          if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                print("hyy");
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                                print(totalAmount);
              //                              }
              //                            }
              //                              else  totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //                              else {
              //                                amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                                 if(event.minTicketsDiscount!.isNotEmpty){
              //                                       if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                         discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                         totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                                     }
              //                                       else {
              //                                        print("hyy");
              //                                        totalAmount= double.tryParse(amount.toString())!;
              //                                        discountAmount = 0.0;
              //                                        print(totalAmount);
              //                                      }
              //                                    }
              //                                      else  totalAmount= double.tryParse(amount.toString())!;
              //                                 }
              //
              //
              //                         }
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //               if(event.tblTenPeopleCost.isNotEmpty)
              //                Container(
              //                 padding: EdgeInsets.symmetric(vertical: padding / 2),
              //                 child: Row(
              //                   children: [
              //                     Expanded(
              //                       child: Row(
              //                         children: [
              //                           Text('Table Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalBlack,),),
              //                           SizedBox(width: padding / 1.3),
              //                           Text('(up to 10 people)', style: TextStyle(color: globalBlack, fontSize: 10, fontWeight: FontWeight.w700,)),
              //                           Text("    \$${event.tblTenPeopleCost.toString()}",  style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
              //
              //                         ],
              //                       ),
              //                     ),
              //                Container(
              //                 width: 22,
              //                 height: 22,
              //                 decoration: BoxDecoration(
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: globalLGray,
              //                       blurRadius: 3,
              //                     )
              //                   ],
              //                   color: Colors.white,
              //                 ),
              //               child: Checkbox(
              //                 checkColor: Colors.transparent,
              //                 fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
              //                 value: isTableFor10People,
              //                 onChanged: (value) {
              //
              //                  var fourPeopleCost=0.0;
              //                   var tenPeopleCost=0.0;
              //                   var sixPeopleCost=0.0;
              //                   var eightPeopleCost=0.0;
              //                   setState((){
              //                   if(value!){
              //                     if(event.vipAvailable! < 10)
              //                       return showErrorToast('Only ${event.vipAvailable} Skipping Line Table Available');
              //                      transactionDetailModel.tableCount++;
              //                     isTableFor10People=value;
              //                       //   if(regularTicketValue +  earlyBirdTicketValue +  vipTicketValue + (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0) > 10){
              //                       //   isTableFor10People=!isTableFor10People;
              //                       //    return showErrorToast("You can't select more than 10 tickets per purchase");
              //                       // }
              //                      if(isTableFor10People){
              //                        event.vipAvailable = event.vipAvailable!-10;
              //                        print("shahzaib");
              //                        print(event.vipAvailable);
              //                        print("shahzaib");
              //                        if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                        if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                        if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                        amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + fourPeopleCost + sixPeopleCost +eightPeopleCost;
              //                       if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //                      }
              //                    else if(isTableFor8People){
              //                        if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                        if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                        if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                      amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost)  + fourPeopleCost + sixPeopleCost + tenPeopleCost ;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //
              //                    else if(isTableFor6People){
              //                        if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                        if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                        if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                      amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost)  + fourPeopleCost + eightPeopleCost + tenPeopleCost ;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            print("hyy");
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //
              //                    else if(isTableFor4People){
              //                        if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                        if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                        if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                      amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost)  + sixPeopleCost + eightPeopleCost + tenPeopleCost ;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //                     else {
              //                    amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                    if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else totalAmount= double.tryParse(amount.toString())!;
              //                     }
              //
              //                     }
              //                   else{
              //                     print("hy here");
              //                     event.vipAvailable = event.vipAvailable!+10;
              //                     print(event.vipAvailable);
              //                     print("hy here");
              //
              //                      transactionDetailModel.tableCount--;
              //                     isTableFor10People=value;
              //                     if(isTableFor4People){
              //                       if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                       if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                       if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                       amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblFourPeopleCost) + tenPeopleCost + sixPeopleCost + eightPeopleCost;
              //                       if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                      }
              //                    else if(isTableFor10People){
              //
              //                         if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                         if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                         if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                         amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblTenPeopleCost) + fourPeopleCost + sixPeopleCost + eightPeopleCost;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            print("hyy");
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //                    else if(isTableFor8People){
              //                         if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                         if(isTableFor6People)  sixPeopleCost= double.parse(event.tblSixPeopleCost);
              //                         if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                         amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblEightPeopleCost) + fourPeopleCost + sixPeopleCost + tenPeopleCost;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            print("hyy");
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //
              //                    else if(isTableFor6People){
              //                         if(isTableFor4People)  fourPeopleCost= double.parse(event.tblFourPeopleCost);
              //                         if(isTableFor8People)  eightPeopleCost= double.parse(event.tblEightPeopleCost);
              //                         if(isTableFor10People)  tenPeopleCost= double.parse(event.tblTenPeopleCost);
              //                         amount=regularAmount+ earlyBirdAmount + vipAmount + double.parse(event.tblSixPeopleCost) + fourPeopleCost + eightPeopleCost + tenPeopleCost;
              //                   if(event.minTicketsDiscount!.isNotEmpty){
              //                           if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                             discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                             totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                         }
              //                           else {
              //                            print("hyy");
              //                            totalAmount= double.tryParse(amount.toString())!;
              //                            discountAmount = 0.0;
              //                            print(totalAmount);
              //                          }
              //                        }
              //                          else  totalAmount= double.tryParse(amount.toString())!;
              //
              //                     }
              //
              //                     else {
              //                        amount  =  regularAmount + earlyBirdAmount + vipAmount;
              //                        if(event.minTicketsDiscount!.isNotEmpty){
              //                               if(earlyBirdTicketValue + regularTicketValue + vipTicketValue >= int.parse(event.minTicketsDiscount!)){
              //                                 discountAmount  =  (amount *  (num.parse(event.discountPercent!) / 100));
              //                                 totalAmount=amount - (amount *  (num.parse(event.discountPercent!) / 100)) ;
              //                             }
              //                               else {
              //                                totalAmount= double.tryParse(amount.toString())!;
              //                                discountAmount = 0.0;
              //                              }
              //                            }
              //                              else totalAmount= double.tryParse(amount.toString())!;
              //                         }
              //
              //
              //                   }
              //                   });
              //                 },
              //               ),
              //             ),
              //     ],
              //   ),
              // ),
                             Container(
                              padding: EdgeInsets.only(top: padding / 2),
                              child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.justify,
                                text: TextSpan(text: 'Vip Disclosure: ', style: TextStyle(color: Colors.red, fontSize: 12, height: 1.5),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: 'VIP table bottle service is not administered by ConnEvents. Therefore, should you have any questions about gratuity, bottles, condiments, additional complimentary express entry and all other related concerns, please contact to the event organizer. Click on the message button to send direct message to the host.',
                                      style: TextStyle(color: globalBlack, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                             SizedBox(height: padding / 2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                            Container(
                              padding: EdgeInsets.all(padding),
                              child: Column(
                                children: [
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
                                            Text('Amount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal)),
                                            Text('\$ $amount', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(height: padding / 2),
                                      if(event.discountPercent!.isNotEmpty &&  int.parse(event.discountPercent!) >= 3)
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          Text('Discount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal,)),
                                            Text('- \$ ${discountAmount.toStringAsFixed(1)}', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: padding / 2),
                                        Divider(color: globalBlack),
                                        SizedBox(height: padding / 2),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Total Amount:', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal,)),
                                            Text('\$ ${totalAmount.toStringAsFixed(1)}', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
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
                                      onPressed: () {
                                        print(amount);
                                        if(regularTicketValue ==0 && skippingLineTicketValue == 0  && earlyBirdTicketValue == 0 && vipTicketValue == 0 && !isTableFor4People && !isTableFor6People && !isTableFor8People && !isTableFor10People) return showErrorToast("You have to select one ticket");

                                            transactionDetailModel.usersId=AppData().userdetail!.users_id!.toString();
                                            transactionDetailModel.eventPostId=  event.eventPostId.toString();
                                            transactionDetailModel.totalAmount=totalAmount.toString();
                                            transactionDetailModel.totalPeopleTableServices = (isTableFor4People ? 4 :0)  + (isTableFor6People ? 6 :0)  + (isTableFor8People ? 8 :0) +(isTableFor10People ? 10 :0);
                                            transactionDetailModel.amount=amount;
                                             if(earlyBirdController.text.isNotEmpty){
                                            transactionDetailModel.earlyBirdPurchasedTicket!.eventPostId=  int.tryParse(event.eventPostId.toString());
                                            transactionDetailModel.earlyBirdPurchasedTicket!.usersId = AppData().userdetail!.users_id!;
                                            transactionDetailModel.earlyBirdPurchasedTicket!.amount = double.tryParse(event.earlyBird!.price.toString())!   * num.tryParse(earlyBirdController.text)!;
                                            transactionDetailModel.earlyBirdPurchasedTicket!.ticketId = event.earlyBird!.ticketId;
                                            transactionDetailModel.earlyBirdPurchasedTicket!.quantity = int.tryParse(earlyBirdController.text)!;
                                           }else  transactionDetailModel.earlyBirdPurchasedTicket!.amount = 0;
                                             if(regularController.text.isNotEmpty){
                                            transactionDetailModel.regularPurchasedTicket!.eventPostId =  int.tryParse(event.eventPostId.toString());
                                            transactionDetailModel.regularPurchasedTicket!.usersId = AppData().userdetail!.users_id!;
                                            transactionDetailModel.regularPurchasedTicket!.amount = double.tryParse(event.regular!.price.toString())!   * num.tryParse(regularController.text)!;
                                            transactionDetailModel.regularPurchasedTicket!.ticketId = event.regular!.ticketId;
                                            transactionDetailModel.regularPurchasedTicket!.quantity = int.tryParse(regularController.text)!;
                                                   } else  transactionDetailModel.regularPurchasedTicket!.amount = 0;

                                        if(skippingLineController.text.isNotEmpty){
                                          transactionDetailModel.skippingLinePurchasedTicket!.eventPostId =  int.tryParse(event.eventPostId.toString());
                                          transactionDetailModel.skippingLinePurchasedTicket!.usersId = AppData().userdetail!.users_id!;
                                          transactionDetailModel.skippingLinePurchasedTicket!.amount = double.tryParse(event.skippingLine!.price.toString())!   * num.tryParse(skippingLineController.text)!;
                                          transactionDetailModel.skippingLinePurchasedTicket!.ticketId = event.skippingLine!.ticketId;
                                          transactionDetailModel.skippingLinePurchasedTicket!.quantity = int.tryParse(skippingLineController.text)!;
                                        } else  transactionDetailModel.skippingLinePurchasedTicket!.amount = 0;


                                             if(vipController.text.isNotEmpty || isTableFor4People  || isTableFor6People || isTableFor8People || isTableFor10People) {
                                             transactionDetailModel.vipPurchasedTicket!.eventPostId =  int.tryParse(event.eventPostId.toString());
                                             transactionDetailModel.vipPurchasedTicket!.usersId = AppData().userdetail!.users_id!;
                                             transactionDetailModel.vipPurchasedTicket!.ticketId = event.vip!.ticketId;
                                             if(vipController.text.isNotEmpty){
                                             transactionDetailModel.vipPurchasedTicket!.amount = (double.parse(event.vip!.price.toString())   *  num.tryParse(vipController.text)!);
                                             transactionDetailModel.vipPurchasedTicket!.amount = isTableFor4People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblFourPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount = isTableFor6People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblSixPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount = isTableFor8People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblEightPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount = isTableFor10People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblTenPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;

                                            transactionDetailModel.vipPurchasedTicket!.quantity =    int.tryParse(vipController.text)!;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor4People ? 4 + transactionDetailModel.vipPurchasedTicket!.quantity : transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor8People ? 8 + transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor10People ? 10 + transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor6People ? 6+ transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.totalPeopleTableServices = transactionDetailModel.vipPurchasedTicket!.quantity -  int.tryParse(vipController.text)!;

                                             }
                                              else{

                                             transactionDetailModel.vipPurchasedTicket!.amount= isTableFor4People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblFourPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount= isTableFor6People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblSixPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount= isTableFor8People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblEightPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;
                                             transactionDetailModel.vipPurchasedTicket!.amount= isTableFor10People ?  transactionDetailModel.vipPurchasedTicket!.amount + num.parse(event.tblTenPeopleCost) : transactionDetailModel.vipPurchasedTicket!.amount;

                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor4People ? 4 + transactionDetailModel.vipPurchasedTicket!.quantity : transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor8People ? 8 + transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor10People ? 10 + transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.vipPurchasedTicket!.quantity=   isTableFor6People ? 6+ transactionDetailModel.vipPurchasedTicket!.quantity: transactionDetailModel.vipPurchasedTicket!.quantity;
                                            transactionDetailModel.totalPeopleTableServices = transactionDetailModel.vipPurchasedTicket!.quantity;

                                             }


                                                } else  transactionDetailModel.vipPurchasedTicket!.amount=0;
                transactionDetailModel.purchasedTickets.clear();
                if(earlyBirdController.text.isNotEmpty &&  int.parse(earlyBirdController.text)!=0) transactionDetailModel.purchasedTickets.add(transactionDetailModel.earlyBirdPurchasedTicket);
                if( (vipController.text.isNotEmpty  && int.parse(vipController.text)!=0) || isTableFor4People || isTableFor8People || isTableFor10People || isTableFor6People)  transactionDetailModel.purchasedTickets.add(transactionDetailModel.vipPurchasedTicket);
                if( regularController.text.isNotEmpty &&  int.parse(regularController.text)!=0)  transactionDetailModel.purchasedTickets.add(transactionDetailModel.regularPurchasedTicket);
                if( skippingLineController.text.isNotEmpty &&  int.parse(skippingLineController.text)!=0)  transactionDetailModel.purchasedTickets.add(transactionDetailModel.skippingLinePurchasedTicket);


                                    print(transactionDetailModel.purchasedTickets.toList());

                                    CustomNavigator.navigateTo(context, PaymentMethodsPage(
                                      discountPercent: discountAmount,
                                      amount: amount,
                                      earlyBirdController: earlyBirdController.text,
                                      regularController: regularController.text,
                                      vipController: vipController.text,
                                      skippingLineController: skippingLineController.text,
                                      // isTableFor4People: isTableFor4People,
                                      // isTableFor10People: isTableFor10People,
                                      // isTableFor8People: isTableFor8People,
                                      // isTableFor6People: isTableFor6People,
                                      transactionDetailModel: transactionDetailModel,
                                      event: event,
                                      isPay: true,
                                    ));
                                        // Navigator.pushNamed(context, '/paymentMethods');
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: globalGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text('Pay Now'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
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
                ),
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
