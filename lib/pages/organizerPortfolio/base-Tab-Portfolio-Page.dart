import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class BaseTabPortfolioPage extends StatefulWidget {
   Function(String) selectedSegment;
   BaseTabPortfolioPage({Key? key,required this.selectedSegment}) : super(key: key);

  @override
  _BaseTabPortfolioPageState createState() => _BaseTabPortfolioPageState();
}

class _BaseTabPortfolioPageState extends State<BaseTabPortfolioPage> with TickerProviderStateMixin{
   String selectedSegment = 'Portfolio';



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
               decoration: (selectedSegment == 'Portfolio') ? BoxDecoration(
               color: Colors.white,
               border: Border.all(color: globalGreen),
               borderRadius: BorderRadius.circular(30))
               : BoxDecoration(),
               child: TextButton(
                 onPressed: () {
                   setState(() {
                     selectedSegment = 'Portfolio';
                     widget.selectedSegment(selectedSegment);
                   });
                 },
                 child: Text('Portfolio',style: TextStyle(color: Colors.black, fontSize: 12,
                   ),
                 ),
               ),
             ),
           ),
           Expanded(
             child: Container(
               clipBehavior: Clip.antiAlias,
               decoration: (selectedSegment == 'Followers') ?
               BoxDecoration(
               color: Colors.white,
               border: Border.all(color: globalGreen),
               borderRadius: BorderRadius.circular(30))
               : BoxDecoration(),
               child: TextButton(
               onPressed: ()  {
                 setState(() {
                     selectedSegment = 'Followers';
                     widget.selectedSegment(selectedSegment);
                   });
               },
               child: Text('Followers', style: TextStyle(color: Colors.black, fontSize: 12,
                 ),
               )),
             ),
           ),
         ],
       ),
      );
  }
}
