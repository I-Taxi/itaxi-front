import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/timeline/timelineScreen.dart';
import 'package:itaxi/controller/navigationController.dart';

import 'package:itaxi/placeSearch/placeSearchScreen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pageList = [
      const TimelineScreen(),
      const MainScreen(),
      // const SettingScreen()
      const PlaceSearchScreen()
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
                label: 'timeline',
                activeIcon: Image.asset(
                  width: 32.w,
                  height: 32.h,
                  'assets/bottom_bar/timeline_2.png',
                ),
                icon: Image.asset(
                  width: 32.w,
                  height: 32.h,
                  'assets/bottom_bar/timeline_1.png',
                ),
              ),
              BottomNavigationBarItem(
                label: 'main',
                activeIcon: Image.asset(
                  width: 45.71.w,
                  height: 32.h,
                  'assets/bottom_bar/home_2.png',
                ),
                icon: Image.asset(
                  width: 45.71.w,
                  height: 32.h,
                  'assets/bottom_bar/home_1.png',
                ),
              ),
              BottomNavigationBarItem(
                label: 'settings',
                activeIcon: Image.asset(
                    width: 32.w,
                    height: 7.45.h,
                    'assets/bottom_bar/setting_2.png'),
                icon: Image.asset(
                    width: 32.w,
                    height: 7.45.h,
                    'assets/bottom_bar/setting_1.png'),
              )
            ],
          ),
        );
      },
    );
  }
}
