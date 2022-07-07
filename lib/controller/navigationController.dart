import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  int currentIndex = 1;
  PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
