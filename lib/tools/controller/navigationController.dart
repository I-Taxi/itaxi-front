import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;
  int navHeight = Platform.isIOS ? 98 : 83;
  PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void changeNavHeight(bool isOpen) {
    if (isOpen == true) {
      navHeight = 0;
    } else {
      Platform.isIOS ? navHeight = 98 : navHeight = 83;
    }
    update();
  }
}
