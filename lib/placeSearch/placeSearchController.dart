import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

class PlaceSearchController extends GetxController {
  int _currentIndex = 0;
  int _postType = 0;
  int _peopleCount = 2;

  late DateTime _pickedDate;
  late TimeOfDay _pickedTime;

  int get currentIndex => _currentIndex;
  int get postType => _postType;
  int get peopleCount => _peopleCount;

  DateTime get pickedDate => _pickedDate;
  TimeOfDay get pickedTime => _pickedTime;

  void changeIndex(int idx) {
    _currentIndex = idx;
    update();
  }

  void changePostType(int idx) {
    _postType = idx;
    update();
  }

  void increasePeople() {
    if (_peopleCount < 4) {
      _peopleCount++;
      update();
    }
  }

  void decreasePeople() {
    if (_peopleCount > 2) {
      _peopleCount--;
      update();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: pickedDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 31)),
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
        }
    );

    if (selectedDate != null) {
      _pickedDate = selectedDate;
      update();

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
      _pickedTime = selectedTime;
      update();
    }
  }

  DateTime mergeDateAndTime() {
    return DateTime(_pickedDate.year, _pickedDate.month, _pickedDate.day,
        _pickedTime.hour, _pickedTime.minute);
  }

  @override
  void onInit() {
    super.onInit();
    _pickedDate = DateTime.now();
    _pickedTime = TimeOfDay.now();
  }


}