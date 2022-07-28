import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/noticeController.dart';

import '../model/notice.dart';

Widget noticeListTile({
  required BuildContext context,
  required Notice notice,
}) {
  NoticeController _noticeController = Get.put(NoticeController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return ExpansionTile(
    title: Text(notice.title as String, style: textTheme.headline2!.copyWith(color: colorScheme.secondary),),
    initiallyExpanded: true,
    // subtitle: Text(notice.createdAt as Int, style: textTheme.subtitle1,),
    children: [
      Container(
        child: Text(notice.content as String, style: textTheme.headline1),
      )
    ],
  );

}