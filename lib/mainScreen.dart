import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';

import 'package:itaxi/controller/userController.dart';

import 'package:itaxi/placeSearch/searchScreen.dart';
import 'package:itaxi/placeSearch/placeSearchController.dart';
import 'package:itaxi/widget/postTypeToggleButton.dart';
import 'package:itaxi/widget/mainScreenSettingWidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScreenController _screenController = Get.put(ScreenController());
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.put(PostController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  late PlaceSearchController _placeSearchController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String e = ""; // 요일 변수
  int personCount = 1; // 인원수

  @override
  void initState() {
    super.initState();
    _userController.getUsers();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
      postType: _screenController.currentTabIndex,
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
      return Stack(
        children: [
          Container(
              height: 427.h,
              decoration: BoxDecoration(
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
                                Get.to(SettingScreen());
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
                            controller.toggleHasNotice();
                          },
                          child: controller.hasNotice
                              ? Row(
                                  children: [
                                    Container(
                                      height: 44.h,
                                      decoration: BoxDecoration(
                                        color: colorScheme.surfaceVariant,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(24),
                                            bottomLeft: Radius.circular(24),
                                            bottomRight: Radius.circular(24)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.w, right: 24.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ImageIcon(
                                              AssetImage(
                                                  'assets/icon/notice_info.png'),
                                              size: 23,
                                              color: colorScheme.primary,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              "iTaxi를 이용해 주셔서 감사합니다 :)",
                                              style: textTheme.subtitle2
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container()
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
                            height: (controller.currentToggle == 1 &&
                                    !_placeController.hasStopOver)
                                ? 433.63.h
                                : 489.63.h,
                            width: 342.w,
                            decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(36.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorScheme.shadow,
                                      blurRadius: 40,
                                      offset: Offset(2, 4))
                                ]),
                            child: controller.currentToggle == 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 23.w,
                                            right: 23.w,
                                            top: 20.63.h),
                                        child: postTypeToggleButton(
                                            context: context,
                                            controller: controller),
                                      ),
                                      lookupSetDepDstWidget(
                                          colorScheme, textTheme, controller),
                                      lookupSetTimeWidget(
                                          colorScheme, context, textTheme),
                                      lookupSetPostTypeWidget(
                                          colorScheme, controller, context),
                                      lookupSetCapacityWidget(
                                          colorScheme, controller, textTheme)
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 23.w,
                                            right: 23.w,
                                            top: 20.63.h),
                                        child: postTypeToggleButton(
                                            context: context,
                                            controller: controller),
                                      ),
                                      _placeController.hasStopOver
                                          ? gatherSetDepDstStopOverWidget(
                                              colorScheme,
                                              textTheme,
                                              controller)
                                          : gatherSetDepDstWidget(colorScheme,
                                              textTheme, controller),
                                      gatherSetTimeWidget(
                                          colorScheme, context, textTheme),
                                      gatherSetPostTypeWidget(
                                          colorScheme, controller, context),
                                      lookupSetCapacityWidget(
                                          colorScheme, controller, textTheme)
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
                                  BoxShadow(
                                      color: colorScheme.shadow,
                                      blurRadius: 40,
                                      offset: Offset(2, 4))
                                ]),
                          ),
                    SizedBox(
                      height: (controller.currentToggle == 1 &&
                              !_placeController.hasStopOver)
                          ? 60.h
                          : 4.h,
                    ),
                    if (controller.mainScreenLoaded)
                      controller.currentToggle == 0
                          ? lookupButton(textTheme, colorScheme)
                          : gatherButton(
                              textTheme, colorScheme, controller, context),
                  ],
                );
              })),
        ],
      );
    });
  }
}
