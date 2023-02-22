import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:itaxi/chat/screen/chatRoomListScreen.dart';
import 'package:itaxi/tools/controller/navigationController.dart';

import 'package:itaxi/main/screen/mainScreen.dart';
import 'package:itaxi/main/screen/ktxScreen.dart';
import 'package:itaxi/history/screen/timelineScreen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());
  // final MainScreen main = new MainScreen();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [const MainScreen(), const KtxScreen(), const ChatroomListScreen(), const TimelineScreen()];

    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          body: pageList[_navController.currentIndex],
          bottomNavigationBar: Container(
              width: 390.w,
              height: _navController.navHeight.h,
              decoration: BoxDecoration(color: colorScheme.primary, boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.4), blurRadius: 3.r, offset: Offset(-1.w, 3.h))
              ]),
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
                            'assets/newType/car_taxi.png',
                            color: colorScheme.secondary,
                          )
                        : Image.asset(
                            width: 89.5.w,
                            height: 48.h,
                            'assets/newType/car_taxi.png',
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
                            'assets/newType/ktx.png',
                            color: colorScheme.secondary,
                          )
                        : Image.asset(
                            width: 89.5.w,
                            height: 48.h,
                            'assets/newType/ktx.png',
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
                            'assets/newType/messenger.png',
                            color: colorScheme.secondary,
                          )
                        : Image.asset(
                            width: 89.5.w,
                            height: 48.h,
                            'assets/newType/messenger.png',
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
                            'assets/newType/timeline.png',
                            color: colorScheme.secondary,
                          )
                        : Image.asset(
                            width: 89.5.w,
                            height: 48.h,
                            'assets/newType/timeline.png',
                            color: colorScheme.tertiary,
                          ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
