import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:itaxi/model/notice.dart';

Container topNoticeWidget(ColorScheme colorScheme, TextTheme textTheme, Notice notice) {
  return Container(
    height: 44.h,
    decoration: BoxDecoration(
      color: colorScheme.surfaceVariant,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(24), bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
    ),
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.only(left: 16.w, right: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage('assets/icon/notice_info.png'),
            size: 23,
            color: colorScheme.primary,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            notice.title!,
            style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    ),
  );
}
