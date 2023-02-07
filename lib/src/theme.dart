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
    primaryContainer: Color(0xfffbfbfb),
    onPrimaryContainer: Color(0xff388bdd),
    secondary: Color(0xff70b1f2), //Color(0xff3fa9f5) - 기존 color
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0XFF509DE9),
    onSecondaryContainer: Color(0xff388BDD),
    error: Color(0xffb00020),
    onError: Colors.white,
    background: Color(0xFFFFFFFF),
    onBackground: Color(0XFFF1F1F1),
    surface: Color(0xFFFFFFFF),
    onSurface: Colors.black,
    tertiary: Color(0xff919191),
    tertiaryContainer: Color(0xff717171),
    onTertiaryContainer: Color(0xFFFBFBFB),
    shadow: Color.fromRGBO(0, 0, 0, 0.15),

    brightness: Brightness.light,
    onTertiary: Color(0XFF3E3E3E),
    inverseSurface: Color(0xff00CE21),

    outline: Color(0xffc5e1fd),
    onSurfaceVariant: Color(0xFFE1E1E1),
    
    surfaceVariant: Color(0xffff8080)
  );

  static const TextTheme textThemeDefault = TextTheme(
    headline1: TextStyle(fontSize: 40, fontFamily: 'Black'),
    headline2: TextStyle(fontSize: 32, fontFamily: 'Bold'),
    headline3: TextStyle(fontSize: 24, fontFamily: 'Bold'),
    subtitle1: TextStyle(fontSize: 20, fontFamily: 'Medium'),
    subtitle2: TextStyle(fontSize: 16, fontFamily: 'SemiBold'),
    bodyText1: TextStyle(fontSize: 16, fontFamily: 'Regular'),
    bodyText2: TextStyle(fontSize: 13, fontFamily: 'Regular'),
  );

  static const TextTheme textThemeIOS = TextTheme(
    headline1: TextStyle(fontSize: 42, fontFamily: 'Black'),
    headline2: TextStyle(fontSize: 34, fontFamily: 'Bold'),
    headline3: TextStyle(fontSize: 26, fontFamily: 'Bold'),
    subtitle1: TextStyle(fontSize: 22, fontFamily: 'Medium'),
    subtitle2: TextStyle(fontSize: 18, fontFamily: 'SemiBold'),
    bodyText1: TextStyle(fontSize: 18, fontFamily: 'Regular'),
    bodyText2: TextStyle(fontSize: 15, fontFamily: 'Regular'),
  );
}
