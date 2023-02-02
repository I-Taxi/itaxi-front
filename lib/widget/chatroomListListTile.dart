import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/chat/newChatroomScreen.dart';

Widget chatroomListListTile(
  BuildContext context,
) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return InkWell(
    onTap: () {
      Get.to(NewChatroomScreen());
    },
    child: Container(
      width: 342.w,
      height: 84.h,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colorScheme.shadow))),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: Row(children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: Image.asset('assets/icon_KTX.png'),
          ),
          SizedBox(
            width: 16.w,
          ),
          SizedBox(
              width: 270.w,
              child: Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "출발지-도착지(12/25)",
                            style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.inversePrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "00:00 출발",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "방장: 김형진학부생",
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.shadow,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "1명",
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.shadow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ))),
        ]),
      ),
    ),
  );
}
