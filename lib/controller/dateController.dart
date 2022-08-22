import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/tabViewController.dart';

class DateController extends GetxController {
  late TabViewController _tabViewController = Get.find();
  late PostController _postController = Get.find();
  late PlaceController _placeController = Get.find();
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  void onInit() {
    super.onInit();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  Future<void> selectDate(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: pickedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: '출발일',
      cancelText: '취소',
      confirmText: '확인',
      fieldLabelText: '날짜를 입력해주세요',
      fieldHintText: '월/일/년도',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.secondary,
              onPrimary: colorScheme.primary,
              onSurface: colorScheme.tertiary,
            ),
            textTheme: textTheme.copyWith(
              bodySmall: TextStyle(
                fontSize: Platform.isIOS ? 15 : 13,
                fontFamily: 'Seoul',
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: colorScheme.secondary,
                textStyle: TextStyle(
                  fontSize: Platform.isIOS ? 15 : 13,
                  fontFamily: 'NotoSans',
                ), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      pickedDate = selectedDate;
      update();
      _postController.getPosts(
        depId: _placeController.dep?.id,
        dstId: _placeController.dst?.id,
        time: formattingDateTime(mergeDateAndTime()),
        postType: _tabViewController.currentIndex,
      );
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: '출발시간',
      cancelText: '취소',
      confirmText: '확인',
      hourLabelText: '시간',
      minuteLabelText: '분',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.secondary,
              onPrimary: colorScheme.primary,
              onSurface: colorScheme.tertiary,
            ),
            textTheme: textTheme.copyWith(
              bodySmall: TextStyle(
                fontSize: Platform.isIOS ? 15 : 13,
                fontFamily: 'Seoul',
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: colorScheme.secondary,
                textStyle: TextStyle(
                  fontSize: Platform.isIOS ? 15 : 13,
                  fontFamily: 'NotoSans',
                ), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      pickedTime = selectedTime;
      update();
    }
  }

  void beforDate() {
    pickedDate = pickedDate!.add(const Duration(days: -1));
    update();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: formattingDateTime(mergeDateAndTime()),
      postType: _tabViewController.currentIndex,
    );
  }

  void afterDate() {
    pickedDate = pickedDate!.add(const Duration(days: 1));
    update();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: formattingDateTime(mergeDateAndTime()),
      postType: _tabViewController.currentIndex,
    );
  }

  DateTime mergeDateAndTime() {
    return DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day,
        pickedTime!.hour, pickedTime!.minute);
  }

  String formattingDateTime(DateTime datetime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(datetime);
  }
}
