import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'dart:io';

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          onTap: (){
            Navigator.push(
            context,
            MaterialPageRoute<Widget>(builder: (BuildContext context){
              return Scaffold(
                backgroundColor: colorScheme.background,
                appBar: AppBar(
                  elevation: 0.0,
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Image(
                        image: AssetImage("assets/arrow/arrow_back.png"),
                        width: 20.w,
                        height: 20.w,
                        color: colorScheme.tertiaryContainer,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear_rounded,
                        color: colorScheme.tertiary,
                          size: 24,
                        )
                    ),
                  ],
                ),
                body: ColorfulSafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.h
                          ),
                          Text(
                            '[공지] ${notice.title}\n',
                            style: textTheme.headline3!.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'yyyy/MM/dd'
                            ).format(DateTime.parse(notice.createdAt!)),
                            style: textTheme.bodyText2!.copyWith(
                              color: colorScheme.tertiaryContainer
                            ),
                          ),
                          SizedBox(
                            height: 52.h,
                          ),
                          Text(
                            '${notice.content}',
                            textAlign: TextAlign.left,
                            style: textTheme.bodyText1!.copyWith(
                              color: colorScheme.onTertiary,
                                fontSize: Platform.isIOS ? 22 : 20
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
            );
          },
          title: Text(
            '[공지] ${notice.title}\n',
            style: textTheme.bodyText1!.copyWith(
              color: colorScheme.onTertiary
            ),
          ),
          subtitle: Text(
            DateFormat('yyyy/MM/dd').format(DateTime.parse(notice.createdAt!)),
            style: textTheme.bodyText2!.copyWith(
              color: colorScheme.tertiary
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Divider(
          color: colorScheme.tertiaryContainer,
          height: 1.h,
        )
      ],
    )
  );
}
