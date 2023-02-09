import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:itaxi/chat/chatRoomListScreen.dart';
import 'package:itaxi/controller/navigationController.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/ktxScreen.dart';
import 'package:itaxi/timeline/timelineScreen.dart';


class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());
  // final MainScreen main = new MainScreen();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [
      const MainScreen(),
      const KtxScreen(),
      const ChatroomListScreen(),
      const TimelineScreen()
    ];

    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          body: pageList[_navController.currentIndex],
          bottomNavigationBar: Container(
            height: _navController.navHeight.h,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _navController.currentIndex,
              backgroundColor: colorScheme.primary,
              selectedItemColor: colorScheme.secondary,
              unselectedItemColor: colorScheme.tertiary,
              onTap: (value) {
                _navController.changeIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                  label: "car_taxi",
                  activeIcon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/car_taxi.png',
                    color: colorScheme.secondary,
                  ),
                  icon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/car_taxi.png',
                    color: colorScheme.tertiary,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "KTX",
                  activeIcon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/ktx.png',
                    color: colorScheme.secondary,
                  ),
                  icon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/ktx.png',
                  ),
                ),
                BottomNavigationBarItem(
                  label: "messenger",
                  activeIcon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/messenger.png',
                    color: colorScheme.secondary,
                  ),
                  icon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/messenger.png',
                  ),
                ),
                BottomNavigationBarItem(
                  label: "timeline",
                  activeIcon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/timeline.png',
                    color: colorScheme.secondary,
                  ),
                  icon: Image.asset(
                    width: 89.5.w,
                    height: 48.h,
                    'assets/newType/timeline.png',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
