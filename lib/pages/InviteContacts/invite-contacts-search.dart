import 'package:connevents/variables/globalVariables.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class InviteContactsSearch extends StatefulWidget {
  Contact contacts;
   InviteContactsSearch({Key? key,required this.contacts}) : super(key: key);

  @override
  _InviteContactsSearchState createState() => _InviteContactsSearchState();
}

class _InviteContactsSearchState extends State<InviteContactsSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: padding),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: globalLGray.withOpacity(0.7),
              blurRadius: 5,
            ),
          ],
        ),
        child: TextFormField(
          style: TextStyle(color: globalBlack,height: 1.5),
          onChanged: (value){
            print(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: globalBlack.withOpacity(0.5),
            ),
            hintText: 'Search For People',
            hintStyle: TextStyle(color: globalBlack.withOpacity(0.5),height: 1.5),
          ),
        ),
      );
  }
}
