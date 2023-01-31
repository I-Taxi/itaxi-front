import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/timelineTabViewController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/newAfterTimelineListTile.dart';
//import 'package:itaxi/widget/afterTimelineListTile.dart'; //위에 import 한 것에 원본
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
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '타임 라인',
          style: textTheme.headline1?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: Platform.isIOS ? 20 : 18),
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
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
                    return ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '탑승 예정',
                                style: textTheme.headline1?.copyWith(
                                    fontSize: Platform.isIOS ? 16 : 14,
                                    color: colorScheme.tertiaryContainer),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              for (int i = snapshot.data!.length - 1;
                                  i >= 0;
                                  i--)
                                if (DateTime.now()
                                        .difference(DateTime.parse(
                                            snapshot.data![i].deptTime!))
                                        .isNegative ==
                                    true)
                                  Column(
                                    children: [
                                      if (i + 1 < snapshot.data!.length &&
                                          DateTime.parse(DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.parse(
                                                          snapshot.data![i]
                                                              .deptTime!)))
                                                  .compareTo(DateTime.parse(
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(DateTime.parse(
                                                              snapshot.data![i + 1].deptTime!)))) !=
                                              0)
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('M월 d일 E').format(
                                                  DateTime.parse(snapshot
                                                      .data![i].deptTime!)),
                                              style: textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.tertiary),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: colorScheme.shadow,
                                                thickness: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      soonTimelineListTile(
                                        //soonTimelineListTile을 수정해야 함.
                                        context: context,
                                        post: snapshot.data![i],
                                      ),
                                    ],
                                  ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '탑승 내역',
                                    style: textTheme.headline1?.copyWith(
                                        fontSize: 15,
                                        color: colorScheme.tertiary),
                                  ),
                                  const Spacer(),
                                  GetBuilder<TimelineTabViewController>(
                                      builder: (_) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _timelineTabViewController
                                            .changeIndex(1);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Text(
                                          '택시',
                                          style: textTheme.subtitle1?.copyWith(
                                            fontSize: Platform.isIOS ? 16 : 14,
                                            color: _timelineTabViewController
                                                        .currentIndex ==
                                                    1
                                                ? colorScheme.secondary
                                                : colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  GetBuilder<TimelineTabViewController>(
                                      builder: (_) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _timelineTabViewController
                                            .changeIndex(0);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Text(
                                          '전체',
                                          style: textTheme.subtitle1?.copyWith(
                                            fontSize: Platform.isIOS ? 16 : 14,
                                            color: _timelineTabViewController
                                                        .currentIndex ==
                                                    0
                                                ? colorScheme.secondary
                                                : colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  GetBuilder<TimelineTabViewController>(
                                      builder: (_) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _timelineTabViewController
                                            .changeIndex(2);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Text(
                                          '카풀',
                                          style: textTheme.subtitle1?.copyWith(
                                            fontSize: Platform.isIOS ? 16 : 14,
                                            color: _timelineTabViewController
                                                        .currentIndex ==
                                                    2
                                                ? colorScheme.secondary
                                                : colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: colorScheme.shadow,
                          thickness: 1,
                        ),
                        GetBuilder<TimelineTabViewController>(
                          builder: (_) {
                            return ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int i) {
                                if ((_timelineTabViewController.currentIndex ==
                                            0 ||
                                        snapshot.data![i].postType ==
                                            _timelineTabViewController
                                                .currentIndex) &&
                                    DateTime.now()
                                            .difference(DateTime.parse(
                                                snapshot.data![i].deptTime!))
                                            .isNegative ==
                                        false) {
                                  return Column(
                                    children: [
                                      if (i == 0 ||
                                          (i - 1 > 0 &&
                                              DateTime.parse(DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(DateTime.parse(
                                                              snapshot.data![i]
                                                                  .deptTime!)))
                                                      .compareTo(DateTime.parse(
                                                          DateFormat('yyyy-MM-dd')
                                                              .format(DateTime.parse(snapshot.data![i - 1].deptTime!)))) !=
                                                  0))
                                        newAfterTimelineListTile(
                                          context: context,
                                          post: snapshot.data![i],
                                        ),
                                      Container(
                                        color: Color(0xF1F1F1F1),
                                        height: 8.h,
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            );
                          },
                        ),
                        GetBuilder<TimelineTabViewController>(
                          builder: (_) {
                            for (int i = 0; i < snapshot.data!.length; i++) {}
                            return Container();
                          },
                        ),
                      ],
                    );
                  }

                  // history가 없을 때
                  else {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 60.h,
                          width: 282.w,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '아직 I-TAXI를 이용한 이력이 없어요\n어서 새로운 동료를 만나보세요',
                            style: textTheme.headline1?.copyWith(
                                color: colorScheme.tertiaryContainer,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "동료 구하러 가기",
                            style: textTheme.headline1?.copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 5.0, color: colorScheme.secondary)),
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
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.tertiary),
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
    );
  }
}
