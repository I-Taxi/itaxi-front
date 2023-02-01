import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/timeline/timelineDetailScreen.dart';

Widget soonTimelineListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      _historyController.getHistoryInfo(postId: post.id!);
      Get.to(() => TimelineDetailScreen());
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
      padding: EdgeInsets.fromLTRB(20.w, 11.h, 0.w, 11.h),
      height: 80.0.h,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        border: Border.all(
          width: 2,
          color: colorScheme.secondary,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                style:
                textTheme.bodyText1?.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(
                height: 9.0.h,
              ),
              Image.asset(
                width: 24.w,
                height: 24.h,
                'assets/participant/${post.participantNum}_2.png',
              ),
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    width: 10.w,
                    height: 10.h,
                    'assets/place/departure.png',
                  ),
                  SizedBox(
                    width: 12.0.w,
                  ),
                  Text(
                    '${post.departure?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0.h,
              ),
              Row(
                children: [
                  Image.asset(
                    width: 10.w,
                    height: 10.h,
                    'assets/place/destination.png',
                  ),
                  SizedBox(
                    width: 12.0.w,
                  ),
                  Text(
                    '${post.destination?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}