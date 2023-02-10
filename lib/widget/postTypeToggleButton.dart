import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/screenController.dart';

import '../controller/placeController.dart';

PlaceController _placeController = Get.find();

Widget postTypeToggleButton({required BuildContext context, required ScreenController controller}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return SizedBox(
      width: 296.w,
      height: 57.h,
      child: Container(
        decoration: BoxDecoration(color: colorScheme.onBackground, borderRadius: BorderRadius.circular(30)),
        child: controller.mainScreenCurrentToggle == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                        fixedSize: Size(140.w, 49.h),
                        backgroundColor: colorScheme.primary,
                        shadowColor: colorScheme.onPrimary),
                    onPressed: () {},
                    child: Text(
                      "조회",
                      style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                      fixedSize: Size(140.w, 49.h),
                    ),
                    onPressed: () {
                      _placeController.dep = null;
                      _placeController.dst = null;
                      _placeController.hasDep = false;
                      _placeController.hasDst = false;
                      controller.changeMainScreenToggleIndex(1);
                    },
                    child: Text(
                      "모집",
                      style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                  ),
                ],
              )
            : SizedBox(
                width: 296.w,
                height: 57.h,
                child: Container(
                  decoration: BoxDecoration(color: colorScheme.onBackground, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                          fixedSize: Size(140.w, 49.h),
                        ),
                        onPressed: () {
                          _placeController.dep = null;
                          _placeController.dst = null;
                          _placeController.hasDep = false;
                          _placeController.hasDst = false;
                          controller.changeMainScreenToggleIndex(0);
                        },
                        child: Text(
                          "조회",
                          style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                            fixedSize: Size(140.w, 49.h),
                            backgroundColor: colorScheme.primary,
                            shadowColor: colorScheme.onPrimary),
                        onPressed: () {},
                        child: Text(
                          "모집",
                          style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                        ),
                      ),
                    ],
                  ),
                )),
      ));
}

Widget ktxPostTypeToggleButton({required BuildContext context, required ScreenController controller}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return SizedBox(
      width: 296.w,
      height: 57.h,
      child: Container(
        decoration: BoxDecoration(color: colorScheme.onBackground, borderRadius: BorderRadius.circular(30)),
        child: controller.ktxScreenCurrentToggle == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                        fixedSize: Size(140.w, 49.h),
                        backgroundColor: colorScheme.primary,
                        shadowColor: colorScheme.onPrimary),
                    onPressed: () {},
                    child: Text(
                      "조회",
                      style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                      fixedSize: Size(140.w, 49.h),
                    ),
                    onPressed: () {
                      controller.changeKtxScreenToggleIndex(1);
                    },
                    child: Text(
                      "모집",
                      style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                  ),
                ],
              )
            : SizedBox(
                width: 296.w,
                height: 57.h,
                child: Container(
                  decoration: BoxDecoration(color: colorScheme.onBackground, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                          fixedSize: Size(140.w, 49.h),
                        ),
                        onPressed: () {
                          controller.changeKtxScreenToggleIndex(0);
                        },
                        child: Text(
                          "조회",
                          style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            padding: EdgeInsets.fromLTRB(4.w, 4.h, 3.w, 4.h),
                            fixedSize: Size(140.w, 49.h),
                            backgroundColor: colorScheme.primary,
                            shadowColor: colorScheme.onPrimary),
                        onPressed: () {},
                        child: Text(
                          "모집",
                          style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                        ),
                      ),
                    ],
                  ),
                )),
      ));
}
