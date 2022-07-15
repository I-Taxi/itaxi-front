import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/firebase_options.dart';
import 'package:itaxi/home.dart';
import 'package:itaxi/signInUp/signInScreen.dart';
import 'package:itaxi/src/theme.dart';

void main() async {
  // firebase_core 패키지 필요
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final SignInController _signInController = Get.put(SignInController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'iTaxi',
      theme: ITaxiTheme.lightThemeData,
      home: GetBuilder<SignInController>(
        builder: (_) {
          if (_signInController.signInState == SignInState.signedOut) {
            return SignInScreen();
          } else {
            return Home();
          }
        },
      ),
    );
  }
}
