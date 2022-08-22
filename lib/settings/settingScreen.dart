import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/versionScreen.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/settings/alarmScreen.dart';
import 'package:itaxi/settings/bugScreen.dart';
import 'package:itaxi/settings/myInfoScreen.dart';
import 'package:itaxi/settings/noticeScreen.dart';

import '../controller/navigationController.dart';
import '../controller/userController.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static final storage = FlutterSecureStorage();

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SignInController _signInController = Get.find();
  final NavigationController _navController = Get.put(NavigationController());
  final UserController _userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
          TextButton(
            onPressed: () {
              SettingScreen.storage.delete(key: "login");
              _signInController.reset();
              _signInController.signedOutState();
              _navController.changeIndex(1);
            },
            child: Text(
              '로그아웃',
              style: textTheme.subtitle1?.copyWith(
                color: colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.primary,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: _myListView(context: context),
        ),
      ),
    );
  }

  Widget _myListView({required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _settingListTile(
          icon: Icons.event_note,
          title: '공지사항',
          nextPage: NoticeScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _settingListTile(
          icon: Icons.person_pin,
          title: '내정보',
          nextPage: MyInfoScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _settingListTile(
          icon: Icons.new_releases_outlined,
          title: '버전정보/개발자',
          nextPage: const VersionScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _settingListTile(
          icon: Icons.notifications_none,
          title: '알림',
          nextPage: const AlarmScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _settingListTile(
          icon: Icons.bug_report,
          title: '버그제보',
          nextPage: BugScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _settingListTile(
          icon: Icons.lock,
          title: '약관',
          nextPage: const TermOfServiceScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
      ],
    );
  }

  Widget _settingListTile({
    required IconData icon,
    required String title,
    required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: Image.asset(
          width: 8.w,
          height: 8.h,
          'assets/place/departure.png',
        ),
      ),
      title: Text(
        title,
        style: textTheme.headline2?.copyWith(
          color: colorScheme.onPrimary,
          fontFamily: 'NotoSans',
        ),
      ),
      onTap: () {
        Get.to(nextPage);
      },
    );
  }
}
