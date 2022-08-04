import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget selectedTabView(
    {required String viewTitle, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 80.0.w,
    height: 52.0.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
        color: colorScheme.secondary,
        width: 1.0,
      )),
    ),
    child: Text(
      viewTitle,
      style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary),
    ),
  );
}

Widget unSelectedTabView(
    {required String viewTitle, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 80.0.w,
    height: 52.0.h,
    alignment: Alignment.center,
    child: Text(
      viewTitle,
      style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary),
    ),
  );
}
