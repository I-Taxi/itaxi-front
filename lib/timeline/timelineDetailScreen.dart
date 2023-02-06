import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding/onboarding.dart';

import '../model/post.dart';

class TimelineDetailScreen extends StatelessWidget {
  const TimelineDetailScreen({Key? key}) : super(key: key);

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
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0.h),
                                  height: 65.h,
                                  color: colorScheme.primary,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        // TODO: ㅇㅇㅇ 이름으로 바꾸기
                                        // snapshot.data!.postType == 1 ? '택시' : '카풀',
                                        'OOO님의 카풀',
                                        style: textTheme.headline3?.copyWith(
                                          color: colorScheme.onTertiary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      // TODO: image 계산/탑승 완료일 때 띄우기
                                      Image.asset(
                                        width: 57,
                                        'assets/icon/boarding_complete.png',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                  height: 110.h,
                                  color: colorScheme.primary,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '출발일자',
                                        style: textTheme.subtitle2?.copyWith(
                                          color: colorScheme.onTertiary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // TODO: 날짜 정보 띄우기
                                            '2023년 00월 00일 (토)',
                                            style: textTheme.bodyText1?.copyWith(
                                              color: colorScheme.onTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                  height: 140.h,
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
                                            // TODO: 장소 정보 띄우기
                                            '포항고속버스터미널',
                                            style: textTheme.bodyText1?.copyWith(
                                              color: colorScheme.onTertiary,
                                            ),
                                          ),
                                        ],
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
                                            // TODO: 장소 정보 띄우기
                                            '포항고속버스터미널',
                                            style: textTheme.bodyText1?.copyWith(
                                              color: colorScheme.onTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                    height: 240.h,
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
                                          height: 20.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 39,
                                                  'assets/icon/owner.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  // TODO: 인원 정보 띄우기
                                                  '최영준',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/phone.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/message.png',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 39,
                                                  'assets/icon/not_owner.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  // TODO: 인원 정보 띄우기
                                                  '최영준',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/phone.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/message.png',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 39,
                                                  'assets/icon/not_owner.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  // TODO: 인원 정보 띄우기
                                                  '최영준',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/phone.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/message.png',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 39,
                                                  'assets/icon/not_owner.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  // TODO: 인원 정보 띄우기
                                                  '최영준',
                                                  style: textTheme.bodyText1?.copyWith(
                                                    color: colorScheme.onTertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/phone.png',
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Image.asset(
                                                  width: 24,
                                                  'assets/icon/message.png',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.secondaryContainer,
                                      elevation: 1.0,
                                      minimumSize: Size.fromHeight(57.h),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                    ),
                                    onPressed: () {
                                      //TODO: 톡방으로 이동
                                    },
                                    child: Text(
                                      '톡방으로 이동',
                                      style: textTheme.subtitle2?.copyWith(
                                        color: colorScheme.primary,
                                      ),
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
