import 'package:flutter/material.dart';
import 'dimensions.dart';

final gilroyLight = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w300,
  fontSize: Dimensions.fontSizeDefault,
  color: Colors.black,
);

final gilroyRegular = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w300,
  fontSize: 15,
  color: Colors.black,
);

final gilroyExtraBold = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.bold,
  fontSize:  18,
  color: Colors.black,
);

final gilroyBold = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w900,
  fontSize: 16,
  color: Colors.black,
);

final gilroyBoldRed = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w600,
  fontSize: 22,
  color: Color(0xffF44336),
);



final gilroyMedium = TextStyle(
  fontFamily: 'Gilroy',
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: Colors.black,
);


final poppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
  color: Colors.black,
);

final poppinsSemiBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.fontSizeDefault,
  color: Colors.black,
);
final poppinsBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
  color: Colors.black,
);

final proximaExtraBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeLarge,
  color: Colors.black,
);
const textBlack = Colors.black;
const textColor = Color(0X99131212);
const textBtnColor = Colors.white;

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor: Colors.amber,
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
final boxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 0,
    blurRadius: 2,
    offset: Offset(0, 3), // changes position of shadow
  ),
];
final divider = Divider(height: 10, thickness: 10);
