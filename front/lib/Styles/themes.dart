import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Styles/textStyles.dart';

ThemeData defaultTheme = ThemeData(
  primaryColor: Color.fromRGBO(100, 93, 4, 1),
  backgroundColor: Color.fromRGBO(255, 235, 235, 1),
  // primarySwatch: Colors.pink,
  cardColor: Color.fromRGBO(141, 153, 174, 1),
  cardTheme: CardTheme(
      color: Color.fromRGBO(141, 153, 174, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          width: 3,
          color: Color.fromRGBO(43, 45, 66, 1),
        ),
      ),
      shadowColor: Color.fromRGBO(43, 45, 66, 1),
      elevation: 3),
  appBarTheme: AppBarTheme(
    color: Color.fromRGBO(217, 4, 41, 1),
    shadowColor: Color.fromRGBO(43, 45, 66, 1),
  ),
  dividerColor: Color.fromRGBO(43, 45, 66, 1),
  accentColor: Colors.indigo[900],
  // unselectedWidgetColor: Colors.blue,
  disabledColor: Colors.grey,
  // buttonColor: Color.fromRGBO(237, 242, 244, 1),
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(43, 45, 66, 1),
    disabledColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    caption: TextStyle(
      color: Colors.white,
      fontFamily: mainFontFamily,
      fontSize: 9,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontFamily: mainFontFamily,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
      fontFamily: mainFontFamily,
    ),
    headline6: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: mainFontFamily,
        fontWeight: FontWeight.bold),
    headline5: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontFamily: mainFontFamily,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontFamily: mainFontFamily,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Color.fromRGBO(217, 4, 41, 1),
      fontSize: 14,
      fontFamily: mainFontFamily,
    ),
  ),
  iconTheme: IconThemeData(
    color: Color.fromRGBO(43, 45, 66, 1),
  ),

  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: Color.fromRGBO(232, 93, 4, 1),
  ),
);
