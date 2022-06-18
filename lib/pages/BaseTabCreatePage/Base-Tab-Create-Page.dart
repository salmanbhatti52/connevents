import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BaseTabCreatePage extends StatefulWidget {
  Function(String) selectedSegment;
   BaseTabCreatePage({Key? key,required this.selectedSegment}) : super(key: key);

  @override
  _BaseTabCreatePageState createState() => _BaseTabCreatePageState();
}

class _BaseTabCreatePageState extends State<BaseTabCreatePage> with TickerProviderStateMixin{
   String selectedSegment = 'Events';
   PermissionStatus? _permissionStatus;




  //  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //       () async {
  //     _permissionStatus = await Permission.storage.status;
  //     if (_permissionStatus != PermissionStatus.granted) {
  //       PermissionStatus permissionStatus= await Permission.storage.request();
  //       setState(() {
  //         _permissionStatus = permissionStatus;
  //       });
  //     }
  //   }();
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 30,
       decoration: BoxDecoration(
       color: globalLightButtonbg,
       borderRadius: BorderRadius.circular(30),
       ),
       child: Row(
         children: [
           Expanded(
             child: Container(
               clipBehavior: Clip.antiAlias,
               decoration: (selectedSegment == 'Events') ? BoxDecoration(
               color: Colors.white,
               border: Border.all(color: globalGreen),
               borderRadius: BorderRadius.circular(30))
               : BoxDecoration(),
               child: TextButton(
                 onPressed: () {
                   setState(() {
                     selectedSegment = 'Events';
                     widget.selectedSegment(selectedSegment);
                   });
                 },
                 child: Text('Events',style: TextStyle(color: Colors.black, fontSize: 12,
                   ),
                 ),
               ),
             ),
           ),
           Expanded(
             child: Container(
               clipBehavior: Clip.antiAlias,
               decoration: (selectedSegment == 'Business') ?
               BoxDecoration(
               color: Colors.white,
               border: Border.all(color: globalGreen),
               borderRadius: BorderRadius.circular(30))
               : BoxDecoration(),
               child: TextButton(
               onPressed: ()  {
                 setState(() {
                     selectedSegment = 'Business';
                     widget.selectedSegment(selectedSegment);
                   });
               },
               child: Text('Business', style: TextStyle(color: Colors.black, fontSize: 12,
                 ),
               )),
             ),
           ),
         ],
       ),
      );
  }
}
