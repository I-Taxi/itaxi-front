import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/noticeController.dart';
import 'dart:core';

import '../model/notice.dart';

Widget noticeListTile({
  required BuildContext context,
  required Notice notice,
}) {
  // NoticeController _noticeController = Get.put(NoticeController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
  print(notice.toMap());
  return Theme(
    data: theme,
    child: ExpansionTile(
      title: Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(notice.createdAt!)), style: textTheme.headline2!.copyWith(color: colorScheme.secondary),),
      initiallyExpanded: false,
      // backgroundColor: colorScheme.onPrimary,
      // subtitle: Text("ㅎㅇ"),
      subtitle: Text(notice.title as String,
        style: textTheme.subtitle1,),
      // open 시 icon Color
      iconColor: colorScheme.secondary,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
          child: Text(notice.content as String, style: textTheme.bodyText1),
        )
      ],
    ),
  );

}