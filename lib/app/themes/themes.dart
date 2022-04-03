import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class Themes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
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
    scaffoldBackgroundColor: const Color.fromRGBO(249, 241, 230, 1),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(249, 241, 230, 1),
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
