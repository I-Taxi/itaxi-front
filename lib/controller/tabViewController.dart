import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabViewController extends GetxController {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
