import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void mainDialog(BuildContext context, String? title, String? content) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0.r),
          ),
          child: Container(
            width: 360.w,
            height: 280.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              28.0.w,
              32.0.h,
              28.0.w,
              12.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  title as String,
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  content as String,
                  style: textTheme.bodyText1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: Text(
                    "확인",
                    style: textTheme.subtitle2
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
