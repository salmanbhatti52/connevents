import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConneventAppBar extends StatelessWidget implements PreferredSizeWidget{
  bool isNavigate;
  void Function()? onPressed;
   ConneventAppBar({Key? key, this.onPressed,this.isNavigate=true}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 14,
        title: Row(
          children: [
            TextButton(
              onPressed: () =>  Navigator.pop(context) ,
              child: Row(
                children: [
                  Icon(Icons.chevron_left),
                  Text('Back'),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
