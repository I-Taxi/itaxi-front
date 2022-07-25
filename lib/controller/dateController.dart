import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/postsController.dart';

class DateController extends GetxController {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  void onInit() {
    super.onInit();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      pickedDate = selectedDate;
      update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      pickedTime = selectedTime;
      update();
    }
  }
}
