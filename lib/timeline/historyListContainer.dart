import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/timeline/timelineDetailScreen.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';

Widget historyListContainer({required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  Text timePassedChecker(String? time) {
    if (DateTime.now().difference(DateTime.parse(time!)).isNegative == true) {
      return Text('탑승 예정', style: textTheme.bodyText2?.copyWith(color: colorScheme.secondary));
    } else {
      return Text('탑승 완료', style: textTheme.bodyText2?.copyWith(color: colorScheme.onPrimary));
    }
  }

  Image CarTrainSelector(int? type) {
    // TODO: back 코드 바뀌면 type == 2로 변경
    if (type == null) {
      return Image.asset(
        width: 30.w,
        'assets/icon/ktx_gray.png',
      );
    } else {
      return Image.asset(
        width: 30.w,
        'assets/icon/car_gray.png',
      );
    }
  }

  return Column(
    children: [
      Divider(
        thickness: 7,
        color: colorScheme.onBackground,
      ),
      Container(
        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 0.h),
        height: 177.h,
        decoration: BoxDecoration(
          color: colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat('MM/dd (E)  •  ').format(DateTime.parse(post.deptTime!)),
                  style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer),
                ),
                timePassedChecker(post.deptTime),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarTrainSelector(post.postType),
                  SizedBox(width: 22.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 125.w),
                      Text('출발', style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer)),
                      SizedBox(height: 7.0.h),
                      Text(abbreviatePlaceName(post.departure?.name), style: textTheme.bodyText1?.copyWith(color: colorScheme.onTertiary)),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('도착', style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer)),
                      SizedBox(height: 7.0.h),
                      Text(abbreviatePlaceName(post.destination?.name), style: textTheme.bodyText1?.copyWith(color: colorScheme.onTertiary)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            OutlinedButton(
              onPressed: () {
                // TODO: ktx container 제작하면 연결
                if (post.postType == null) {
                  _historyController.getHistoryInfo(postId: post.id!);
                } else {
                  _historyController.getHistoryInfo(postId: post.id!);
                  Get.to(() => const TimelineDetailScreen());
                }
              },
              style: OutlinedButton.styleFrom(minimumSize: Size(342.w, 40.h), side: BorderSide(width: 1, color: colorScheme.onPrimaryContainer), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
              child: Text('상세보기', style: textTheme.bodyText2?.copyWith(color: colorScheme.onPrimaryContainer)),
            )
          ],
        ),
      ),
    ],
  );
}
