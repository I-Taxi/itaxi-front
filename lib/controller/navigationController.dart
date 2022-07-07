import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;
  PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
