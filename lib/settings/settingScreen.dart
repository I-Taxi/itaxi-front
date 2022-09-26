import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/settings/privacyPolicyScreen.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/versionScreen.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/settings/alarmScreen.dart';
import 'package:itaxi/settings/bugScreen.dart';
import 'package:itaxi/settings/myInfoScreen.dart';
import 'package:itaxi/settings/noticeScreen.dart';

import '../controller/navigationController.dart';
import '../controller/userController.dart';
import '../widget/mainDialog.dart';

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
            onPressed: () async {
              await SettingScreen.storage.delete(key: "login");
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
        _settingListTile(
          icon: Icons.lock,
          title: '개인정보처리방침',
          nextPage: const PrivacyPolicyScreen(),
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
        _deleteUserListTile(
          title: '회원탈퇴',
          context: context,
        ),
        Divider(
          height: 0.3,
          color: colorScheme.shadow,
        ),
      ],
    );
  }

  // 설정 타일
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

  // 회원탈퇴 타일
  Widget _deleteUserListTile({
    required String title,
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
        deletedUserDialog(context, '회원탈퇴', '현재 모집중인 방이 있거나, 입장하신 방이 있는 경우에는 회원탈퇴가 되지 않습니다.\n정말로 탈퇴하시겠습니까?');
      },
    );
  }

  // 현재 모집중이거나 입장한 방이 있을 경우 dialog
  void deletedUserDialog (BuildContext context, String? title, String? content) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Container(
              width: 360.w,
              height: 200.h,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                28.0.w,
                32.0.h,
                28.0.w,
                12.0.h,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    title as String,
                    style: textTheme.headline1?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    content as String,
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      print("체크1");
                      print(_userController.isDeleted);
                      await _userController.fetchDeleteUsers();
                      print(_userController.isDeleted);
                      if (_userController.isDeleted == 1) {
                        _signInController.deleteUser();
                        await SettingScreen.storage.delete(key: "login");
                        _signInController.reset();
                        _navController.changeIndex(1);
                      }else {
                        Get.back();
                        mainDialog(context, '회원탈퇴', '현재 모집중이거나 입장하신 방이 있습니다. 해당 방을 나가신 후 다시 시도해주세요.');
                      }
                    },
                    child: Text(
                      "확인",
                      style: textTheme.headline1
                          ?.copyWith(color: colorScheme.tertiary),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

    );

  }
}
