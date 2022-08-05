import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void mainDialog (BuildContext context, String? title, String? content) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("[${title}]"),
        content: Text(content as String, style: textTheme.bodyText1, ),
        actions: [
          TextButton(
            child: Text("확인", style: textTheme.bodyText1,),
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
    }

  );

}