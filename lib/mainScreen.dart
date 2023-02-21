import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/model/notice.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/noticeController.dart';
import 'package:itaxi/controller/userController.dart';

import 'package:itaxi/placeSearch/placeSearchController.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';
import 'package:itaxi/widget/postTypeToggleButton.dart';
import 'package:itaxi/widget/mainScreenSettingWidget.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/model/userInfoList.dart';
import 'package:itaxi/settings/bugScreen.dart';
import 'package:itaxi/settings/myInfoScreen.dart';
import 'package:itaxi/settings/noticeScreen.dart';
import 'package:itaxi/settings/privacyPolicyScreen.dart';
import 'package:itaxi/settings/termOfServiceScreen.dart';
import 'package:itaxi/settings/versionScreen.dart';
import 'package:itaxi/widget/topNoticeWidget.dart';
import '../controller/navigationController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScreenController _screenController = Get.put(ScreenController());
  PostController _postController = Get.put(PostController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  AddPostController _addPostController = Get.put(AddPostController());
  ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  NoticeController _noticeController = Get.put(NoticeController());

  late PlaceSearchController _placeSearchController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SignInController _signInController = Get.find();
  final NavigationController _navController = Get.put(NavigationController());

  static final storage = FlutterSecureStorage();

  String e = ""; // 요일 변수
  int personCount = 1; // 인원수
  bool isOpen = false;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
      postType: _screenController.mainScreenCurrentTabIndex,
    );
    _placeController.getPlaces().then((_) {
      _placeSearchController = Get.put(PlaceSearchController());
      _screenController.setMainScreenLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<ScreenController>(builder: (controller) {
      if (controller.isCheckScreen) return CheckPlaceScreen();
      return GetBuilder<NoticeController>(builder: (_) {
        return FutureBuilder<List<Notice>>(
            future: _noticeController.notices,
            builder: (context, snapshot) {
              Notice? latestNotice;
              if (snapshot.data != null) {
                latestNotice = _noticeController.getLatestNotice(snapshot.data!);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (latestNotice != null) {
                    controller.setHasNotice(true);
                  } else {
                    controller.setHasNotice(false);
                  }
                });
              }

              return Scaffold(
                key: _scaffoldKey,
                endDrawer: Drawer(child: _myListView(context: context)),
                onEndDrawerChanged: (isOpen) {
                  _navController.changeNavHeight(isOpen);
                },
                body: Stack(
                  children: [
                    Container(
                        height: 427.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/background.png'),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 24.h, top: 55.63.h, right: 26.4.w),
                        child: GetBuilder<PlaceController>(builder: (_) {
                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 31.h,
                                        child: Text(
                                          "I-TAXI",
                                          style: textTheme.headline3?.copyWith(
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        color: colorScheme.primary,
                                        onPressed: () {
                                          _openEndDrawer();
                                        },
                                        icon: Icon(Icons.menu),
                                        iconSize: 24.w,
                                      )
                                    ],
                                  ),
                                  controller.hasNotice
                                      ? SizedBox(
                                          height: 0.37.h,
                                        )
                                      : SizedBox(
                                          height: 2.37.h,
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      //controller.setHasNotice();
                                    },
                                    child: controller.hasNotice && latestNotice != null
                                        ? Row(
                                            children: [
                                              topNoticeWidget(colorScheme, textTheme, latestNotice),
                                              const Spacer()
                                            ],
                                          )
                                        : Container(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              height: 30.h,
                                              child: Text(
                                                "어디든지 부담없이 이동하세요!",
                                                style: textTheme.subtitle1?.copyWith(
                                                  color: colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                  )
                                ],
                              ),
                              controller.hasNotice
                                  ? SizedBox(
                                      height: 40.37.h,
                                    )
                                  : SizedBox(
                                      height: 52.37.h,
                                    ),
                              controller.mainScreenLoaded
                                  ? Container(
                                      height: (!_placeController.hasStopOver || controller.mainScreenCurrentToggle == 0)
                                          ? 433.63.h
                                          : 489.63.h,
                                      width: 342.w,
                                      decoration: BoxDecoration(
                                          color: colorScheme.primary,
                                          borderRadius: BorderRadius.circular(36.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: colorScheme.shadow, blurRadius: 40.r, offset: Offset(2.w, 4.h))
                                          ]),
                                      child: controller.mainScreenCurrentToggle == 0
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 20.63.h),
                                                  child: postTypeToggleButton(context: context, controller: controller),
                                                ),
                                                lookupSetDepDstWidget(colorScheme, textTheme, controller),
                                                lookupSetTimeWidget(colorScheme, context, textTheme),
                                                lookupSetPostTypeWidget(colorScheme, controller, context),
                                                lookupSetCapacityWidget(colorScheme, controller, textTheme)
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 20.63.h),
                                                  child: postTypeToggleButton(context: context, controller: controller),
                                                ),
                                                _placeController.hasStopOver
                                                    ? gatherSetDepDstStopOverWidget(colorScheme, textTheme, controller)
                                                    : gatherSetDepDstWidget(colorScheme, textTheme, controller),
                                                gatherSetTimeWidget(colorScheme, context, textTheme),
                                                gatherSetPostTypeWidget(colorScheme, controller, context),
                                                lookupSetCapacityWidget(colorScheme, controller, textTheme)
                                              ],
                                            ),
                                    )
                                  : Container(
                                      height: 433.63.h,
                                      width: 342.w,
                                      decoration: BoxDecoration(
                                          color: colorScheme.primary,
                                          borderRadius: BorderRadius.circular(36.0),
                                          boxShadow: [
                                            BoxShadow(color: colorScheme.shadow, blurRadius: 40, offset: Offset(2, 4))
                                          ]),
                                    ),
                              SizedBox(
                                height: (!_placeController.hasStopOver || controller.mainScreenCurrentToggle == 0)
                                    ? 60.h
                                    : 4.h,
                              ),
                              if (controller.mainScreenLoaded)
                                controller.mainScreenCurrentToggle == 0
                                    ? lookupButton(textTheme, colorScheme, context)
                                    : gatherButton(textTheme, colorScheme, controller, context),
                            ],
                          );
                        })),
                  ],
                ),
              );
            });
      });
    });
  }

  Widget _myListView({required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<UserController>(builder: (_) {
      return FutureBuilder<UserInfoList>(
          future: _userController.users,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 87.h, left: 35.w, right: 24.w),
                    child: Image(
                      image: AssetImage("assets/profile.png"),
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
                              style:
                                  textTheme.bodyText2?.copyWith(color: colorScheme.tertiaryContainer, fontSize: 10.sp),
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
                              icon: Image.asset("assets/logout.png"),
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
                          await storage.delete(key: "login");
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
