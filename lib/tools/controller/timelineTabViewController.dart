import 'package:get/get.dart';

class TimelineTabViewController extends GetxController {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
