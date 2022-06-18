import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ConfirmationAction<T> = FutureOr<T> Function();
typedef ConfirmationDialogBuilder = Widget Function(BuildContext);
typedef BuyTicketsDialogBuilder = Widget Function(BuildContext);

ConfirmationDialogBuilder defaultDialogBuilder = (context) {
  return AlertDialog(
    title: Text('Are you sure?'),
    actions: [
      TextButton(
        child: Text('Yes'),
        onPressed: () => Navigator.of(context).pop(true),
      ),
      TextButton(onPressed: Navigator.of(context).pop, child: Text('No')),
    ],
  );
};

BuyTicketsDialogBuilder buyTickets = (context) {
  return AlertDialog(
      title: Text("This Event Tickets has been Already Purchased ",style: TextStyle(fontSize: 16)),
      content:Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0),
      child: Container(
          height: 40,
          alignment: Alignment.topRight,
          child: TextButton(onPressed: Navigator.of(context).pop, child: Text("Close",style: TextStyle(fontSize: 14)))),
    ) ,
    );

};









BuyTicketsDialogBuilder salesEndTime = (context) {
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    title: Text("Event Tickets Sales Time is Ended ",style: TextStyle(fontSize: 16)),
    content:Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0),
      child: Container(
        height: 40,
          alignment: Alignment.topRight,
          child: TextButton(onPressed: Navigator.of(context).pop, child: Text("Close",style: TextStyle(fontSize: 14)))),
    ) ,



   //   title: Text("Event Tickets Sales Time is Ended",style: TextStyle(fontSize: 16)),
   //  content: Container(
   //    height: 50,
   //    child: Column(
   //      mainAxisAlignment: MainAxisAlignment.end,
   //      mainAxisSize: MainAxisSize.min,
   //      children: [
   //        Text("Event Tickets Sales Time is Ended",style: TextStyle(fontSize: 16)),
   //        TextButton(onPressed: Navigator.of(context).pop, child: Text("Close")),
   //      ],
   //    ),
   //  ),
    );

};






/// If a custom Dialog is passed here than you must return `true` on the
/// confirmation button for this utility to work correctly.
Future<T> showConfirmation<T>(
  BuildContext context, {
  ConfirmationDialogBuilder? builder,
  ConfirmationAction<T>? onConfirmed,
  ConfirmationAction<T>? onCanceled,
}) async {
  bool result;

  if (builder != null) {
    result = await showDialog(context: context, builder: builder);
  } else if (defaultDialogBuilder != null) {
    result = await showDialog(
      context: context,
      builder: defaultDialogBuilder,
    );
  } else {
    throw 'No Dialog Builder was provided';
  }

  if (result == true) {
    return onConfirmed!();
  } else {
    return onCanceled!();
  }
}
