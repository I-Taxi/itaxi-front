import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/newTimeline/checkPlaceScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/timeline/timelineScreen.dart';
import 'package:itaxi/controller/navigationController.dart';

import 'package:itaxi/placeSearch/placeSearchScreen.dart';
import 'package:itaxi/newTimeline/checkPlaceScreen.dart';

import 'package:itaxi/newMainScreen.dart';
import 'package:itaxi/newMainScreenGather.dart';
import 'package:itaxi/stopoverScreen.dart';
import 'package:itaxi/newTimeline/newTimelineScreen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [
      const NewTimelineScreen(),  //원래 timeline이었음
      const StopoverScreen(),         // 원래 MainScreen이었음
      const SettingScreen(),
      const CheckPlaceScreen()
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
