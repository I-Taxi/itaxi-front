import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> showErrorDialog(BuildContext context, TextTheme textTheme, ColorScheme colorScheme, Object e) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            width: 312.w,
            height: 268.h,
            child: Padding(
              padding: EdgeInsets.fromLTRB(36.w, 24.h, 36.w, 24.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  height: 30.h,
                  child: Text(
                    "오류",
                    style: textTheme.subtitle1?.copyWith(color: colorScheme.secondary),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  width: 240.w,
                  height: 99.h,
                  alignment: Alignment.topLeft,
                  child: Text(
                    e.toString(),
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "확인",
                    style: textTheme.subtitle2?.copyWith(
                      color: colorScheme.tertiaryContainer,
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      });
}
