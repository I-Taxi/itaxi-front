import 'package:colorful_safe_area/colorful_safe_area.dart';
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
    child: Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(
            context,
            MaterialPageRoute<Widget>(builder: (BuildContext context){
              return Padding(
                  padding: EdgeInsets.only(right: 24.w, left: 24.w),
                child: Scaffold(
                  appBar: AppBar(
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image(
                        image: AssetImage("assets/arrow_back.png"),
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
                  ),
                  body: ColorfulSafeArea(
                    color: colorScheme.background,
                    child: Column(
                      children: [
                        Text(
                          '[공지] ${notice.title}\n',
                          style: textTheme.headline1!.copyWith(
                            color: colorScheme.onPrimary
                          ),
                        ),
                        Text(
                          DateFormat(
                            'yyyy/MM/dd'
                          ).format(DateTime.parse(notice.createdAt!)),
                          style: textTheme.bodyText1!.copyWith(
                            color: colorScheme.tertiary
                          ),
                        ),
                        SizedBox(
                          height: 52.h,
                        ),
                        Text(
                          '${notice.content}',
                          textAlign: TextAlign.left,
                          style: textTheme.headline2!.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
            );
          },
          title: Text(
            '[공지] ${notice.title}\n',
            style: textTheme.headline1!.copyWith(
              color: colorScheme.onPrimary
            ),
          ),
          subtitle: Text(
            DateFormat('yyyy/MM/dd').format(DateTime.parse(notice.createdAt!)),
            style: textTheme.bodyText1!.copyWith(
              color: colorScheme.tertiary
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Divider(
          color: colorScheme.tertiaryContainer,
          height: 1.h,
        )
      ],
    )
  );
}
