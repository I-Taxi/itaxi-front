import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget selectedTabView(
    {required String viewTitle, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 32.0.w,
    height: 23.0.h,
    alignment: Alignment.center,
    // decoration: BoxDecoration(
    //   border: Border(
    //       bottom: BorderSide(
    //     color: colorScheme.secondary,
    //     width: 1.0,
    //   )),
    // ),
    child: Text(
      viewTitle,
      style: textTheme.subtitle2?.copyWith(
        color: colorScheme.onPrimaryContainer,
      ),
    ),
  );
}

Widget unSelectedTabView(
    {required String viewTitle, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 32.0.w,
    height: 23.0.h,
    alignment: Alignment.center,
    child: Text(
      viewTitle,
      style: textTheme.subtitle2?.copyWith(
        color: colorScheme.tertiary,
      ),
    ),
  );
}
