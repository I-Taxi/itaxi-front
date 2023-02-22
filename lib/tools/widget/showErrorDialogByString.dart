import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showErrorDialogByString(String? title, BuildContext context, Widget content, void onPressed()) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: errorDialogContainerByString(
              title,
              context,
              content,
              onPressed,
            ));
      });
}

Container errorDialogContainerByString(String? title, BuildContext context, Widget content, void onPressed()) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Container(
    width: 312.w,
    height: 273.h,
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(
      36.0.w,
      24.0.h,
      36.0.w,
      24.0.h,
    ),
    child: Column(
      children: <Widget>[
        Text(
          title as String,
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.secondary,
          ),
        ),
        const Spacer(),
        content,
        // Text(
        //   '회원가입 시 입력하신 handong.ac.kr 계정으로 인증메일이 보내집니다.\n메일이 오지 않은 경우,',
        //   style: textTheme.subtitle1?.copyWith(
        //     color: colorScheme.onPrimary,
        //   ),
        // ),
        const Spacer(),
        SizedBox(
          height: 10.h,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "확인",
            style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
          ),
        ),
      ],
    ),
  );
}
