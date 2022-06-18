import 'package:connevents/pages/planDetails/planDetailsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/variables/sharingModels.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


enum Plans { organizer,business }

class ChosePlanPage extends StatefulWidget {
  const ChosePlanPage({Key? key}) : super(key: key);

  @override
  State<ChosePlanPage> createState() => _ChosePlanPageState();
}

class _ChosePlanPageState extends State<ChosePlanPage> {

  bool isPremium=false;
  Plans _plans = Plans.organizer;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () =>Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left, color: Colors.white),
                      Text('Back', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(padding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Plans', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: padding),
                    Text('Choose Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: globalGolden)),
                    // SizedBox(height: padding * 4),
                    // Text('Organizer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: globalGolden)),
                    SizedBox(height: padding * 4),
                    // Row(
                    //   children: [
                    //      Expanded(
                    //        child: Theme(
                    //          data: Theme.of(context).copyWith(
                    //           unselectedWidgetColor: Colors.white,
                    //           disabledColor: Colors.red
                    //         ),
                    //          child: ListTile(
                    //           contentPadding:EdgeInsets.zero,
                    //           horizontalTitleGap: 0,
                    //           minLeadingWidth: 0,
                    //            minVerticalPadding: 0,
                    //           title: const Text('Organizer',style: TextStyle(color: globalGolden)),
                    //           leading: Radio(
                    //             activeColor: globalGolden,
                    //             value: Plans.organizer,
                    //             groupValue: _plans,
                    //             onChanged: (Plans? value) {
                    //               setState(() {
                    //                 _plans = value!;
                    //               });
                    //             },
                    //           ),
                    //     ),
                    //        ),
                    //      ),
                    //      Expanded(
                    //         child: Theme(
                    //            data: Theme.of(context).copyWith(
                    //              unselectedWidgetColor: Colors.white,
                    //             disabledColor: Colors.red,
                    //            secondaryHeaderColor: Colors.white,
                    //            selectedRowColor: Colors.white
                    //         ),
                    //           child: ListTile(
                    //             contentPadding:EdgeInsets.zero,
                    //             horizontalTitleGap: 0,
                    //             minLeadingWidth: 0,
                    //             minVerticalPadding: 0,
                    //             title: const Text('Business',style: TextStyle(color: globalGolden)),
                    //             leading: Radio(
                    //               activeColor: globalGolden,
                    //               value: Plans.business,
                    //               groupValue: _plans,
                    //               onChanged: (Plans? value) {
                    //                 setState(() {
                    //                   _plans = value!;
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('premium Account'.toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        onPressed: () {
                          planType = 'premium';
                          CustomNavigator.navigateTo(context, PlanDetailsPage(
                            planType: planType,
                          ));
// n                          Navigator.pushNamed(context, '/planDetails');
                        },
                      ),
                    ),
                    SizedBox(height: padding * 2),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('One time post'.toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                           planType = 'oneType';
                          CustomNavigator.navigateTo(context, PlanDetailsPage(
                            planType: planType,
                          ));

                          // Navigator.pushNamed(context, '/planDetails');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
