import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class ActionBar extends StatefulWidget {
    final EventDetail? event;
   final Widget child;

  const ActionBar({Key? key,this.event,required this.child, }) : super(key: key);

  @override
  _ActionBarState createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(color:widget.event!.dressCodeColor!=null ? Color(int.parse(widget.event!.dressCodeColor!)):null),
            padding: EdgeInsets.only(top: padding / 2),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: widget.child,
    ));
  }
}
