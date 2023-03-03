import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:itaxi/notice/model/notice.dart';

class DynamicLinkController extends GetxController {
  PendingDynamicLinkData? dynamicLinkData;
  late bool dynamicStatus = false;

  DynamicLinkController();

  void setDynamicLink(PendingDynamicLinkData? data) {
    dynamicLinkData = data;
    dynamicStatus = true;
    update();
  }

  void setDynamicStatus(bool status) {
    dynamicStatus = status;
    update();
  }
}
