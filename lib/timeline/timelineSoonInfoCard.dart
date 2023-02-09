import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/model/history.dart';
import 'package:itaxi/timeline/timelineDetailScreen.dart';
import 'package:itaxi/widget/postTypeToString.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/HorizontalDashedDivider.dart';

Container timelineSoonInfoCard(
    {required BuildContext context, required History history}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  if (history.stopovers == null || history.stopovers!.isEmpty) {
    return Container(
      width: 339.w,
      height: 230.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              blurRadius: 40,
              offset: const Offset(2, 4),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 18.h, 21.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '곧 출발 예정',
              style: textTheme.subtitle2
                  ?.copyWith(color: colorScheme.tertiaryContainer),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(width: 24, 'assets/icon/location.png'),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  '${history.departure?.name}',
                  style: textTheme.subtitle2
                      ?.copyWith(color: colorScheme.onTertiary),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(width: 24, 'assets/icon/location.png'),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  '${history.destination?.name}',
                  style: textTheme.subtitle2
                      ?.copyWith(color: colorScheme.onTertiary),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            HorizontalDashedDivider(
              length: 5,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MM/dd')
                          .format(DateTime.parse(history.deptTime!)),
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      postTypeToString(history.postType),
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                  ],
                ),
                SizedBox(
                  width: 49.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm')
                          .format(DateTime.parse(history.deptTime!)),
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '${history.participantNum}/${history.capacity}명',
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () async {
                      if (history.postType == null) {
                        // TODO: ktx container 제작하면 연결
                      } else {
                        _historyController.getHistoryInfo(
                            postId: history.id!, postType: history.postType!);
                        Get.to(() => const TimelineDetailScreen());
                      }
                    },
                    child: Image.asset(
                        width: 81.w, 'assets/button/go_descript.png'))
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  } else {
    return Container(
        width: 339.w,
        height: 268.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow,
                blurRadius: 40,
                offset: const Offset(2, 4),
              )
            ]),
        child: Padding(
            padding: EdgeInsets.fromLTRB(25.w, 18.h, 21.w, 0.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '곧 출발 예정',
                style: textTheme.subtitle2
                    ?.copyWith(color: colorScheme.tertiaryContainer),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(width: 24, 'assets/icon/location.png'),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    '${history.departure?.name}',
                    style: textTheme.subtitle2
                        ?.copyWith(color: colorScheme.onTertiary),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 44.w),
                  Text('경유',
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer)),
                  SizedBox(width: 16.w),
                  Text('${history.stopovers![0]!.name}',
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer)),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(width: 24, 'assets/icon/location.png'),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    '${history.destination?.name}',
                    style: textTheme.subtitle2
                        ?.copyWith(color: colorScheme.onTertiary),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              HorizontalDashedDivider(
                length: 5,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MM/dd')
                            .format(DateTime.parse(history.deptTime!)),
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        postTypeToString(history.postType),
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 49.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('HH:mm')
                            .format(DateTime.parse(history.deptTime!)),
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        '${history.participantNum}/${history.capacity}명',
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () async {
                        if (history.postType == null) {
                          // TODO: ktx container 제작하면 연결
                        } else {
                          _historyController.getHistoryInfo(
                              postId: history.id!, postType: history.postType!);
                          Get.to(() => const TimelineDetailScreen());
                        }
                      },
                      child: Image.asset(
                          width: 81.w, 'assets/button/go_descript.png'))
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              const Spacer(),
            ])));
  }
}
