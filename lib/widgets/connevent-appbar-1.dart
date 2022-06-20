import 'package:flutter/material.dart';

class ConneventAppBar1 extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const ConneventAppBar1({Key? key,this.title=""}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
       leading: TextButton(
            onPressed: () =>Navigator.pop(context),
            child: Row(
              children: [
                Icon(Icons.chevron_left,color: Colors.white),
                Text('Back',style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        leadingWidth: 80,
        title: Text(title),
        elevation: 0.0,
        centerTitle: true,
      );
  }
}
