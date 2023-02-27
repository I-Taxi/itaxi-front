import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/chat/model/chat.dart';
import 'package:itaxi/joiner/model/joiner.dart';

Widget ChatDetailListTile(
    {required BuildContext context,
    required bool isFirst,
    required Chat chat,
    required List<Joiner>? joiners}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.find();

  Joiner? owner;

  joiners?.forEach((joiner) {
    if (joiner.owner!) {
      owner = joiner;
    }
  });

  return (_userController.uid == chat.uid)
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isFirst
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('jm').format(chat.chatTime!.toDate()),
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.tertiaryContainer,
                          fontSize: Platform.isIOS ? 11 : 10,
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Text(
                        "You",
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 4.h,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                  constraints: BoxConstraints(minWidth: 36.w, maxWidth: 236.w),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: SelectableText(
                    chat.chatData!,
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.primary),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFirst
                ? Row(
                    children: [
                      Text(
                        chat.memberName!,
                        style: textTheme.bodyText2
                            ?.copyWith(color: colorScheme.onTertiary),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        DateFormat('jm').format(chat.chatTime!.toDate()),
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.tertiaryContainer,
                          fontSize: Platform.isIOS ? 11 : 10,
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 4.h,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                  constraints: BoxConstraints(minWidth: 36.w, maxWidth: 236.w),
                  decoration: BoxDecoration(
                    color: colorScheme.onBackground,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: SelectableText(
                    chat.chatData!,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        );
}
