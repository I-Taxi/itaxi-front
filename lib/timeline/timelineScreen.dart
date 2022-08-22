import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/afterTimelineListTile.dart';
import 'package:itaxi/widget/soonTimelineListTile.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryController _historyController = Get.put(HistoryController());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '타임 라인',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
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
                          padding: EdgeInsets.fromLTRB(28.w, 16.h, 28.w, 0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '곧 탑승 예정',
                                style: textTheme.headline1?.copyWith(
                                    fontSize: Platform.isIOS ? 17 : 15,
                                    color: colorScheme.secondary),
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
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Text(
                                        '택시',
                                        style: textTheme.subtitle1?.copyWith(
                                            fontSize: Platform.isIOS ? 16 : 14,
                                            color: colorScheme.secondary),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Text(
                                        '카풀',
                                        style: textTheme.subtitle1?.copyWith(
                                            fontSize: Platform.isIOS ? 16 : 14,
                                            color: colorScheme.secondary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: colorScheme.shadow,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        for (int i = 0; i < snapshot.data!.length; i++)
                          if (DateTime.now()
                                  .difference(DateTime.parse(
                                      snapshot.data![i].deptTime!))
                                  .isNegative ==
                              false)
                            Column(
                              children: [
                                if (i == 0 ||
                                    (i - 1 > 0 &&
                                        DateTime.parse(DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.parse(snapshot
                                                        .data![i].deptTime!)))
                                                .compareTo(DateTime.parse(
                                                    DateFormat('yyyy-MM-dd').format(
                                                        DateTime.parse(snapshot
                                                            .data![i - 1]
                                                            .deptTime!)))) !=
                                            0))
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        DateFormat('M월 d일 E').format(
                                            DateTime.parse(
                                                snapshot.data![i].deptTime!)),
                                        style: textTheme.bodyText1?.copyWith(
                                            color: colorScheme.tertiary),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: colorScheme.shadow,
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                afterTimelineListTile(
                                  context: context,
                                  post: snapshot.data![i],
                                ),
                              ],
                            ),
                      ],
                    );
                  }

                  // history가 없을 때
                  else {
                    return ListView(
                      children: [
                        SizedBox(
                          height: 160.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '탑승 내역이 없습니다',
                            style: textTheme.headline1
                                ?.copyWith(color: colorScheme.tertiary),
                          ),
                        ),
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
