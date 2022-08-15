import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/firebase_options.dart';
import 'package:itaxi/home.dart';
import 'package:itaxi/signInUp/signInScreen.dart';
import 'package:itaxi/src/theme.dart';

void main() async {
  // firebase_core 패키지 필요
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    print(FlutterConfig.get('API_URL'));
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'iTaxi',
          theme: ITaxiTheme.lightThemeData,
          debugShowCheckedModeBanner: false,
          home: GetBuilder<SignInController>(
            builder: (_) {
              return _signInController.signInState == SignInState.signedOut
                  ? const SignInScreen()
                  : Home();
            },
          ),
        );
      },
    );
  }
}
