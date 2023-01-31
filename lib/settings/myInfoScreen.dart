import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/settings/userInfoRefactorScreen.dart';
import 'package:dotted_line/dotted_line.dart';

import '../model/userInfoList.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/controller/navigationController.dart';
import '../widget/mainDialog.dart';
import 'package:itaxi/settings/settingScreen.dart';

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
              icon: Icon(
                Icons.clear_sharp,
                color: colorScheme.tertiary,
              ),
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
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 24.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data!.name.toString()}학부생",
                                      style: textTheme.headline1!.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      snapshot.data!.email.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyText1!.copyWith(
                                        color: colorScheme.tertiaryContainer,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      snapshot.data!.phone.toString(),
                                      style: textTheme.bodyText1!.copyWith(
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
                                    "assets/change_profile.png",
                                    width: 88.w,
                                    height: 88.h,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              height: 8.h,
                              color: Color(0xffF1F1F1),
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Text(
                              "계정 관리",
                              style: textTheme.headline1!.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontSize: 18 //ios일 경우 20 전반적인 수정 작업 필요
                                  ),
                            ),
                            SizedBox(
                              height: 28.5.h,
                            ),
                            _management(
                                title: "휴대폰 번호 재설정",
                                //nextPage: ,
                                context: context),
                            SizedBox(
                              height: 18.5.h,
                            ),
                            _management(
                                title: "비밀번호 재설정",
                                //nextPage: ,
                                context: context),
                            SizedBox(
                              height: 18.5.h,
                            ),
                            _deleteUserAccount(
                                title: "회원 탈퇴하기",
                                //nextPage: ,
                                context: context),
                            SizedBox(
                              height: 18.5.h,
                            ),
                            Container(
                              height: 8.h,
                              color: Color(0xffF1F1F1),
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Text(
                              "결제 관리",
                              style: textTheme.headline1!.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontSize: 18 //ios일 경우 20 전반적인 수정 작업 필요
                                  ),
                            ),
                            SizedBox(
                              height: 28.5.h,
                            ),
                            _management(title: "계좌번호 변경", context: context)
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          '로딩 중 오류가 발생하였습니다 :<',
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.tertiary,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                        style: textTheme.headline2?.copyWith(
                          color: colorScheme.tertiary,
                          fontFamily: 'NotoSans',
                        ),
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
    //required nextPage,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.headline1!
                      .copyWith(color: colorScheme.onPrimary),
                ),
                SizedBox(
                  width: 32.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 15.63.w,
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
          onTap: () {
            deletedUserDialog(context, '회원탈퇴',
                '현재 모집중인 방이 있거나, 입장하신 방이 있는 경우에는 회원탈퇴가 되지 않습니다.\n정말로 탈퇴하시겠습니까?');
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      textTheme.headline1!.copyWith(color: Color(0xffE67373)),
                ),
                SizedBox(
                  width: 32.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 15.63.w,
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
                      } else {
                        Get.back();
                        mainDialog(context, '회원탈퇴',
                            '현재 모집중이거나 입장하신 방이 있습니다. 해당 방을 나가신 후 다시 시도해주세요.');
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
        });
  }
}
