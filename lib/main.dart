import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/signInUp/signInScreen.dart';
import 'package:itaxi/signInUp/signUpScreen.dart';
import 'package:itaxi/src/theme.dart';
import 'package:itaxi/timeline/timelineScreen.dart';

void main() {
  // firebase_core 패키지 필요
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  SignInController _signInController = Get.put(SignInController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iTaxi',
      theme: ITaxiTheme.lightThemeData,
      home: GetBuilder<SignInController>(
        builder: (_) {
          return SignInScreen();
          // if (_signInController.signInState == SignInState.signedOut) {
          //   return SignInScreen();
          // } else {
          //   return MainScreen();
          // }
        },
      ),
      routes: {
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/': (context) => MainScreen(),
        '/timeline': (context) => TimelineScreen(),
        '/settings': (context) => SettingScreen(),
      },
    );
  }
}
