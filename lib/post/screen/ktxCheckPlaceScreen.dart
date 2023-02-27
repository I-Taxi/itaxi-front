import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/post/controller/addKtxPostController.dart';
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/place/controller/ktxPlaceController.dart';
import 'package:itaxi/post/controller/ktxPostController.dart';
import 'package:itaxi/tools/controller/screenController.dart';
import 'package:itaxi/post/model/ktxPost.dart';
import 'package:itaxi/post/widget/ktxPostListTile.dart';
import 'package:itaxi/place/widget/abbreviatePlaceName.dart';

import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/tools/controller/navigationController.dart';
import 'package:itaxi/user/controller/signInController.dart';
import 'package:itaxi/user/model/userInfoList.dart';
import 'package:itaxi/settings/bugScreen.dart';
import 'package:itaxi/settings/myInfoScreen.dart';
import 'package:itaxi/settings/noticeScreen.dart';
import 'package:itaxi/settings/privacyPolicyScreen.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/versionScreen.dart';

class KtxCheckPlaceScreen extends StatefulWidget {
  const KtxCheckPlaceScreen({Key? key}) : super(key: key);

  @override
  State<KtxCheckPlaceScreen> createState() => _KtxCheckPlaceScreenState();
}

class _KtxCheckPlaceScreenState extends State<KtxCheckPlaceScreen> {
  ScreenController _screenController = Get.put(ScreenController());
  AddKtxPostController _addKtxPostController = Get.put(AddKtxPostController());
  KtxPostController _ktxPostController = Get.put(KtxPostController());
  KtxPlaceController _ktxPlaceController = Get.put(KtxPlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  NavigationController _navController = Get.put(NavigationController());
  SignInController _signInController = Get.put(SignInController());

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOpen = false;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    _userController.getUsers();
    _ktxPostController.getPosts(
      depId: _ktxPlaceController.dep?.id,
      dstId: _ktxPlaceController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
    );
    _ktxPlaceController.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          height: 214.h,
          color: colorScheme.onBackground,
          alignment: Alignment.topCenter,
          child: Container(
            width: 390.w,
            height: 206.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff8fc0f1),
                      Color(0Xff62a6ea),
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r))),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(child: _myListView(context: context)),
          onEndDrawerChanged: (isOpen) {
            _navController.changeNavHeight(isOpen);
          },
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  _screenController.setKtxCheckScreen(false);
                },
                icon: Image.asset("assets/arrow/back_short.png",
                    color: colorScheme.primary, width: 20.w, height: 20.h)),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.r),
                child: IconButton(
                  onPressed: () {
                    _openEndDrawer();
                  },
                  icon: Image.asset(
                    "assets/button/open_menu.png",
                    color: colorScheme.background,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: GetBuilder<ScreenController>(builder: (_) {
            return Column(
              children: [
                Container(
                  height: 100.h,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 107.w,
                            alignment: Alignment.centerRight,
                            child: Text(
                                abbreviatePlaceName(
                                    _ktxPlaceController.dep?.name) ?? "출발지 전체",
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.primary)),
                          ),
                          SizedBox(
                            width: 37.0.w,
                          ),
                          Image.asset(
                            width: 102.5.w,
                            height: 16.52.h,
                            'assets/Image/DeptoDes.png',
                          ),
                          SizedBox(
                            width: 35.5.w,
                          ),
                          Container(
                            width: 107.w,
                            alignment: Alignment.centerLeft,
                            child: Text(
                                abbreviatePlaceName(
                                    _ktxPlaceController.dst?.name) ?? "도착지 전체",
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.primary)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            checkPlaceScreenBeforeDateWidget(
                                textTheme, colorScheme, -2),
                            SizedBox(
                              width: 24.w,
                            ),
                            checkPlaceScreenBeforeDateWidget(
                                textTheme, colorScheme, -1),
                            SizedBox(
                              width: 23.w,
                            ),
                            GetBuilder<DateController>(
                              builder: (_) {
                                return Container(
                                  height: 24.h,
                                  width: 74.w,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    DateFormat('MM월 dd일')
                                        .format(_dateController.pickedDate!),
                                    style: textTheme.subtitle2?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 23.w,
                            ),
                            checkPlaceScreenAfterDateWidget(
                                textTheme, colorScheme, 1),
                            SizedBox(
                              width: 24.w,
                            ),
                            checkPlaceScreenAfterDateWidget(
                                textTheme, colorScheme, 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Expanded(
                  child: Container(
                    color: colorScheme.onBackground,
                    child: GetBuilder<KtxPostController>(builder: (_) {
                      return FutureBuilder<List<KtxPost>>(
                          future: _ktxPostController.posts,
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data!.length == 0)
                              return postIsEmpty(context);
                            return RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView(
                                children: [
                                  for (int index = 0;
                                      index < snapshot.data!.length;
                                      index++)
                                    ktxPostListTile(
                                        context: context,
                                        post: snapshot.data![index])
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }

  GetBuilder<DateController> checkPlaceScreenAfterDateWidget(
      TextTheme textTheme, ColorScheme colorScheme, int difference) {
    return GetBuilder<DateController>(
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _dateController.afterKtxDate(difference);
          },
          child: Container(
            height: 24.h,
            width: 44.w,
            alignment: Alignment.center,
            child: Text(
              DateFormat('MM.d').format(
                  _dateController.pickedDate!.add(Duration(days: difference))),
              style: textTheme.bodyText1?.copyWith(
                color: Color(0xFFC5E1FD),
              ),
            ),
          ),
        );
      },
    );
  }

  GetBuilder<DateController> checkPlaceScreenBeforeDateWidget(
      TextTheme textTheme, ColorScheme colorScheme, int difference) {
    return GetBuilder<DateController>(
      builder: (_) {
        Duration diff = DateTime.now().difference(_dateController.pickedDate!.add(Duration(days: difference)));
        if (diff.inDays <= 0) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _dateController.beforeKtxDate(difference);
            },
            child: Container(
              height: 24.h,
              width: 44.w,
              alignment: Alignment.center,
              child: Text(
                DateFormat('MM.dd').format(_dateController.pickedDate!
                    .add(Duration(days: difference))),
                style: textTheme.bodyText1?.copyWith(
                  color: Color(0xFFC5E1FD),
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Container(
            height: 24.h,
            width: 44.w,
            alignment: Alignment.center,
            child: Text(
              DateFormat(' - ').format(
                  _dateController.pickedDate!.add(const Duration(days: -2))),
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.tertiary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget postIsEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 192.h,
            ),
            Text(
              '검색된 내용이 없습니다\n직접 방을 만들어 사람들을 모아보세요!',
              textAlign: TextAlign.center,
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.tertiary,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            OutlinedButton(
              onPressed: () {
                _screenController.changeKtxScreenToggleIndex(1);
                _screenController.setKtxCheckScreen(false);
              },
              style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(width: 0.01, color: colorScheme.onBackground)),
              child: Image.asset(
                height: 40.h,
                width: 178.w,
                'assets/button/go_gather_screen.png',
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _myListView({required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<UserController>(builder: (_) {
      return FutureBuilder<UserInfoList>(
          future: _userController.users,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 87.h, left: 35.w, right: 24.w),
                    child: Image(
                      image: AssetImage("assets/Image/profile.png"),
                      height: 88.w,
                      width: 88.w,
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.w, right: 24.w),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data!.name.toString()}학부생",
                              style: textTheme.headline3?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              snapshot.data!.email.toString(),
                              style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer, fontSize: 10.sp),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.to(MyInfoScreen());
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.h,
                          ),
                          color: colorScheme.tertiaryContainer,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    height: 1.5.h,
                    width: 390.w,
                    color: Color(0xE1E1E1E1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.w, right: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28.h,
                        ),
                        _settingListTile(
                          title: '공지사항',
                          nextPage: NoticeScreen(),
                          context: context,
                        ),
                        // SizedBox(
                        //   height: 32.h,
                        // ),
                        // _alarmListTile(
                        //   title: '알림',
                        //   nextPage: const AlarmScreen(),
                        //   context: context,
                        // ),
                        SizedBox(
                          height: 32.h,
                        ),
                        _settingListTile(
                          title: '버그제보',
                          nextPage: BugScreen(),
                          context: context,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        _settingListTile(
                          title: '약관',
                          nextPage: const TermOfServiceScreen(),
                          context: context,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        _settingListTile(
                          title: '버전정보 / 개발자',
                          nextPage: const VersionScreen(),
                          context: context,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        _settingListTile(
                          title: '개인정보처리방침',
                          nextPage: const PrivacyPolicyScreen(),
                          context: context,
                        ),
                        SizedBox(
                          height: 205.h,
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
                              icon: Image.asset("assets/button/logout_account.png"),
                              color: colorScheme.tertiary,
                            ),
                            GestureDetector(
                              onTap: () {
                                _logout(context: context);
                              },
                              child: Text(
                                "로그아웃",
                                style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: GestureDetector(
                  onTap: () {
                    _logout(context: context);
                  },
                  child: Text(
                    "로그아웃",
                    style: textTheme.bodyText2?.copyWith(color: colorScheme.tertiary),
                  ),
                ),
              );
            }
          });
    });
  }

  // 알림 타일
  // Widget _alarmListTile({
  //   required String title,
  //   required nextPage,
  //   required BuildContext context,
  // }) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final textTheme = Theme.of(context).textTheme;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           Get.to(nextPage);
  //         },
  //         child: Text(
  //           title,
  //           textAlign: TextAlign.start,
  //           style: textTheme.subtitle1?.copyWith(color: colorScheme.onTertiary),
  //         ),
  //       ),
  //       Spacer(),
  //       Container(
  //         height: 17.h,
  //         width: 34.w,
  //         child: Transform.scale(
  //           transformHitTests: false,
  //           scale: .6,
  //           child: CupertinoSwitch(
  //               value: _userController.alarm,
  //               activeColor: colorScheme.inverseSurface,
  //               thumbColor: colorScheme.primary,
  //               trackColor: colorScheme.tertiary,
  //               onChanged: (bool value) {
  //                 _userController.setAlarm(value);
  //               }),
  //         ),
  //       )
  //     ],
  //   );
  // }

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
}
