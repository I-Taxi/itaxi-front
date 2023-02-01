import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:itaxi/chat/chatRoomListScreen.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/controller/navigationController.dart';

import 'package:itaxi/placeSearch/placeSearchScreen.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/gatherScreen.dart';
import 'package:itaxi/stopOverScreen.dart';
import 'package:itaxi/timeline/timelineScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [
      const MainScreen(), //원래 timeline이었음
      const GatherScreen(), // 원래 MainScreen이었음
      const ChatroomListScreen(), // 원래 SettingScreen이었음
      const TimelineScreen()
    ];

    return GetBuilder<NavigationController>(
      builder: (_) {
        return Scaffold(
          body: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: pageList[_navController.currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
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
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/car_taxi.png',
                  color: colorScheme.secondary,
                ),
                icon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/car_taxi.png',
                  color: colorScheme.tertiary,
                ),
              ),
              BottomNavigationBarItem(
                label: "KTX",
                activeIcon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/ktx.png',
                  color: colorScheme.secondary,
                ),
                icon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/ktx.png',
                ),
              ),
              BottomNavigationBarItem(
                label: "messenger",
                activeIcon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/messenger.png',
                  color: colorScheme.secondary,
                ),
                icon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/messenger.png',
                ),
              ),
              BottomNavigationBarItem(
                label: "timeline",
                activeIcon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/timeline.png',
                  color: colorScheme.secondary,
                ),
                icon: Image.asset(
                  width: 100.w,
                  height: 60.h,
                  'assets/newType/timeline.png',
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
