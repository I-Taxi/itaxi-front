import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: colorScheme.shadow,
          ),
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '알림',
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.onPrimary
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    width: 150.0,
                    'assets/logo_1.png',
                  ),
                  Text('공사중입니다.', style: textTheme.bodyText1!.copyWith(fontSize: 15.0.sp),)
                ],
              ),
        )
          ),
    );
  }
}
