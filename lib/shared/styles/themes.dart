import 'package:arabmedicine/main.dart';
import 'package:arabmedicine/shared/compontents/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("0d0d0d"),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  appBarTheme: AppBarTheme(
      //backwardsCompatibility: false,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
      backgroundColor: HexColor("0d0d0d"),
      titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      iconTheme: IconThemeData(
        color: Colors.white,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black,
    //showSelectedLabels: false,
    showUnselectedLabels: false,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue,
    elevation: 80.0,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai',
        color: Colors.white,
      ),
      headline3: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Almarai',
          color: Colors.white,
          fontSize: headline_size)),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      //backwardsCompatibility: false,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      iconTheme: IconThemeData(
        color: Colors.black,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    //showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.black,
    elevation: 80.0,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai',
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai',
        color: Colors.black,
        fontSize: headline_size,
      )),
);
