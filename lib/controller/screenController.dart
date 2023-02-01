import 'package:get/get.dart';

class ScreenController extends GetxController {
  int currentTabIndex = 0;
  int currentToggle = 0;
  int stopOver = 0;

  void changeTabIndex(int index) {
    currentTabIndex = index;
    update();
  }

  void changeToggleIndex(int index) {
    currentToggle = index;
    update();
  }

  void changeStopOver(int index) {
    stopOver = index;
    update();
  }
}
