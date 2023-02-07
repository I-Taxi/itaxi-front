import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/model/userInfoList.dart';
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
import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static final storage = FlutterSecureStorage();

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SignInController _signInController = Get.find();
  final NavigationController _navController = Get.put(NavigationController());
  final UserController _userController = Get.find();

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
    return GetBuilder<UserController>(
      builder: (_) {
        return FutureBuilder<UserInfoList>(
          future: _userController.users,
          builder: (BuildContext context, snapshot) {
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
                          text: "${snapshot.data!.name.toString()}학부생\n",
                          style: textTheme.headline3?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data!.email.toString(),
                              style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer, fontSize: 10),
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
                  title: '버전정보 / 개발자',
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
                        color: colorScheme.tertiary,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        _logout(context: context);
                      },
                      icon: Image.asset("assets/logout.png"),
                      color: colorScheme.tertiary,
                    ),
                    GestureDetector(
                      onTap: () {
                        _logout(context: context);
                      },
                      child: Text(
                        "로그아웃",
                        style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiary
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }
        );
      }
    );
  }

  // 알림 타일
  Widget _alarmListTile({
    required String title,
    required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(nextPage);
          },
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: textTheme.subtitle1?.copyWith(
                color: colorScheme.onTertiary),
          ),
        ),
        Spacer(),
        Container(
          height: 17.h,
          width: 34.w,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CupertinoSwitch(
                value: alarm,
                activeColor: colorScheme.inverseSurface,
                thumbColor: colorScheme.primary,
                trackColor: colorScheme.tertiary,
                onChanged: (bool value) {
                  setState(() {
                    alarm = value;
                  });
                }),
          ),
        )
        // Transform.scale(
        //   scale: 1.0,
        //   child: CupertinoSwitch(
        //       value: alarm,
        //       activeColor: Color(0xff00CE21),
        //       thumbColor: colorScheme.primary,
        //       onChanged: (bool value) {
        //         setState(() {
        //           alarm = value;
        //         });
        //       }),
        // )
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
        style: textTheme.subtitle1?.copyWith(color: colorScheme.onTertiary),
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
                50.0.h,
                36.0.w,
                50.0.h,
              ),
              child: Column(
                children: [
                  Text(
                    "로그아웃 하시겠습니까?",
                    style: textTheme.subtitle1?.copyWith(color: colorScheme.onSecondaryContainer),
                  ),
                  const Spacer(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, "취소"),
                        child: Text(
                          "취소",
                          style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.tertiaryContainer,
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
                          _navController.changeIndex(0);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "확인",
                          style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.onSecondaryContainer,
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
}
