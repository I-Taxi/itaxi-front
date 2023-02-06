import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/widget/chatroomListListTile.dart';

class ChatroomListScreen extends StatelessWidget {
  const ChatroomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, top: 55.h, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "채팅",
              style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 13.h,
            ),
            Container(
                width: 342.w,
                height: 75.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Image.asset('assets/banner.png'),
                    Padding(
                      padding: EdgeInsets.only(right: 7.w, bottom: 5.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/button/contact.png'),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 13.h,
            ),
            Text(
              "탑승 예정 톡방",
              style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.shadow, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 88.h,
              child: ListView(children: [
                chatroomListListTile(context),
              ]),
            ),
            SizedBox(
              height: 29.w,
            ),
            Text(
              "전체 톡방 내역",
              style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.shadow, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: [
                  chatroomListListTile(context),
                  chatroomListListTile(context),
                  chatroomListListTile(context),
                  chatroomListListTile(context),
                  chatroomListListTile(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
