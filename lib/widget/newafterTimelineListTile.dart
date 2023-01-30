import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/timelineDialog.dart';

Widget newAfterTimelineListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      _historyController.getHistoryInfo(postId: post.id!);
      timelineDiaog(context: context, post: post);
    },
    child: Container(
      // margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 0.w, 16.h),
      height: 166.0.h,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        // borderRadius: BorderRadius.circular(4.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: colorScheme.shadow,
        //     offset: const Offset(1.0, 1.0),
        //     blurRadius: 2.0,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('MM/dd (EE)').format(DateTime.parse(post.deptTime!)),
                style:
                textTheme.headline2?.copyWith(color: colorScheme.tertiaryContainer),
              ),
              SizedBox(
                width: 6.w,
              ),
              Image.asset(
                width: 3.w,
                height: 3.h,
                'assets/place/destination.png',
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                "계산 완료(또는 탑승 완료)",
                style: textTheme.headline2?.copyWith(color: colorScheme.tertiaryContainer),
              ),
            ],
          ),
          // SizedBox(
          //   height: 24.h,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                width: 30.26.w,
                height: 20.65.h,
                'assets/car_new.png', //만약 ktx를 탄 정보면 이미지에 ktx가 들어가야 함
              ),
              SizedBox(
                width: 21.87.w,
              ),
              RichText(
                  text: TextSpan(
                    text: "출발\n",
                    style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                      fontWeight: FontWeight.w400
                    ),
                    children: <TextSpan>[
                      TextSpan(text: '${post.departure?.name}',
                         style: textTheme.subtitle1
                            ?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w400),)
                    ]
                  ),
              ),
              SizedBox(
                width: 21.87.w,
              ),
              RichText(
                text: TextSpan(
                    text: "도착\n",
                    style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                        fontWeight: FontWeight.w400
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${post.destination?.name}',
                        style: textTheme.subtitle1
                            ?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w400),)
                    ]
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: 26.0.h,
          // ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 1.0,
                  color: colorScheme.secondary
                ),
                minimumSize: Size(341.w, 36.h),
              ),
              onPressed: (){
              },
              child: Text(
                "상세보기",
                style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w500
                ),
              )
          ),
        ],
      ),
    ),
  );
}