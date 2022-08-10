import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
  return Theme(
    data: theme,
    child: ExpansionTile(
      initiallyExpanded: false,
      title: Text(
        '${notice.title}',
        style: textTheme.headline2!.copyWith(
          color: colorScheme.secondary,
        ),
      ),
      subtitle: Text(
        DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(notice.createdAt!)),
        style: textTheme.subtitle1!.copyWith(
          color: colorScheme.tertiary,
        ),
      ),
      collapsedIconColor: colorScheme.tertiary,
      iconColor: colorScheme.secondary,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.w,
          ),
          child: Text(
            '${notice.content}',
            textAlign: TextAlign.left,
            style: textTheme.subtitle1!.copyWith(
              height: 1.8,
              wordSpacing: 1.2,
              color: colorScheme.onPrimary,
            ),
          ),
        )
      ],
    ),
  );
}
