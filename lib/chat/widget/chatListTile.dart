import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/chat/model/chat.dart';
import 'package:itaxi/joiner/model/joiner.dart';

Widget chatListTile({required BuildContext context, required Chat chat, required List<Joiner>? joiners}) {
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

  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    child: (_userController.uid == chat.uid)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('hh:mm').format(chat.chatTime!.toDate()),
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    constraints: BoxConstraints(minWidth: 36.w),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SelectableText(
                      chat.chatData!,
                      style: textTheme.subtitle1?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (chat.memberId == owner?.memberId)
                    Icon(
                      Icons.bookmark,
                      color: colorScheme.tertiary,
                      size: 24.w,
                    ),
                  Text(
                    chat.memberName!,
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    constraints: BoxConstraints(minWidth: 36.w),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SelectableText(
                      chat.chatData!,
                      style: textTheme.subtitle1?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    DateFormat('h:mm').format(chat.chatTime!.toDate()),
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                ],
              ),
            ],
          ),
  );
}
