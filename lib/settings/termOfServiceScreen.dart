import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermOfServiceScreen extends StatelessWidget {
  const TermOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '이용약관',
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.onPrimary,
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
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0.h,
            horizontal: 48.0.w,
          ),
          child: Text(
            '이용약관 및 개인정보처리방침 내용 필요',
            style: textTheme.subtitle1!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
