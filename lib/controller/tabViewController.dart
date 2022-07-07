import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabViewController extends GetxController {
  int currentIndex = 1;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
