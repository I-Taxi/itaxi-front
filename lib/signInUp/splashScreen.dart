import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/signInUp/signInScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SignInController _signInController = Get.put(SignInController());


  @override
  void initState() {
    Timer(Duration(milliseconds: 2000), () {
      print("확인1");
      print(_signInController.signInState);
      _signInController.onInit();
      // WidgetsBinding.instance.addPostFrameCallback(
      //       (_) {
      //     _signInController.onInit();
      //   },
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: colorScheme.secondary,
      body: ColorfulSafeArea(
        color: colorScheme.secondary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                width: 88.0.w,
                height: 60.h,
                'assets/logo_1.png'
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                'iTaxi',
                style: textTheme.headline2?.copyWith(
                  fontSize: 36,
                  color: colorScheme.primary
                ),
              ),
              SizedBox(
                height: 57.h,
              ),
              Text(
                '한동이들의 No.1 교통 어플리케이션',
                style: textTheme.headline2?.copyWith(
                  fontSize: 16,
                  color: colorScheme.primary
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
