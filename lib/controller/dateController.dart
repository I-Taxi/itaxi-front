import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';

class DateController extends GetxController {
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
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      pickedDate = selectedDate;
      update();
      _postController.getPosts(
          depId: _placeController.dep?.id,
          dstId: _placeController.dst?.id,
          time: formattingDateTime(mergeDateAndTime()));
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

  DateTime mergeDateAndTime() {
    return DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day,
        pickedTime!.hour, pickedTime!.minute);
  }

  String formattingDateTime(DateTime datetime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(datetime);
  }
}
