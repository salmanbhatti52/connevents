import 'dart:io';
import 'dart:typed_data';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/pages/createEvent/createPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class EditConfirmCreatePage extends StatefulWidget {
  final String selectedEventStartTime;
 final String selectedEventEndTime;
 final TimeOfDay selectedSalesStartTime;
 final TimeOfDay selectedSalesEndTime;
  final EventDetail event;

  const EditConfirmCreatePage(
      {Key? key,required this.selectedEventStartTime,required this.selectedEventEndTime,required this.selectedSalesEndTime,required this.selectedSalesStartTime , required this.event,})
      : super(key: key);

  @override
  State<EditConfirmCreatePage> createState() => _EditConfirmCreatePageState();
}

class _EditConfirmCreatePageState extends State<EditConfirmCreatePage> {

  String firstNetworkImage="";
  String secondNetworkImage="";
  String thirdNetworkImage="";
  Uint8List? firstImage;
  Uint8List? secondImage;
  Uint8List? thirdImage;


  @override
  Widget build(BuildContext context) {

if(widget.event.firstImage.contains('https')) firstNetworkImage = widget.event.firstImage; else   firstImage = base64Decode(widget.event.firstImage);
if(widget.event.secondImage.contains('https')) secondNetworkImage = widget.event.secondImage; else  secondImage = base64Decode(widget.event.secondImage);
if(widget.event.thirdImage.contains('https')) thirdNetworkImage = widget.event.thirdImage; else  thirdImage = base64Decode(widget.event.thirdImage);
print(secondImage);





    // var dateFormat = DateFormat.yMMMd();


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(padding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Confirm Post', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 30,),),
                    SizedBox(width: padding),
                    GestureDetector(
                        onTap: (){
                           Navigator.of(context).pop(widget.event);
                           Navigator.of(context).pop(widget.event);
                           Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16)),
                  ],
                ),
                SizedBox(height: padding),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.75,
                  mainAxisSpacing: padding / 2,
                  crossAxisSpacing: padding / 2,
                  children: [
 if(firstImage !=null && firstImage!.isNotEmpty ) Container(  child: Image.memory(firstImage!, fit: BoxFit.cover)) else if(firstNetworkImage.isNotEmpty) Container(child: Image.network(firstNetworkImage,fit: BoxFit.cover)) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
if(secondImage!=null && secondImage!.isNotEmpty)   Container(child: Image.memory(secondImage!, fit: BoxFit.cover)) else if(secondNetworkImage.isNotEmpty) Image.network(secondNetworkImage,fit: BoxFit.cover) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
if(thirdImage!=null && thirdImage!.isNotEmpty )    Container(child: Image.memory(thirdImage!, fit: BoxFit.cover)) else if(thirdNetworkImage.isNotEmpty) Image.network(thirdNetworkImage,fit: BoxFit.cover) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
  if(widget.event.firstThumbNail !=null && widget.event.firstThumbNail!.isNotEmpty)   thumbNail(widget.event.firstThumbNail!)  else if(widget.event.first_video_thumbnail.isNotEmpty ) Image.network(widget.event.first_video_thumbnail,fit: BoxFit.cover) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
        if(widget.event.secondThumbNail !=null && widget.event.secondThumbNail!.isNotEmpty) thumbNail(widget.event.secondThumbNail!) else if(widget.event.second_video_thumbnail.isNotEmpty ) Image.network(widget.event.second_video_thumbnail,fit: BoxFit.cover) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
if(widget.event.thirdThumbNail !=null  && widget.event.thirdThumbNail!.isNotEmpty)      thumbNail(widget.event.thirdThumbNail!) else if(widget.event.third_video_thumbnail.isNotEmpty ) Image.network(widget.event.third_video_thumbnail,fit: BoxFit.cover) else Container(alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: Colors.black)),child :Center(child: Text("No Image Selected",textAlign: TextAlign.center,style: TextStyle(color: Colors.black)))),
                  ],
                ),
                SizedBox(height: padding * 2,),
                Row(
                  children: [
                    Text('Event Type and Category', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                      onTap: (){
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text(widget.event.eventTypeData!.eventType!, style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Category', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text(widget.event.category!.category.toString(), style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                    ],
                  ),
                ),
                SizedBox(height: padding * 2,),
                Row(
                  children: [
                    Text('Tags', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                SizedBox(height: padding,),
                Wrap(
                  spacing: 8.0,
                  children: widget.event.eventTags!.map((e) => Text("${e.tagName.toString() }", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),)).toList(),
                ),
                SizedBox(height: padding * 2),
                Row(
                  children: [
                    Text('Event Date & Time', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop(widget.event);
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text("${widget.event.eventStartDate} - ${widget.event.eventStartTime}", style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,
                      ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text('${widget.event.eventEndDate} - ${widget.event.eventEndTime}', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                    ],
                  ),
                ),
                SizedBox(height: padding * 2),
                Row(
                  children: [
                    Text('Event Description', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop(widget.event);
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                SizedBox(height: padding,),
                Text(widget.event.description.toString(), style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                SizedBox(height: padding * 2,),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  children: [
                    Text('Tickets Detail', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                      onTap: (){
                         Navigator.of(context).pop(widget.event);
                         Navigator.of(context).pop(widget.event);
                      },
                      child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,
                      ),
                    ),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding),
                if(widget.event.eventTicketType=='Paid')
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Ticket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                        ),
                        Expanded(
                            child: Center(
                                child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Price ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                              Text('\$', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2,),
                    if(widget.event.earlyBird!.isVisible)
                    Row(
                      children: [
                        Expanded(
                          child: Text('Early bird', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(widget.event.earlyBird!.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.event.earlyBird!.price.toString(), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2),
                    if(widget.event.regular!.isVisible)
                    Row(
                      children: [
                        Expanded(
                          child: Text('Regular', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(widget.event.regular!.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.event.regular!.price.toString(), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2),
                    if(widget.event.vip!.isVisible)
                    Row(
                      children: [
                        Expanded(
                          child: Text('VIP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(widget.event.vip!.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.event.vip!.price.toString(), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2),
                    if(widget.event.skippingLine!.isVisible)
                      Row(
                        children: [
                          Expanded(
                            child: Text('Skipping Line', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                          ),
                          Expanded(
                              child: Center(
                                  child: Text(widget.event.skippingLine!.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(widget.event.skippingLine!.price.toString(), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding * 2),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  children: [
                    Text('Discount Promo', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding),
                if(widget.event.eventTicketType=='Paid')
                Text('${widget.event.discountPercent}% on buying more than ${widget.event.minTicketsDiscount} tickets', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
               if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding * 2),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Refundable', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                        SizedBox(width: padding,),
                        GestureDetector(
                            onTap: (){
                               Navigator.of(context).pop(widget.event);
                               Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                      ],
                    ),
                    widget.event.refundable == 1 ? Icon(Icons.check, color: globalGreen) : Icon(Icons.close, color: Colors.red,),
                  ],
                ),
               if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Table Service', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                        SizedBox(width: padding,),
                        GestureDetector(
                            onTap: (){
                               Navigator.of(context).pop(widget.event);
                               Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                      ],
                    ),
                    widget.event.tableService==0 ? Icon(Icons.close, color: Colors.red,) : Icon(Icons.check, color: globalGreen),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding * 2),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  children: [
                    Text('Sales Date & Time', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                           Navigator.of(context).pop(widget.event);
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Start', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text('${widget.event.salesStartDate} - ${widget.event.salesStartTime}', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                    ],
                  ),
                ),
                if(widget.event.eventTicketType=='Paid')
                Padding(
                  padding: const EdgeInsets.only(top: padding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('End', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                      Text('${widget.event.salesEndDate} - ${widget.event.salesEndTime}', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                    ],
                  ),
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding * 2),
                if(widget.event.eventTicketType =='Paid')
                Row(
                  children: [
                    Text('Dress Code', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                SizedBox(height: padding),
                if(widget.event.eventTicketType=='Paid')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.event.dressCode!.dressCode.toString(), style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.w600,),),
                    Icon(Icons.circle, color: Colors.red,),
                  ],
                ),
                if(widget.event.eventTicketType=='Paid')
                SizedBox(height: padding * 2),
                Row(
                  children: [
                    Text('Address', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: ()=>Navigator.of(context).pop(widget.event),
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                SizedBox(height: padding,),
                Text(widget.event.eventAddress!.fullAddress.toString(), style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
                SizedBox(height: padding,),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('City', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                        ),
                        Expanded(
                            child: Center(
                                child: Text('State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Zip ', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.event.eventAddress!.city.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(widget.event.eventAddress!.state.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),))),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.event.eventAddress!.zip.toString(), textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: padding / 2),
                  ],
                ),
                SizedBox(height: padding * 2),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async{
                      print(widget.event.firstImage);


                     openLoadingDialog(context, "editing");
                            final f = new DateFormat('yyyy-MM-dd');
                             DateTime? salesEndTime;
                             DateTime? salesStartTime;
                           if(widget.event.eventTicketType=="Paid"){
                           salesEndTime= DateFormat("hh:mma").parse(widget.event.salesEndTime.replaceAll(' ', ''));
                           salesStartTime= DateFormat("hh:mma").parse(widget.event.salesStartTime.replaceAll(' ', ''));
                                            }
                          DateTime eventStartTime= DateFormat("hh:mma").parse(widget.event.eventStartTime.replaceAll(' ', ''));
                          DateTime eventEndTime= DateFormat("hh:mma").parse(widget.event.eventEndTime.replaceAll(' ', ''));

                          final response= await DioService.post('edit_event_post',{
                            "title": widget.event.title,
                            "userId": AppData().userdetail!.users_id,
                            "eventPostId": widget.event.eventPostId,
         if(widget.event.firstImage.isNotEmpty && !widget.event.firstImage.contains('https')) "firstImageBasecode": widget.event.firstImage,
       if(widget.event.secondImage.isNotEmpty  && !widget.event.secondImage.contains('https')) "secondImageBasecode": widget.event.secondImage,
        if(widget.event.thirdImage.isNotEmpty  && !widget.event.thirdImage.contains('https'))    "thirdImageBasecode": widget.event.thirdImage,
    if(widget.event.first_video_thumbnail.isNotEmpty && !widget.event.first_video_thumbnail.contains('https'))     "firstVideoThumbnail": widget.event.first_video_thumbnail,
     if(widget.event.second_video_thumbnail.isNotEmpty && !widget.event.second_video_thumbnail.contains('https'))    "secondVideoThumbnail":widget.event.second_video_thumbnail,
    if(widget.event.third_video_thumbnail.isNotEmpty && !widget.event.third_video_thumbnail.contains('https'))      "thirdVideoThumbnail":widget.event.third_video_thumbnail,
    if(widget.event.firstVideo.isNotEmpty && !widget.event.firstVideo.contains('https'))      "firstVideo": widget.event.firstVideo,
    if(widget.event.secondVideo.isNotEmpty && !widget.event.secondVideo.contains('https'))      "secondVideo": widget.event.secondVideo,
     if(widget.event.thirdVideo.isNotEmpty && !widget.event.thirdVideo.contains('https'))     "thirdVideo": widget.event.thirdVideo,
                            "eventTypeId": widget.event.eventTypeData!.eventTypeId,
                            "eventCategoryId": widget.event.category!.categoryId,
                             if(widget.event.eventTags!.isNotEmpty)
                            "tags": widget.event.eventTags,
                            "eventStartDate": f.format(widget.event.pickedEventStartDate!),
                            "eventStartTime": DateFormat("HH:mm:ss").format(eventStartTime),
                            "eventEndDate": f.format(widget.event.pickedEventEndDate!),
                            "eventEndTime": DateFormat("HH:mm:ss").format(eventEndTime),
                            "eventDescription": widget.event.description,
                            if(widget.event.eventTicketType=="Paid")
                            "tickets": widget.event.list,
                            if(widget.event.eventTicketType=="Paid")
                            "discountPercent": widget.event.discountPercent,
                            if(widget.event.eventTicketType=="Paid")
                            "minTicketsDiscount": widget.event.minTicketsDiscount,
                            if(widget.event.eventTicketType=="Paid")
                            "refundable": widget.event.refundable,
                            // if(widget.event.eventTicketType=="Paid")
                            // "tableService": widget.event.tableService,
                            if(widget.event.eventTicketType=="Paid")
                            "salesStartDate": f.format(widget.event.pickedSalesStartDate!),
                            if(widget.event.eventTicketType=="Paid")
                            "salesStartTime": DateFormat("HH:mm:ss").format(salesStartTime!),
                            if(widget.event.eventTicketType=="Paid")
                            "salesEndDate": f.format(widget.event.pickedSalesEndDate!),
                            if(widget.event.eventTicketType=="Paid")
                            "salesEndTime": DateFormat("HH:mm:ss").format(salesEndTime!),
                            if(widget.event.eventTicketType=="Paid")
                            "dressCodeId": widget.event.dressCode!.dressCodeId,
                            "fullAddress": widget.event.eventAddress!.fullAddress,
                            "city": widget.event.eventAddress!.city,
                            "state": widget.event.eventAddress!.state,
                            "zip": widget.event.eventAddress!.zip,
                            "locationLong": widget.event.locationLong,
                            "locationLat": widget.event.locationLat,
                            "eventTicketType": widget.event.eventTicketType,
                             "hyperlink" : widget.event.hyperlink,
                            // if(widget.event.isTableAvailableFor4People)
                            //  "tblFourPeopleCost": widget.event.tblFourPeopleCost,
                            // if(widget.event.isTableAvailableFor6People)
                            //  "tblSixPeopleCost": widget.event.tblSixPeopleCost,
                            // if(widget.event.isTableAvailableFor8People)
                            //  "tblEightPeopleCost": widget.event.tblEightPeopleCost,
                            // if(widget.event.isTableAvailableFor10People)
                            //   "tblTenPeopleCost": widget.event.tblTenPeopleCost,
                             if(widget.event.removedTickets!.length>0)
                             "removedTickets" : widget.event.removedTickets
                          });

                          print(response);

                           if(response['status']=='success'){
                             print(response);
                          showSuccessToast("Your Event has been Edit Successfully");
                          event=EventDetail(  earlyBird: EarlyBird(), regular: Regular(), vip: VIP(), eventAddress: EventAddress(),skippingLine: SkippingLine());
                          Navigator.pop(context);

                          CustomNavigator.pushReplacement(context,TabsPage());
                           }
                           else{
                             Navigator.of(context).pop();
                             showSuccessToast("Your Event has not been Edit Successfully");
                           }

                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Post'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),),
                ),
                SizedBox(height: padding),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                       CustomNavigator.pushReplacement(context, TabsPage());
                    },
                    child: Text('Cancel'.toUpperCase(), style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold,),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget thumbNail(String image) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: FileImage(File(image))
        ),
      ),);
  }
}
