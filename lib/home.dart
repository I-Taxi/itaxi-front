import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

import 'package:itaxi/mainScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/timeline/timelineScreen.dart';
import 'package:itaxi/controller/navigationController.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final pageList = [TimelineScreen(), MainScreen(), SettingScreen()];

    return GetBuilder<NavigationController>(builder: (_) {
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
                icon: Icon(Icons.access_time),
              ),
              BottomNavigationBarItem(
                label: 'main',
                icon: Icon(Icons.directions_car),
              ),
              BottomNavigationBarItem(
                  label: 'settings',
                  icon: Icon(
                    Icons.more_horiz_rounded,
                  ))
            ]),
      );
    });
  }
}
