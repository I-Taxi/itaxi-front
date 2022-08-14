import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '알림',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colorScheme.tertiary,
          ),
        ),
      ),
      backgroundColor: colorScheme.primary,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 168.h,
            ),
            Image.asset(
              width: 82.w,
              height: 56.h,
              'assets/logo_1.png',
            ),
            SizedBox(
              height: 12.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '도로 공사 중...',
                style: textTheme.headline2?.copyWith(
                  color: colorScheme.onPrimary,
                  fontFamily: 'Noto Sans',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
