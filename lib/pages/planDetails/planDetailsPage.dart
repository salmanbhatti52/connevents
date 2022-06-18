import 'package:connevents/pages/paymentCards/paymentCardsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/variables/sharingModels.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlanDetailsPage extends StatefulWidget {
 final String? planType;
  const PlanDetailsPage({Key? key,this.planType}) : super(key: key);

  @override
  State<PlanDetailsPage> createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  @override
  Widget build(BuildContext context) {
    int num = 0;
    if (widget.planType == 'premium') {
      num = 0;
    } else if (widget.planType == 'oneType') {
      num = 1;
    } else {
      Navigator.pop(context);
    }
    List plans = [
      {
        'name': 'Premium Package',
        'features': [
          'Pay only \$9.99 + tax/month for 1 month trial.',
          'Allow users and followers to see your events wherever they are in the world.',
          'Cancel anytime. See terms and conditions.',
        ],
        'price': '9.99',
        'isRecurring': true
      },
      {
        'name': 'One time Post',
        'features': [
          'Pay only \$14.99 + tax/post',
          'Allow users and followers to see your events wherever they are in the world.',
          'Cancel anytime. See terms and conditions.',
        ],
        'price': '14.99',
        'isRecurring': false
      },
    ];
    print('num is: $num');
    print('plan is: ${plans[num]}');
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      Text('Back', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(padding * 2),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plans[num]['name'],
                              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                            SizedBox(height: padding),
                            Text('What You’ll Get', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.normal,)),
                            SizedBox(height: padding * 3),
                            for (var i = 0; i < plans[num]['features'].length; i++)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: padding / 2),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/point.svg'),
                                    SizedBox(width: padding),
                                    Expanded(
                                      child: Text(
                                        plans[num]['features'][i],
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: padding * 2),
                            Row(
                              children: List.generate(
                                150 ~/ 2,
                                (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0 ? Colors.transparent : globalGolden,height: 2,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: padding * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$' + plans[num]['price'],
                                    style: TextStyle(
                                      color: globalGolden,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(plans[num]['name']=='Premium Package' ? '/Month' : '/Post', style: TextStyle(color: globalGolden, fontSize: 18, fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(
                                150 ~/ 2,
                                (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : globalGolden,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ),
                       if(widget.planType=="premium")     Container(
                              padding: EdgeInsets.symmetric(vertical: padding * 2),
                              child: Center(
                                child: Text('Monthly Recurring payments', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          CustomNavigator.navigateTo(context, PaymentCardsPage(
                            planType: widget.planType,
                          ));
                          // Navigator.pushNamed(context, '/paymentCards');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Proceed'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
