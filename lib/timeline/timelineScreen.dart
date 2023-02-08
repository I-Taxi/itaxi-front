import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/timelineTabViewController.dart';
import 'package:itaxi/home.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/timeline/historyListContainer.dart';
import 'package:itaxi/timeline/timelineSoonInfoCard.dart';
import 'package:itaxi/widget/postListTile.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  TimelineTabViewController _timelineTabViewController = Get.put(TimelineTabViewController());
  final HistoryController _historyController = Get.put(HistoryController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final NavigationController _navController = Get.put(NavigationController());

  int catchSoonIndex(List<Post>? posts) {
    int index = -1;
    for (int i = 0; i < posts!.length; i++) {
      index = i;
      if (DateTime.now().difference(DateTime.parse(posts[i].deptTime!)).isNegative == false) {
        break;
      }
    }
    if (index == 0 && DateTime.now().difference(DateTime.parse(posts[index].deptTime!)).isNegative == true) {
      return 0;
    }

    return index - 1;
  }

  Container makeSoonCard(BuildContext context, List<Post>? posts) {
    int index = catchSoonIndex(posts);

    if (index == -2 || index == -1) {
      return Container(padding: EdgeInsets.fromLTRB(26.w, 20.h, 26.w, 0.h));
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(26.w, 20.h, 26.w, 0.h),
        child: timelineSoonInfoCard(
          context: context,
          post: posts![index],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 70.h,
        title: Text('타임라인', style: textTheme.subtitle1?.copyWith(color: colorScheme.primary)),
        centerTitle: true,
        flexibleSpace: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
              Color(0xff8fc0f1),
              Color(0Xff76B1ED),
            ]),
          ),
        ),
      ),
      body: Stack(
        children: [
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
                              decoration: BoxDecoration(color: colorScheme.primary),
                              height: 605.h,
                              child: ListView(
                                children: [
                                  makeSoonCard(context, snapshot.data!),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(24.w, 26.h, 0.w, 0.h),
                                    child: Text(
                                      '탑승 내역',
                                      style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                                    ),
                                  ),
                                  for (int i = 0; i < snapshot.data!.length; i++)
                                    historyListContainer(
                                      context: context,
                                      post: snapshot.data![i],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        // history가 없을 때
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
                              onPressed: () {
                                _navController.changeIndex(0);
                              },
                              style: OutlinedButton.styleFrom(minimumSize: Size(198.w, 50.h), side: BorderSide(width: 1, color: colorScheme.onPrimaryContainer), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
                              child: Text('동료 구하러 가기', style: textTheme.subtitle1?.copyWith(color: colorScheme.onPrimaryContainer)),
                            )
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      // history load 중에 오류 발생
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
        ],
      ),
    );
  }
}
