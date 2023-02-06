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
import 'package:flutter/cupertino.dart';

import 'package:itaxi/settings/bugScreen.dart';
import 'package:itaxi/settings/privacyPolicyScreen.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/myInfoScreen.dart';

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

  bool alarm = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 0.0,
      ),
      backgroundColor: colorScheme.primary,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: Padding(
          padding: EdgeInsets.only(left: 35.w, right: 28.5.w),
          child: _myListView(context: context),
        ),
      ),
    );
  }

  Widget _myListView({required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage("assets/profile.png"),
          height: 88.w,
          width: 88.w,
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: "OOO학부생\n", //"${snapshot.data!.name.toString()}학부생",
                  style: textTheme.headline3?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "handongin@handong.ac.kr", //snapshot.data!.email.toString(),
                      style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer),
                    )
                  ]),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Get.to(MyInfoScreen());
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20.h,
              ),
              color: colorScheme.tertiaryContainer,
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          height: 1.5.h,
          width: 390.w,
          color: Color(0xE1E1E1E1),
        ),
        SizedBox(
          height: 23.h,
        ),
        _settingListTile(
          title: '공지사항',
          nextPage: NoticeScreen(),
          context: context,
        ),
        SizedBox(
          height: 22.h,
        ),
        _alarmListTile(
          title: '알림',
          nextPage: const AlarmScreen(),
          context: context,
        ),
        SizedBox(
          height: 22.h,
        ),
        _settingListTile(
          title: '버그제보',
          nextPage: BugScreen(),
          context: context,
        ),
        SizedBox(
          height: 22.h,
        ),
        _settingListTile(
          title: '약관',
          nextPage: const TermOfServiceScreen(),
          context: context,
        ),
        SizedBox(
          height: 22.h,
        ),
        _settingListTile(
          title: '버전정보/개발자',
          nextPage: const VersionScreen(),
          context: context,
        ),
        SizedBox(
          height: 22.h,
        ),
        _settingListTile(
          title: '개인정보처리방침',
          nextPage: const PrivacyPolicyScreen(),
          context: context,
        ),
        SizedBox(
          height: 200.h,
        ),
        Row(
          children: [
            Text(
              "Created by CRA",
              style: textTheme.bodyText2?.copyWith(
                color: colorScheme.tertiaryContainer,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _logout;
                });
              },
              icon: Icon(Icons.logout),
              color: colorScheme.tertiary,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _logout;
                });
              },
              child: Text(
                "로그아웃",
                style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  // 알람 타일
  Widget _alarmListTile({
    required String title,
    required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(nextPage);
          },
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onPrimary),
          ),
        ),
        Spacer(),
        Transform.scale(
          scale: 0.6,
          child: CupertinoSwitch(
              value: alarm,
              activeColor: Color(0xff00CE21),
              thumbColor: colorScheme.primary,
              onChanged: (bool value) {
                setState(() {
                  alarm = value;
                });
              }),
        )
      ],
    );
  }

  Widget _settingListTile({
    required String title,
    required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Get.to(nextPage);
      },
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: textTheme.subtitle1?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }

  void _logout({
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              width: 360.w,
              height: 240.h,
              padding: EdgeInsets.fromLTRB(
                36.0.w,
                24.0.h,
                36.0.w,
                24.0.h,
              ),
              child: Column(
                children: [
                  Text(
                    "로그아웃 하시겠습니까?",
                    style: textTheme.subtitle1?.copyWith(color: colorScheme.secondary),
                  ),
                  const Spacer(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, "취소"),
                        child: Text(
                          "취소",
                          style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.tertiary,
                          ),
                        )),
                    SizedBox(
                      width: 60.w,
                    ),
                    TextButton(
                        onPressed: () async {
                          await SettingScreen.storage.delete(key: "login");
                          _signInController.reset();
                          _signInController.signedOutState();
                          _navController.changeIndex(1);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "확인",
                          style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.secondary,
                          ),
                        )),
                  ])
                ],
              ),
            ),
          );
        });
  }

  // 회원탈퇴 타일 => 알림 타일로 바꿀 예정
  // Widget _deleteUserListTile({
  //   required String title,
  //   required BuildContext context,
  // }) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final textTheme = Theme.of(context).textTheme;
  //   return ListTile(
  //     title: Text(
  //       title,
  //       style: textTheme.headline1?.copyWith(
  //         color: colorScheme.onPrimary,
  //           fontWeight: FontWeight.w500
  //       ),
  //     ),
  //     onTap: () {
  //       deletedUserDialog(context, '회원탈퇴',
  //           '현재 모집중인 방이 있거나, 입장하신 방이 있는 경우에는 회원탈퇴가 되지 않습니다.\n정말로 탈퇴하시겠습니까?');
  //     },
  //   );
  // }

  // 현재 모집중이거나 입장한 방이 있을 경우 dialog
  void deletedUserDialog(BuildContext context, String? title, String? content) {
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
              height: 240.h,
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
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    content as String,
                    style: textTheme.bodyText1?.copyWith(
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
                      } else {
                        Get.back();
                        mainDialog(context, '회원탈퇴',
                            '현재 모집중이거나 입장하신 방이 있습니다. 해당 방을 나가신 후 다시 시도해주세요.');
                      }
                    },
                    child: Text(
                      "확인",
                      style: textTheme.subtitle1
                          ?.copyWith(color: colorScheme.tertiary),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
