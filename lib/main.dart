import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/firebase_options.dart';
import 'package:itaxi/home.dart';
import 'package:itaxi/signInUp/signInScreen.dart';
import 'package:itaxi/signInUp/splashScreen.dart';
import 'package:itaxi/src/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onBoardingScreen.dart';

int? initScreen;

void main() async {
  // firebase_core 패키지 필요
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
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

  static final storage = new FlutterSecureStorage();
  String? onBoardingInfo;
  int? isOnBoarding = 1; // 0일 경우, 온보딩 페이지 x / 1일 경우, 온보딩 페이지 띄우기


  @override
  onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _onBoarding();
      },
    );
  }

  _onBoarding() async {
    onBoardingInfo = await storage.read(key: "onBoarding");

    if(onBoardingInfo != null){
      isOnBoarding = 0;
    }else{
      isOnBoarding = 1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'iTaxi',
          theme: ITaxiTheme.lightThemeData,
          debugShowCheckedModeBanner: false,
          home: GetBuilder<SignInController>(
            builder: (_) {
              if(_signInController.signInState == SignInState.start){
                return SplashScreen();
              }else
              if(_signInController.signInState == SignInState.signedOut){
                return SignInScreen();
              }else {
                if(isOnBoarding == 1){
                  return onBoardingScreen();
                }else{
                  return Home();
                }
              }
            },
          ),
        );
      },
    );
  }
}
