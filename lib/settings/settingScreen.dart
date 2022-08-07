import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/versionScreen.dart';

import '../controller/signInController.dart';
import '../signInUp/signInScreen.dart';
import 'alarmScreen.dart';
import 'bugScreen.dart';
import 'myInfoScreen.dart';
import 'noticeScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SignInController _signInController = Get.put(SignInController());

  // 자동로그인 시 저장되어있는 Id/Pw
  static final storage = FlutterSecureStorage();

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
            shadowColor: colorScheme.shadow,
            elevation: 1.0,
            centerTitle: true,
            title: Text(
              '설정',
              style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  storage.delete(key: "login");
                  _signInController.signedOutState();
                },
                icon: Icon(
                  Icons.local_dining,
                  color: colorScheme.secondary,
                ),
              )
            ],
          ),
          body: _myListView(textTheme, colorScheme),
        ));
  }

  Widget _myListView(textTheme, colorScheme) {
    return Container(
      child: Column(
        children: [
          _comp_listTile(Icons.event_note, '공지사항', NoticeScreen(), textTheme, colorScheme),
          Divider(height: 1, indent: 13.0, endIndent: 13.0,),
          _comp_listTile(Icons.person_pin, '내정보', MyInfoScreen(), textTheme, colorScheme),
          Divider(height: 1, indent: 13.0, endIndent: 13.0,),
          _comp_listTile(
              Icons.new_releases_outlined, '버전정보/개발자', VersionScreen(), textTheme, colorScheme),
          Divider(height: 1, indent: 13.0, endIndent: 13.0,),
          _comp_listTile(Icons.notifications_none, '알림', AlarmScreen(), textTheme, colorScheme),
          Divider(height: 1, indent: 13.0, endIndent: 13.0,),
          _comp_listTile(Icons.bug_report, '버그제보', BugScreen(), textTheme, colorScheme),
          Divider(height: 1, indent: 13.0, endIndent: 13.0,),
          _comp_listTile(Icons.lock, '이용약관', TermOfServiceScreen(), textTheme, colorScheme),
        ]
      ),
    );
  }

  Container _comp_listTile(icon, text, next, textTheme, colorScheme) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 8.0.w),
      child: ListTile(
          leading: Icon(icon),
          title: Text(text,
              style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary)),
          onTap: () {
            // 하단 네비게이터 없게 하기
            Get.to(next);
          }
      ),
    );
  }
}
