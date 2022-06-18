
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';

class BusinessActionBar extends StatefulWidget {
    final Business? event;
   final Widget child;

  const BusinessActionBar({Key? key,this.event,required this.child, }) : super(key: key);

  @override
  _BusinessActionBarState createState() => _BusinessActionBarState();
}

class _BusinessActionBarState extends State<BusinessActionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
      child: widget.child,
    );
  }
}
