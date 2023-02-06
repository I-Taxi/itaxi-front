import 'package:get/get.dart';

class ScreenController extends GetxController {
  bool mainScreenLoaded = false;
  int currentTabIndex = 0;
  int currentToggle = 0;
  int stopOver = 0;
  int capacity = 2;

  void setMainScreenLoaded() {
    mainScreenLoaded = true;
    update();
  }

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

  void addCapacity() {
    if (capacity < 4) {
      capacity++;
      update();
    }
  }

  void subtractCapacity() {
    if (capacity > 2) {
      capacity--;
      update();
    }
  }
}
