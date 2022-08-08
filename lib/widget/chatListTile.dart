import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';

Widget chatListTile({required BuildContext context, required Chat chat}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late UserController _userController = Get.find();

  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    child: (_userController.uid == chat.memberId)
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
                    child: Text(
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
              Text(
                chat.memberName!,
                style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.tertiary,
                ),
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
                    child: Text(
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
                    DateFormat('hh:mm').format(chat.chatTime!.toDate()),
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
