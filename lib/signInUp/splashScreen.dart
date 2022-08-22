import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:itaxi/controller/signInController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SignInController _signInController = Get.put(SignInController());

  @override
  initState() {
    Timer(const Duration(milliseconds: 2000), () {
      _signInController.onInit();
    });
    super.initState();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 220.h,
              ),
              Image.asset(
                width: 80.0.w,
                height: 54.h,
                'assets/logo_1.png',
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'iTaxi',
                style: textTheme.headline1
                    ?.copyWith(fontSize: 36, color: colorScheme.primary),
              ),
              SizedBox(
                height: 58.h,
              ),
              Text(
                '한동이들의 No.1 교통 어플리케이션',
                style: textTheme.headline1?.copyWith(
                    fontSize: Platform.isIOS ? 16 : 14,
                    color: colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
