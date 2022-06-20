import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class ShowSearchBar extends StatefulWidget {
 final Function(String text)? searchText;
 final Function(String text)? onSearch;
 final Function()? onClose;


   ShowSearchBar({Key? key,this.searchText,this.onClose,this.onSearch}) : super(key: key);

  @override
  _ShowSearchBarState createState() => _ShowSearchBarState();
}

class _ShowSearchBarState extends State<ShowSearchBar> {
    TextEditingController search=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: search,
        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: padding,left: 20),
          hintText: 'Type here...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.bold),
          suffixIcon: Container(
          width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed:() {

                    print(search.text);
                    if(search.text.isNotEmpty){
                     widget.onSearch!(search.text);
                    }
                    else
                      showErrorToast("Please Some Text");

                  },
                   icon: Icon(Icons.search, color: Colors.white)),
                IconButton(
                  onPressed: widget.onClose,
                  icon: Icon(Icons.close, color: Colors.white,),
                ),
              ],
            ),
          ),
          fillColor: globalGreen,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
