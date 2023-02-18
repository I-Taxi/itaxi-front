import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/widget/showErrorDialogByString.dart';

import '../widget/mainDialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SignInController _signInController = Get.find();
  @override
  initState() {
    Timer(const Duration(milliseconds: 2000), () {
      _signInController.asyncMethod();
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
        child: GetBuilder<SignInController>(builder: (controller) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (controller.signInState == SignInState.backServerError) {
              showErrorDialogByString(
                  '오류',
                  context,
                  Text(
                    '유저 정보를 불러오는 데 실패했습니다. 다시 로그인해 주세요.',
                    style: textTheme.bodyText1?.copyWith(color: colorScheme.onTertiary),
                  ), () {
                controller.signedOutState();
                Get.back();
              });
            }
          });

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 220.h,
                ),
                Image.asset(
                  width: 110.0.w,
                  height: 122.h,
                  'assets/logo_text.png',
                ),
                SizedBox(
                  height: 48.h,
                ),
                Text(
                  '한동이들의 No.1 교통 어플리케이션',
                  style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
