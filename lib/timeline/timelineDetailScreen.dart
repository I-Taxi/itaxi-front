import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/model/place.dart';
import 'package:itaxi/timeline/passengerListTile.dart';
import 'package:itaxi/widget/postTypeToString.dart';
import 'package:onboarding/onboarding.dart';

import '../model/post.dart';

class TimelineDetailScreen extends StatelessWidget {
  const TimelineDetailScreen({Key? key}) : super(key: key);

  Container insertBordingCompleteIcon(String? time) {
    if (DateTime.now().difference(DateTime.parse(time!)).isNegative == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(15.w, 0.h, 0.w, 0.h),
        child: Image.asset(
          width: 57,
          'assets/icon/boarding_complete.png',
        ),
      );
    } else {
      return Container(padding: EdgeInsets.fromLTRB(15.w, 0.h, 0.w, 0.h));
    }
  }

  double addPlaceContainerSize(double size, List<Place?>? stopovers) {
    if (stopovers!.isNotEmpty) {
      return size + 35.h;
    } else {
      return size;
    }
  }

  Container insertStopoverContainer({required BuildContext context, required List<Place?>? stopovers}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (stopovers!.isNotEmpty && stopovers != null) {
      return Container(
        padding: EdgeInsets.fromLTRB(0.w, 11.h, 0.w, 11.h),
        width: 300.h,
        height: 48.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 22.w),
            Text('경유', style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer)),
            SizedBox(width: 16.w),
            Text('${stopovers[0]!.name}', style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer)),
            const Spacer(),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    HistoryController _historyController = Get.find();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    return Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.background,
          elevation: 0.0,
        ),
        backgroundColor: colorScheme.onBackground,
        body: ColorfulSafeArea(
            color: colorScheme.tertiary,
            child: RefreshIndicator(
                key: _refreshIndicatorKey,
                color: colorScheme.tertiary,
                strokeWidth: 2.0,
                onRefresh: () async {
                  _historyController.getHistorys();
                },
                child: GetBuilder<HistoryController>(builder: (_) {
                  return FutureBuilder<Post>(
                      future: _historyController.history,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 15.h),
                                  height: 70.h,
                                  color: colorScheme.primary,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data!.joiners![0].memberName}님의 ${postTypeToString(snapshot.data!.postType)}',
                                        style: textTheme.headline3?.copyWith(
                                          color: colorScheme.onTertiary,
                                        ),
                                      ),
                                      insertBordingCompleteIcon(snapshot.data!.deptTime),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  height: 490.h,
                                  decoration: BoxDecoration(color: colorScheme.primary),
                                  child: ListView(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                        height: 100.h,
                                        color: colorScheme.primary,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '출발일자/시간',
                                              style: textTheme.subtitle2?.copyWith(
                                                color: colorScheme.onTertiary,
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Text(
                                                  DateFormat('yyyy년 MM월 dd일 (E) HH:mm').format(DateTime.parse(snapshot.data!.deptTime!)),
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 8.h,
                                        color: colorScheme.onBackground,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                        height: addPlaceContainerSize(130.h, snapshot.data!.stopovers),
                                        color: colorScheme.primary,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '출발/목적지',
                                              style: textTheme.subtitle2?.copyWith(
                                                color: colorScheme.onTertiary,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  width: 18,
                                                  'assets/icon/location.png',
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  '${snapshot.data!.departure?.name}',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            insertStopoverContainer(context: context, stopovers: snapshot.data!.stopovers),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  width: 18,
                                                  'assets/icon/location.png',
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  '${snapshot.data!.destination?.name}',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 8.h,
                                        color: colorScheme.onBackground,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                                        color: colorScheme.primary,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '탑승 인원',
                                              style: textTheme.subtitle2?.copyWith(
                                                color: colorScheme.onTertiary,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            for (int i = 0; i < snapshot.data!.joiners!.length; i++) passengerListTile(context: context, joiner: snapshot.data!.joiners![i]),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.secondaryContainer,
                                      elevation: 1.0,
                                      minimumSize: Size.fromHeight(57.h),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                                    ),
                                    onPressed: () {
                                      //TODO: 톡방으로 이동
                                    },
                                    child: Text(
                                      '톡방으로 이동',
                                      style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text(
                                '글 내용 가져오기가 실패하였습니다',
                                style: textTheme.headline2?.copyWith(
                                  color: colorScheme.tertiary,
                                ),
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.tertiary,
                              strokeWidth: 2,
                            ),
                          );
                        }
                      });
                }))));
  }
}
