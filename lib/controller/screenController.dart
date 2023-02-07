import 'package:get/get.dart';

class ScreenController extends GetxController {
  int capacity = 2;

  // mainScreen
  bool mainScreenLoaded = false;
  bool hasNotice = false;
  int mainScreenCurrentTabIndex = 0;
  int mainScreenCurrentToggle = 0;
  int stopOver = 0;

  // ktxScreen
  bool ktxScreenLoaded = false;
  bool discountSelect = false;
  int discountRate = 35;
  int ktxScreenCurrentTabIndex = 0;
  int ktxScreenCurrentToggle = 0;

  void toggleHasNotice() {
    hasNotice = !hasNotice;
    update();
  }

  void toggleDiscount() {
    discountSelect = !discountSelect;
    update();
  }

  void setDiscountRate(int rate) {
    discountRate = rate;
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

  void subtractCapacity() {
    if (capacity > 2) {
      capacity--;
      update();
    }
  }
}
