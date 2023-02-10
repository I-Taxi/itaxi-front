import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  int currentIndex = 0;
  int navHeight = 98;
  PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void changeNavHeight(bool isOpen){
    if(isOpen == true){
      navHeight = 0;
    }
    else{
      navHeight = 98;
    }
    update();
  }
}
