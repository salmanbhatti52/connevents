import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
class ConneventsTextField extends StatefulWidget {

  final String? Function(String?)? validator;
  final String? name;
  Color? color;
  bool  isTextFieldEnabled;
  final TextInputType? keyBoardType;
  final String? value;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Color? textColor;
  final Color? hintStyleColor;
  final Color? cursorColor;
  final IconData? icon;
  final Color?  iconColor;
  final Color? borderColor;
  final Color? errorTextColor;
  final String? hintText;
  final int? maxLines;
  ConneventsTextField({Key? key,this.color=Colors.white,this.isTextFieldEnabled=true,this.maxLines,this.onChanged,this.hintText,this.value,this.name,this.icon,this.controller,this.validator,this.keyBoardType,this.borderColor,this.cursorColor,this.errorTextColor,this.hintStyleColor,this.iconColor,this.onFieldSubmitted,this.onSaved,this.textColor}) : super(key: key);

  @override
  _ConneventsTextFieldState createState() => _ConneventsTextFieldState();
}

class _ConneventsTextFieldState extends State<ConneventsTextField> {

  final _node=FocusNode();

  @override
  void initState() {
    super.initState();
    _node.addListener(_listenToFocus);
  }

  _listenToFocus() => setState(() {});
  @override
  void dispose() {
    _node.removeListener(_listenToFocus);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(


      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: globalLGray, blurRadius: 5),
        ],
      ),
      child: TextFormField(
        focusNode: _node,
        initialValue: widget.value,
        onSaved: widget.onSaved,
        controller: widget.controller,
        enabled: widget.isTextFieldEnabled,
        textCapitalization: TextCapitalization.sentences,
      //  inputFormatters: widget.onlyNumbers! ? [FilteringTextInputFormatter.digitsOnly] : null,
        validator: widget.validator,
        textInputAction: TextInputAction.newline,
        onFieldSubmitted: widget.onFieldSubmitted ?? (val){},
        onChanged: widget.onChanged ?? (val){},
        keyboardType: widget.keyBoardType,
        maxLines: widget.maxLines,
        style: TextStyle(
          color: globalBlack,
          height: 1.7,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: widget.color,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: globalBlack.withOpacity(0.5),
            fontSize: 14,
            height: 1.7,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
//
// class PaintingPasswordField extends StatefulWidget {
//   final String? label;
//   final bool? disabled;
//   final IconData ?icon;
//   final String? value;
//   final BuildContext? context;
//   final TextInputType? keyboardType;
//   final EdgeInsets? scrollPadding;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final Function(String?)? onSaved;
// final String? hintText;
//   PaintingPasswordField({
//     this.icon,
//     this.value,
//     this.hintText,
//     this.label,
//     this.disabled = false,
//     this.scrollPadding = const EdgeInsets.all(100),
//     this.keyboardType,
//     this.context,
//     this.onSaved,
//     this.controller,
//     this.validator,
//   });
//
//   @override
//   _PaintingPasswordFieldState createState() => _PaintingPasswordFieldState();
// }
//
// class _PaintingPasswordFieldState extends State<PaintingPasswordField> {
//   bool _show = true;
//   final _node = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     _node.addListener(_listenToFocus);
//   }
//
//   _listenToFocus() => setState(() {});
//
//   @override
//   Widget build(BuildContext context) {
//     var fontSize=MediaQuery.of(context).size.width;
//
//     return  TextFormField(
//       //  textAlign: TextAlign.left,
//       //  enabled: widget.disabled,
//         focusNode: _node,
//         obscureText: _show,
//         keyboardType: widget.keyboardType,
//         textInputAction: TextInputAction.next,
//         onSaved: widget.onSaved,
//         validator: widget.validator,
//         initialValue: widget.value,
//         controller: widget.controller,
//         scrollPadding: widget.scrollPadding!,
//         decoration: InputDecoration(
//             //---------Enable Border
//             hintText: widget.hintText,
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(13),
//                 borderSide: BorderSide(
//                     width: 1.7,
//                     color: Colors.pinkAccent
//                 )
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(13),
//                 borderSide: BorderSide(
//                     width: 1.7,
//                     color: kMainColor
//                 )
//             ),
//
//             //--------Focus Border , When tap on textField
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(13.0)),
//               borderSide: BorderSide(color: kMainColor, width: 1.7),
//             ),
//
//
//             //-------  Error ------------
//             enabled: true,
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(13.0)),
//               borderSide: BorderSide(color: kMainColor, width: 1.7),
//             ),
//
//
//             suffix: GestureDetector(
//               child: Text(_show
//                   ?"Show"
//                   : "Hide",
//                   style: TextStyle(
//                       height: 1,
//                       color: _node.hasFocus
//                           ? Color(0xff3f3f3f)
//                           : Colors.grey
//                   )),
//               onTap: () => setState(() => _show = !_show),
//             )
//         ),
//
//       );
//
//   }
//
//   @override
//   void dispose() {
//     _node.removeListener(_listenToFocus);
//     super.dispose();
//   }
// }
