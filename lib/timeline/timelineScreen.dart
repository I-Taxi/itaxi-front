import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/timelineTabViewController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/timeline/historyListContainer.dart';
import 'package:itaxi/timeline/timelineSoonInfoCard.dart';
import 'package:itaxi/widget/afterTimelineListTile.dart'; //위에 import 한 것에 원본
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/soonTimelineListTile.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimelineTabViewController _timelineTabViewController =
        Get.put(TimelineTabViewController());
    HistoryController _historyController = Get.put(HistoryController());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    print(1);

    return Scaffold(
      body: Stack(children: [
        Container(
          height: 250.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/background/timeline_bg.png"), // 배경 이미지
            ),
          ),
        ),
        ColorfulSafeArea(
          color: colorScheme.tertiary,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: colorScheme.tertiary,
            backgroundColor: colorScheme.background,
            strokeWidth: 2.0,
            onRefresh: () async {
              _historyController.getHistorys();
            },
            child: GetBuilder<HistoryController>(builder: (_) {
              return FutureBuilder<List<Post>>(
                future: _historyController.historys,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    // history가 있을 때
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0.w, 48.h, 0.w, 22.h),
                            child: Text(
                              '타임라인',
                              style: textTheme.subtitle1?.copyWith(color: colorScheme.primary),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color: colorScheme.primary),
                            height: 570.h,
                            child: ListView(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(26.w, 20.h, 26.w, 0.h),
                                  child: timelineSoonInfoCard(
                                    context: context,
                                    post: snapshot.data![0],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 26.h, 0.w, 0.h),
                                  child: Text(
                                    '탑승 내역',
                                    style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                                  ),
                                ),
                                for (int i = 1; i < snapshot.data!.length; i++)
                                  historyListContainer(
                                    context: context,
                                    post: snapshot.data![i],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    // history가 없을 때
                    else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 282.w,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '아직 I-TAXI를 이용한 이력이 없어요\n어서 새로운 동료를 만나보세요',
                              textAlign: TextAlign.center,
                              style: textTheme.headline1?.copyWith(color: colorScheme.tertiaryContainer, fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 36.h,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(side: BorderSide(width: 0, color: colorScheme.onBackground)),
                            child: Image.asset(
                              width: 198,
                              'assets/button/add_timeline.png',
                            ),
                          )
                        ],
                      );
                    }
                  }

                  // history load 중에 오류 발생
                  else if (snapshot.hasError) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 160.h,
                        ),
                        Align(
                          child: Text(
                            '${snapshot.error}',
                            style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
                          ),
                        ),
                      ],
                    );
                  }

                  // history data loading bar
                  return LinearProgressIndicator(
                    color: colorScheme.secondary,
                  );
                },
              );
            }),
          ),
        ),
      ]),
    );
  }
}
