import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info/package_info.dart';

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
      _signInController.onInit();
    });
    super.initState();

    setUpdateAlert();
  }

  Future<bool> setUpdateAlert() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final newVersion = NewVersion();

    newVersion.showAlertIfNecessary(context: context);

    advancedStatusCheck(newVersion);

    return true;
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: '업데이트 알람',
        dialogText: '\n새로운 버전이 나왔습니다!\n바로 다운받아보시겠어요?\n',
        updateButtonText: '업데이트',
        dismissButtonText: '나중에',
        dismissAction: () {
          Get.back();
        },
      );
    }
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
        ),
      ),
    );
  }
}
