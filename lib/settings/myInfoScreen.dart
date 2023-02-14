import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:dotted_line/dotted_line.dart';

import '../model/userInfoList.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/controller/navigationController.dart';
import '../widget/mainDialog.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/settings/changePhoneNumScreen.dart';
import 'package:itaxi/settings/resetPWScreen.dart';
import 'package:itaxi/settings/changeAccountScreen.dart';
import 'package:itaxi/signInUp/forgotPwScreen.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  // UserController _userController = Get.put(UserController());
  UserController _userController = Get.find();
  final SignInController _signInController = Get.find();
  final NavigationController _navController = Get.put(NavigationController());

  @override
  initState() {
    super.initState();
    _userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset("assets/button/clear.png", width: 24.w, height: 24.w, color: colorScheme. tertiaryContainer,)
            ),
          ]),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: SingleChildScrollView(
          child: GetBuilder<UserController>(
            builder: (_) {
              return FutureBuilder<UserInfoList>(
                future: _userController.users,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: colorScheme.onTertiaryContainer,
                            height: 148.h,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(right: 24.w, left: 24.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   width: 136.w,
                                    //   height: 128.h,
                                    //   padding: EdgeInsets.symmetric(
                                    //     vertical: 44.h,
                                    //     horizontal: 38.w,
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //     color: colorScheme.secondary,
                                    //     borderRadius: const BorderRadius.all(
                                    //       Radius.circular(4),
                                    //     ),
                                    //   ),
                                    //   child: Image.asset(
                                    //     width: 58.0.w,
                                    //     height: 40.h,
                                    //     'assets/logo_2_new.png',
                                    //   ),
                                    // ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 26.h,
                                        ),
                                        Text(
                                          "${snapshot.data!.name.toString()}학부생",
                                          style: textTheme.headline3!.copyWith(
                                              color: colorScheme.onPrimary,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 2.0.h,
                                        ),
                                        Text(
                                          snapshot.data!.email.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyText2!.copyWith(
                                            color: colorScheme.tertiaryContainer,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.0.h,
                                        ),
                                        Text(
                                          snapshot.data!.phone.toString(),
                                          style: textTheme.bodyText2!.copyWith(
                                            color: colorScheme.tertiaryContainer,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Image.asset(
                                        "assets/profile_camera.png",
                                        width: 88.w,
                                        height: 91.h,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24.w, right: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "계정 관리",
                                  style: textTheme.subtitle1!.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                SizedBox(
                                  height: 28.5.h,
                                ),
                                _management(
                                    title: "휴대폰 번호 재설정",
                                    nextPage: FindPhoneNumScreen(),
                                    context: context),
                                SizedBox(
                                  height: 18.5.h,
                                ),
                                _management(
                                    title: "비밀번호 재설정",
                                    nextPage: ResetPWScreen(),
                                    context: context),
                                SizedBox(
                                  height: 18.5.h,
                                ),
                                _deleteUserAccount(
                                    title: "회원 탈퇴하기",
                                    context: context),
                              ],
                            ),
                          ),
                          Container(
                            width: 390.w,
                            height: 156.h,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.1, color: colorScheme.tertiary),
                                bottom: BorderSide(width: 0.1, color: colorScheme.tertiary)
                              )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 24.w, right: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 36.h,
                                  ),
                                  Text(
                                    "결제 관리",
                                    style: textTheme.subtitle1!.copyWith(
                                      color: colorScheme.onTertiary,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  _management(title: "계좌번호 추가/변경", nextPage: ChangeAccountScreen(), context: context)
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          '로딩 중 오류가 발생하였습니다 :<',
                          style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiary)
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                        style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiary)
                      ),
                    );
                  }
                  return LinearProgressIndicator(
                    color: colorScheme.secondary,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _management({
    required String title,
    required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(nextPage);
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.bodyText1!
                      .copyWith(color: colorScheme.onTertiary),
                ),
                SizedBox(
                  width: 32.w,
                ),
                Icon(
                    Icons.arrow_forward_ios,
                  color: colorScheme.tertiaryContainer,
                  size: 16.67,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 18.5.h,
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 0.3,
          dashLength: 1.0,
          dashColor: colorScheme.tertiaryContainer,
          dashGapLength: 1.0,
        ),
      ],
    );
  }

  Widget _deleteUserAccount({
    required String title,
    //required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            deletedUserDialog(context, '회원 탈퇴 하시겠어요?',
                '지금 당장 필요하지 않아도\n언제나 한동대학교 계정을 통해서\n다시 가입하실 수 있어요');
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      textTheme.bodyText1!.copyWith(color: Color(0xffE67373)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

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
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              width: 312.w,
              height: 253.h,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                36.0.w,
                24.0.h,
                36.0.w,
                24.0.h,
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
                    height: 22.h,
                  ),
                  Container(
                    width: 240.w,
                    height: 99.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        content as String,
                        style: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 63.w,
                        height: 33.h,
                        child: TextButton(
                          onPressed: () async {
                            Get.back();
                          },
                          child: Text(
                            "취소",
                            style: textTheme.subtitle2
                                ?.copyWith(color: colorScheme.tertiaryContainer),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 78.w,
                      ),
                      Container(
                        width: 63.w,
                        height: 33.h,
                        child: TextButton(
                          onPressed: () async {
                            Get.back();
                            print("체크1");
                            print(_userController.isDeleted);
                            await _userController.fetchDeleteUsers();
                            print(_userController.isDeleted);
                            if (_userController.isDeleted == 1) {
                              _signInController.deleteUser();
                              _signInController.reset();
                              _navController.changeIndex(0);
                              Get.back();
                              Get.back();
                              Get.back();
                            } else if(_userController.isDeleted == 2){
                              mainDialog(context, '회원탈퇴',
                                  '현재 모집중이거나 입장하신 방이 있습니다. 해당 방을 나가신 후 다시 시도해주세요.');
                            }
                          },
                          child: Text(
                            "탈퇴",
                            style: textTheme.subtitle2
                                ?.copyWith(color: colorScheme.errorContainer),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
