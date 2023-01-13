import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget selectedView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: EdgeInsets.fromLTRB(20.0.w, 15.0.h, 20.0.w, 25.0.h),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorScheme.secondary,
          shape: BoxShape.rectangle,
        ),
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.primary),
        ),
      ));
}

Widget unselectedView(
    {required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary),
        ),
      ));
}

Widget selectedTypeView(
    {required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
    ),
  );
}

Widget unSelectedTypeView(
    {required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
    ),
  );
}

Widget searchTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: EdgeInsets.all(5),
    child: Container(
      width: 56.0.w,
      height: 27.0.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        viewText,
        style: textTheme.headline1?.copyWith(color: colorScheme.onSecondary),
      ),
    ),
  );
}

Widget unselectedSearchTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: EdgeInsets.all(5),
    child: Container(
      width: 56.0.w,
      height: 27.0.h,
      alignment: Alignment.center,
      child: Text(
        viewText,
        style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
      ),
    ),
  );
}