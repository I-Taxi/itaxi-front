import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:itaxi/chat/screen/chatRoomListScreen.dart';
import 'package:itaxi/deeplink/dynamicLinkController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/post/screen/postDeepLinkScreen.dart';
import 'package:itaxi/tools/controller/navigationController.dart';

import 'package:itaxi/main/screen/taxiScreen.dart';
import 'package:itaxi/main/screen/ktxScreen.dart';
import 'package:itaxi/history/screen/timelineScreen.dart';

class Home extends StatelessWidget {
  Home({bool? dynamicStatus, Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());
  DynamicLinkController _dynamicLinkController = Get.put(DynamicLinkController());
  PostController _postController = Get.put(PostController());
  // final MainScreen main = new MainScreen();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [const TaxiScreen(), const KtxScreen(), const ChatroomListScreen(), const TimelineScreen()];

    return GetBuilder<DynamicLinkController>(builder: (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_dynamicLinkController.dynamicStatus) {
          // 페이지이동
          Get.to(PostDeepLinkScreen());
        }
      });
      return GetBuilder<NavigationController>(
        builder: (_) {
          return Scaffold(
            body: pageList[_navController.currentIndex],
            bottomNavigationBar: Container(
                width: 390.w,
                height: _navController.navHeight.h,
                decoration: BoxDecoration(color: colorScheme.primary, boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.4), blurRadius: 3.r, offset: Offset(-1.w, 3.h))]),
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navController.changeIndex(0);
                      },
                      child: _navController.currentIndex == 0
                          ? Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_car_taxi.png',
                              color: colorScheme.secondary,
                            )
                          : Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_car_taxi.png',
                              color: colorScheme.tertiary,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navController.changeIndex(1);
                      },
                      child: _navController.currentIndex == 1
                          ? Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_ktx.png',
                              color: colorScheme.secondary,
                            )
                          : Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_ktx.png',
                              color: colorScheme.tertiary,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navController.changeIndex(2);
                      },
                      child: _navController.currentIndex == 2
                          ? Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/messenger.png',
                              color: colorScheme.secondary,
                            )
                          : Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/messenger.png',
                              color: colorScheme.tertiary,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navController.changeIndex(3);
                      },
                      child: _navController.currentIndex == 3
                          ? Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_timeline.png',
                              color: colorScheme.secondary,
                            )
                          : Image.asset(
                              width: 89.5.w,
                              height: 48.h,
                              'assets/icon/navi_timeline.png',
                              color: colorScheme.tertiary,
                            ),
                    ),
                  ],
                )),
          );
        },
      );
    });
  }
}
