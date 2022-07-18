import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  DateTime? pickedDate;

  @override
  void onInit() {
    super.onInit();
    pickedDate = DateTime.now();
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
}
