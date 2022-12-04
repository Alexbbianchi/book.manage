import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class Themes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Constants.myWrite,
    dialogTheme: const DialogTheme(
      backgroundColor: Constants.myWrite,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Constants.myBlack),
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Constants.myWrite),
      backgroundColor: Constants.myPurple,
      titleTextStyle: TextStyle(color: Constants.myWrite, fontSize: 26),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.amber,
      inactiveTrackColor: Colors.grey,
      overlayColor: Color.fromRGBO(255, 193, 7, 0.3),
      thumbColor: Colors.amber,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Constants.myPink,
      unselectedLabelColor: Constants.myWrite,
      labelStyle: TextStyle(fontSize: 18),
      unselectedLabelStyle: TextStyle(fontSize: 18),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Constants.myPink, width: 2),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 16, color: Constants.myBlack),
      floatingLabelStyle: TextStyle(fontSize: 18, color: Constants.myBlack),
      hintStyle: TextStyle(color: Constants.myGrey),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Constants.myBlack),
      ),
    ),
    scaffoldBackgroundColor: Constants.myWrite,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Constants.myWrite,
    ),
    primaryColor: Constants.myPurple,
    primaryColorLight: Constants.myPurple,
    iconTheme: const IconThemeData(color: Constants.myPurple),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Constants.myPurple,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.all(Constants.myPurple),
      ),
    ),
    colorScheme: const ColorScheme.light(primary: Constants.myPurple),
  );

  static ThemeData bookTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Constants.myBeige,
    dialogTheme: const DialogTheme(
      backgroundColor: Constants.myBeige,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Constants.myBlack),
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Constants.myOrange),
      backgroundColor: Constants.myBrown,
      titleTextStyle: TextStyle(color: Constants.myOrange, fontSize: 24),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.amber,
      inactiveTrackColor: Colors.grey,
      overlayColor: Color.fromRGBO(255, 193, 7, 0.3),
      thumbColor: Colors.amber,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Constants.myOrange,
      unselectedLabelColor: Constants.myBlack,
      labelStyle: TextStyle(fontSize: 18),
      unselectedLabelStyle: TextStyle(fontSize: 18),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Constants.myOrange, width: 2),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 16, color: Constants.myBlack),
      floatingLabelStyle: TextStyle(fontSize: 18, color: Constants.myBlack),
      hintStyle: TextStyle(color: Constants.myGrey),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Constants.myBlack),
      ),
    ),
    scaffoldBackgroundColor: Constants.myBeige,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Constants.myBeige,
    ),
    primaryColor: Constants.myOrange,
    primaryColorLight: Constants.myOrange,
    iconTheme: const IconThemeData(color: Constants.myOrange),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Constants.myOrange,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        backgroundColor: MaterialStateProperty.all(Constants.myOrange),
      ),
    ),
    colorScheme: const ColorScheme.light(primary: Constants.myOrange),
  );
}
