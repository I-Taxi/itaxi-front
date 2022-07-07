import 'package:flutter/material.dart';

Widget selectedTabView(
    {required String viewTitle, required TextTheme textTheme}) {
  return Container(
    width: 80.0,
    height: 50.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
        color: Colors.blue,
        width: 1.0,
      )),
    ),
    child: Text(
      viewTitle,
      style: textTheme.headline1,
    ),
  );
}

Widget unSelectedTabView(
    {required String viewTitle, required TextTheme textTheme}) {
  return Container(
    width: 80.0,
    height: 50.0,
    alignment: Alignment.center,
    child: Text(
      viewTitle,
      style: textTheme.headline1,
    ),
  );
}
