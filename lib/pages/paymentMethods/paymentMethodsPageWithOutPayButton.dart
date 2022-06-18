import 'package:connevents/pages/addCreditCard/addCreditCardPage.dart';
import 'package:connevents/pages/menu/menuPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodsPageWithoutPayButton extends StatelessWidget {
  const PaymentMethodsPageWithoutPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
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
              Icon(Icons.chevron_left, color: globalGreen),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16)),
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
                    Text('Payment Method', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 32)),
                    SizedBox(height: padding),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: globalBlack)),
                          IconButton(
                            onPressed: () {
                              CustomNavigator.navigateTo(context, AddCreditCardPage());
                              // Navigator.pushNamed(context, '/addCreditCard');
                            },
                            icon: Icon(
                              Icons.add,
                              color: globalBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: padding,
                    ),
                    for (var i = 0; i < 2; i++)
                      Container(
                        padding: EdgeInsets.all(padding / 2),
                        margin: EdgeInsets.symmetric(vertical: padding / 2),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: globalLGray, blurRadius: 5),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/visa.svg', width: 53,),
                                  SizedBox(
                                    width: padding,
                                  ),
                                  Text(
                                    '************7342',
                                    style: TextStyle(
                                      color: globalBlack.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: padding),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: globalGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: padding * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wallet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: globalBlack,
                            ),
                          ),
                          SizedBox(
                            height: padding / 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(padding / 2),
                            margin: EdgeInsets.symmetric(vertical: padding / 2),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: globalGreen,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(color: globalLGray, blurRadius: 5),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/money.svg',
                                        width: 53,
                                      ),
                                      SizedBox(
                                        width: padding,
                                      ),
                                      Text(
                                        'ConnCash',
                                        style: TextStyle(
                                          color: globalBlack.withOpacity(0.8),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: padding,
                                ),
                                Text(
                                  '\$5',
                                  style: TextStyle(
                                    color: globalGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(padding),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    CustomNavigator.navigateTo(context, MenuPage());
                    // Navigator.pushNamed(context, '/menu');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: globalGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Close'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
