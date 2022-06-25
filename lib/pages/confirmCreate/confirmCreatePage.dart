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

class ConfirmCreatePage extends StatefulWidget {

  final TimeOfDay selectedEventStartTime;
  final TimeOfDay selectedEventEndTime;
  final TimeOfDay selectedSalesStartTime;
  final TimeOfDay selectedSalesEndTime;
  final EventDetail event;

  const ConfirmCreatePage(
      {Key? key,  required this.selectedEventStartTime,required this.selectedEventEndTime,required this.selectedSalesEndTime,required this.selectedSalesStartTime , required this.event,})
      : super(key: key);

  @override
  State<ConfirmCreatePage> createState() => _ConfirmCreatePageState();
}

class _ConfirmCreatePageState extends State<ConfirmCreatePage> {

  bool isSelectedterms=false;

  @override
  Widget build(BuildContext context) {


    Uint8List firstImage = base64Decode(widget.event.firstImage);
    Uint8List secondImage = base64Decode(widget.event.secondImage);
    Uint8List thirdImage = base64Decode(widget.event.thirdImage);
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
 if(firstImage.isNotEmpty) Image.memory(firstImage, fit: BoxFit.cover),
if(secondImage.isNotEmpty)   Image.memory(secondImage, fit: BoxFit.cover),
if(thirdImage.isNotEmpty)    Image.memory(thirdImage, fit: BoxFit.cover),
  if(widget.event.firstThumbNail !=null)   thumbNail(widget.event.firstThumbNail!),
        if(widget.event.secondThumbNail !=null) thumbNail(widget.event.secondThumbNail!),
if(widget.event.thirdThumbNail !=null  )      thumbNail(widget.event.thirdThumbNail!),
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
                      Text(widget.event.eventTypeData!.eventType.toString(), style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
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
                SizedBox(height: padding * 2),
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
                SizedBox(height: padding * 2,),
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
                SizedBox(height: padding),
                Text(widget.event.description.toString(), style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
               if(!event.isFreeEvent && !event.isNotMyEvent)
                SizedBox(height: padding * 2),
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
                SizedBox(height: padding),
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
               if(!event.isFreeEvent && !event.isNotMyEvent)
                SizedBox(height: padding * 2),
                if(!event.isFreeEvent && !event.isNotMyEvent)

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
                if(!event.isFreeEvent && !event.isNotMyEvent)
                SizedBox(height: padding),
                if(!event.isFreeEvent && !event.isNotMyEvent)
                Text('${widget.event.discountPercent}% on buying more than ${widget.event.minTicketsDiscount} tickets', style: TextStyle(color: globalBlack, fontWeight: FontWeight.w300, fontSize: 14,),),
               if(!event.isFreeEvent && !event.isNotMyEvent)
                SizedBox(height: padding * 2),
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
                SizedBox(height: padding),
                // if(!event.isFreeEvent && !event.isNotMyEvent)
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Text('Table Service', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                //         SizedBox(width: padding,),
                //         GestureDetector(
                //             onTap: (){
                //                Navigator.of(context).pop(widget.event);
                //                Navigator.of(context).pop();
                //             },
                //             child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                //       ],
                //     ),
                //     widget.event.tableService==0 ? Icon(Icons.close, color: Colors.red,) : Icon(Icons.check, color: globalGreen),
                //   ],
                // ),
                // if(!event.isFreeEvent && !event.isNotMyEvent)
                // SizedBox(height: padding * 2),
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
               if(!event.isFreeEvent && !event.isNotMyEvent)
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
                if(!event.isFreeEvent && !event.isNotMyEvent)
                SizedBox(height: padding * 2),
                if(!event.isFreeEvent && !event.isNotMyEvent)
                Row(
                  children: [
                    Text('Dress Code', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 18,),),
                    SizedBox(width: padding,),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop(widget.event);
                        },
                        child: SvgPicture.asset('assets/icons/editPencil1.svg', width: 16,)),
                  ],
                ),
                if(!event.isFreeEvent && !event.isNotMyEvent)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.event.dressCodeData!.dressCode.toString(), style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.w600,),),
                    Icon(Icons.circle,
                        color:widget.event.dressCodeData!.dressCode=='Business'
                            ? Color(0xff000080):
                        widget.event.dressCodeData!.dressCode=='Casual'?
                        Color(0xff000080):
                        widget.event.dressCodeData!.dressCode=='As specified in description'?
                        Color(0xf00ff00):
                        widget.event.dressCodeData!.dressCode=='Cocktail'?
                        Color(0xffff0000):
                        widget.event.dressCodeData!.dressCode=='Formal'?
                        Color(0xff000000): null),
                  ],
                ),
                if(!event.isFreeEvent && !event.isNotMyEvent)
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
                    SizedBox(height: padding / 2),
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
                    SizedBox(height: padding),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.black),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("By clicking on the button below, I acknowledge that I have reviewed the Privacy Policy and Terms of Use",style: TextStyle(color: Colors.black)),
                        selectedTileColor: Colors.green,
                        value: isSelectedterms,
                        activeColor: Colors.green,
                        onChanged: (newValue) {
                          setState(() {
                            isSelectedterms=newValue!;
                            print(isSelectedterms);
                          });

                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding * 2),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async{

                      if(!isSelectedterms) return showErrorToast("You have to accept terms & Condition");

                           openLoadingDialog(context, "creating");
                            DateTime salesStartTime=DateTime.now();
                             DateTime salesEndTime=DateTime.now();

                            final f = new DateFormat('yyyy-MM-dd');
                            if(!event.isFreeEvent && !event.isNotMyEvent){
                                 salesStartTime= DateFormat("hh:mma").parse(widget.event.salesStartTime);
                                 salesEndTime= DateFormat("hh:mma").parse(widget.event.salesEndTime);
                            }
                          DateTime eventStartTime= DateFormat("hh:mma").parse(widget.event.eventStartTime);
                          DateTime eventEndTime= DateFormat("hh:mma").parse(widget.event.eventEndTime);

                        // try{
                          final response= await DioService.post('create_event_post',{
                            "title": widget.event.title,
                            "userId": AppData().userdetail!.users_id,
                            if(widget.event.firstImage.isNotEmpty)
                            "firstImageBasecode": widget.event.firstImage,
                            if(widget.event.secondImage.isNotEmpty)
                           "secondImageBasecode": widget.event.secondImage,
                           if(widget.event.thirdImage.isNotEmpty)
                           "thirdImageBasecode": widget.event.thirdImage,
                           if(widget.event.first_video_thumbnail.isNotEmpty)
                           "firstVideoThumbnail": widget.event.first_video_thumbnail,
                            if(widget.event.second_video_thumbnail.isNotEmpty)
                          "secondVideoThumbnail":widget.event.second_video_thumbnail,
                           if(widget.event.third_video_thumbnail.isNotEmpty)
                           "thirdVideoThumbnail":widget.event.third_video_thumbnail,
                           if(widget.event.firstVideo.isNotEmpty)
                          "firstVideo": widget.event.firstVideo,
                          if(widget.event.secondVideo.isNotEmpty)
                           "secondVideo": widget.event.secondVideo,
                          if(widget.event.thirdVideo.isNotEmpty)
                           "thirdVideo": widget.event.thirdVideo,
                            "eventTypeId": widget.event.eventTypeData!.eventTypeId,
                            "eventCategoryId": widget.event.category!.categoryId,
                            if(widget.event.eventTags!.isNotEmpty)
                            "tags": widget.event.eventTags,
                            "eventStartDate": f.format(widget.event.pickedEventStartDate!),
                            "eventStartTime": DateFormat("HH:mm:ss").format(eventStartTime),
                            "eventEndDate": f.format(widget.event.pickedEventEndDate!),
                            "eventEndTime": DateFormat("HH:mm:ss").format(eventEndTime),
                            "eventDescription": widget.event.description,
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "tickets": widget.event.list,
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "discountPercent": widget.event.discountPercent,
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "minTicketsDiscount": widget.event.minTicketsDiscount,
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "refundable": widget.event.refundable,
                            // if(!event.isFreeEvent && !event.isNotMyEvent)
                            // "tableService": widget.event.tableService,
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "salesStartDate": f.format(widget.event.pickedSalesStartDate!),
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "salesStartTime": DateFormat("HH:mm:ss").format(salesStartTime),
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "salesEndDate": f.format(widget.event.pickedSalesEndDate!),
                           if(!event.isFreeEvent && !event.isNotMyEvent)
                            "salesEndTime": DateFormat("HH:mm:ss").format(salesEndTime),
                            if(!event.isFreeEvent && !event.isNotMyEvent)
                            "dressCodeId": widget.event.dressCodeData!.dressCodeId,
                            "fullAddress": widget.event.eventAddress!.fullAddress,
                            "city": widget.event.eventAddress!.city,
                            "state": widget.event.eventAddress!.state,
                            "zip": widget.event.eventAddress!.zip,
                            "locationLong": widget.event.locationLong,
                            "locationLat": widget.event.locationLat,
                            "hyperlink" :widget.event.hyperlink,
                             "eventTicketType": event.isFreeEvent ? "MyFreeEvent" : event.isNotMyEvent ? "NotMyEvent" : "Paid",
                            // if( (!event.isFreeEvent && !event.isNotMyEvent) && widget.event.isTableAvailableFor4People )
                            //  "tblFourPeopleCost": widget.event.tblFourPeopleCost,
                            // if( (!event.isFreeEvent && !event.isNotMyEvent) && widget.event.isTableAvailableFor6People  )
                            //  "tblSixPeopleCost": widget.event.tblSixPeopleCost,
                            // if( (!event.isFreeEvent && !event.isNotMyEvent) &&  widget.event.isTableAvailableFor8People )
                            //  "tblEightPeopleCost": widget.event.tblEightPeopleCost,
                            // if( (!event.isFreeEvent && !event.isNotMyEvent)  && widget.event.isTableAvailableFor10People )
                            //   "tblTenPeopleCost": widget.event.tblTenPeopleCost,
                          });


                      if(response['status']=='success'){
                             print(response);
                             AppData().userdetail!.one_time_post_count=response['one_time_post_count'];
                             showSuccessToast("Your Event has been Created Successfully");
                          event=EventDetail( earlyBird: EarlyBird(), regular: Regular(), vip: VIP(), eventAddress: EventAddress(),skippingLine: SkippingLine());

                          Navigator.pop(context);
                          CustomNavigator.pushReplacement(context,TabsPage());
                           }
                           else{
                             Navigator.of(context).pop();
                             showSuccessToast("Your Event has not been Created Successfully");
                           }
                        // } catch(e) {
                        //   print(e.toString);
                        //   Navigator.of(context).pop();
                        //   showErrorToast(e.toString());
                        // }

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
                       event=EventDetail(  earlyBird: EarlyBird(), regular: Regular(), vip: VIP(), eventAddress: EventAddress(),skippingLine: SkippingLine());
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
