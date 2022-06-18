import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InviteSentPage extends StatelessWidget {
  const InviteSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.chevron_left,
                  color: globalGreen,
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    color: globalGreen,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.all(padding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Invite sent',
                    style: TextStyle(
                      color: globalBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: padding * 2,
                  ),
                  SvgPicture.asset(
                    'assets/imgs/inviteSent.svg',
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.all(padding * 2),
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'BACK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
