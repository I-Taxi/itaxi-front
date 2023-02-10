import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenController extends GetxController {
  int capacity = 2;

  // mainScreen
  bool mainScreenLoaded = false;
  bool hasNotice = false;
  bool isCheckScreen = false;
  int mainScreenCurrentTabIndex = 0;
  int mainScreenCurrentToggle = 0;
  int stopOver = 0;

  // ktxScreen
  bool ktxScreenLoaded = false;
  bool discountSelect = false;
  int sale = 35;
  int ktxScreenCurrentTabIndex = 0;
  int ktxScreenCurrentToggle = 0;

  // timeline
  bool enlargement = true;
  double backgroundHeight = 108.h;

  void toggleHasNotice() {
    hasNotice = !hasNotice;
    update();
  }

  void toggleDiscount() {
    discountSelect = !discountSelect;
    update();
  }

  void setCheckScreen(bool to) {
    isCheckScreen = to;
    update();
  }

  void setUnenlargement() {
    enlargement = false;
    update();
  }

  void setEnlargement() {
    enlargement = true;
    update();
  }

  void setBackgroundHeight(double top, double bottom, double max, double scrollHeight) {
    backgroundHeight = bottom - (bottom - top) / max * scrollHeight;
    if (backgroundHeight < top) backgroundHeight = top;
    print(backgroundHeight);
    update();
  }

  void setSale(int rate) {
    sale = rate;
    update();
  }

  void setMainScreenLoaded() {
    mainScreenLoaded = true;
    update();
  }

  void setMainScreenUnloaded() {
    mainScreenLoaded = false;
    update();
  }

  void setKtxScreenLoaded() {
    ktxScreenLoaded = true;
    update();
  }

  void setKtxScreenUnloaded() {
    ktxScreenLoaded = false;
    update();
  }

  void changeMainScreenTabIndex(int index) {
    mainScreenCurrentTabIndex = index;
    update();
  }

  void changeMainScreenToggleIndex(int index) {
    mainScreenCurrentToggle = index;
    if (capacity < 2) {
      capacity = 2;
    }
    if (mainScreenCurrentTabIndex == 0) {
      mainScreenCurrentTabIndex = 2;
    }
    update();
  }

  void changeKtxScreenTabIndex(int index) {
    ktxScreenCurrentTabIndex = index;
    update();
  }

  void changeKtxScreenToggleIndex(int index) {
    ktxScreenCurrentToggle = index;
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

  void mainScreenSubtractCapacity() {
    if (mainScreenCurrentToggle == 0) {
      if (capacity > 1) {
        capacity--;
        update();
      }
    } else {
      if (capacity > 2) {
        capacity--;
        update();
      }
    }
  }

  void ktxScreenSubtractCapacity() {
    if (ktxScreenCurrentToggle == 0) {
      if (capacity > 1) {
        capacity--;
        update();
      }
    } else {
      if (capacity > 2) {
        capacity--;
        update();
      }
    }
  }
}
