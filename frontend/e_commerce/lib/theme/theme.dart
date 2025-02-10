import 'package:flutter/material.dart';

const Color mainColor = Colors.deepOrange;
const Color blackColor = Colors.black;
const Color pinkColor = Colors.pink;
const Color darkSettings = Color(0xff6132e4);
const Color logOutSettting = Color(0xff5f95ef);



class ThemeApp { 
  static final light = ThemeData(
            primaryColor: mainColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
  );
  static final dark = ThemeData(
    primaryColor: blackColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackColor,
  );

}