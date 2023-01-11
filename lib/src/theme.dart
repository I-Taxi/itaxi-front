import 'dart:io';

import 'package:flutter/material.dart';

class ITaxiTheme {
  // static const _lightFillColor = Color(0xffffffff);

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      // fontFamily: '',
      textTheme: Platform.isIOS ? textThemeIOS : textThemeDefault,
      // textTheme: _textTheme.apply(
      //     displayColor: Color(0xff343434), fontFamily: GoogleFonts
      //     .roboto()
      //     .fontFamily),
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      // appBarTheme: AppBarTheme(
      //   textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
      //   color: colorScheme.background,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: colorScheme.primary),
      //   brightness: colorScheme.brightness,
      // ),
      backgroundColor: Colors.white,
      // inputDecorationTheme: InputDecorationTheme().copyWith(
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide(
      //         color: Colors.white,
      //       ),
      //     )
      // ),
      // iconTheme: IconThemeData(color: colorScheme.onPrimary,),
      // canvasColor: colorScheme.background,
      // scaffoldBackgroundColor: colorScheme.background,
      // highlightColor: Colors.transparent,
      // accentColor: colorScheme.primary,
      // focusColor: focusColor,
      // buttonTheme: ButtonThemeData(
      //   disabledColor: Color(0x33000000),
      // ),
      // disabledColor: Colors.white,
      dividerColor: colorScheme.tertiary,
      // dividerTheme: const DividerThemeData(
      //   thickness: 0.3,
      // ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: colorScheme.primary
      // ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
      primary: Color(0xFFFFFFFF),
      onPrimary: Colors.black,
      secondary: Color(0xff70b1f2), //Color(0xff3fa9f5) - 기존 color
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xffb00020),
      onError: Colors.white,
      background: Color(0xFFFFFFFF),
      onBackground: Colors.black,
      surface: Color(0xFFFFFFFF),
      onSurface: Colors.black,
      tertiary: Color(0xff919191),
      tertiaryContainer: Color(0xff717171),
      shadow: Color(0xffCCCCCC),
      brightness: Brightness.light);

  static const TextTheme textThemeDefault = TextTheme(
    headline1: TextStyle(fontSize: 16, fontFamily: 'NotoSans'),
    headline2: TextStyle(fontSize: 15, fontFamily: 'Seoul'),
    subtitle1: TextStyle(fontSize: 13, fontFamily: 'NotoSans'),
    bodyText1: TextStyle(fontSize: 11, fontFamily: 'NotoSans'),
  );

  static const TextTheme textThemeIOS = TextTheme(
    headline1: TextStyle(fontSize: 18, fontFamily: 'NotoSans'),
    headline2: TextStyle(fontSize: 17, fontFamily: 'Seoul'),
    subtitle1: TextStyle(fontSize: 15, fontFamily: 'NotoSans'),
    bodyText1: TextStyle(fontSize: 13, fontFamily: 'NotoSans'),
  );
}
