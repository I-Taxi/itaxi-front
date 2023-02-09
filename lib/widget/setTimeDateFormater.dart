import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addKtxPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/ktxPlaceController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';
import 'package:itaxi/widget/snackBar.dart';

import 'package:itaxi/controller/userController.dart';

import 'package:itaxi/placeSearch/ktxSearchScreen.dart';
import 'package:itaxi/placeSearch/ktxPlaceSearchController.dart';
import 'package:itaxi/widget/postTypeToggleButton.dart';

String lookupDateFormater(DateTime dateTime) {
  String query = '';
  List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];
  query =
      '${DateFormat('MM월 dd일').format(dateTime)} (${korDays[dateTime.weekday - 1]})';
  return query;
}

String gatherDateFormater(DateTime dateTime) {
  String query = '';
  List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];
  query =
      '${DateFormat('MM월 dd일').format(dateTime)} (${korDays[dateTime.weekday - 1]}) ${DateFormat('hh:mm').format(dateTime)}';
  return query;
}
