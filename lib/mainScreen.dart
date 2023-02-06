import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/gatherScreen.dart';
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
import 'package:itaxi/gatherScreen.dart';
import 'package:itaxi/widget/postTypeToggleButton.dart';

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
    _placeController
        .getPlaces()
        .then((_) => _placeSearchController = Get.put(PlaceSearchController()));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<ScreenController>(builder: (controller) {
      if (controller.currentToggle == 0) {
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
                padding:
                    EdgeInsets.only(left: 24.h, top: 55.63.h, right: 26.4.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "I-TAXI",
                              style: textTheme.headline3?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                            Text(
                              "어디든지 자유롭게 이동하세요!",
                              style: textTheme.subtitle1?.copyWith(
                                color: colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          color: colorScheme.primary,
                          onPressed: () {
                            Get.to(SettingScreen());
                          },
                          icon: Icon(Icons.menu),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 58.37.h,
                    ),
                    Container(
                      height: 433.63.h,
                      width: 342.w,
                      decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(36.0)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 23.w, right: 23.w, top: 20.63.h),
                            child: postTypeToggleButton(
                                context: context, controller: controller),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(23.w, 20.h, 24.w, 8.h),
                            child: SizedBox(
                              width: 295.w,
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            'assets/place/dep-dest.png'),
                                        width: 23.w,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  SizedBox(
                                    width: 180.w,
                                    height: 120.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            _placeSearchController
                                                .changeDepOrDst(0);
                                            Get.to(() => SearchScreen());
                                          },
                                          // style: TextButton.styleFrom(fixedSize: Size(85.w, 18.h)),
                                          child: Text(
                                            "출발지 입력",
                                            style: textTheme.subtitle2
                                                ?.copyWith(
                                                    color:
                                                        colorScheme.onTertiary),
                                          ),
                                        ),
                                        Container(
                                          width: 180.w,
                                          height: 1.h,
                                          color: Color(0xffE1E1E1),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _placeSearchController
                                                .changeDepOrDst(1);
                                            Get.to(() => SearchScreen());
                                          },
                                          // style: TextButton.styleFrom(fixedSize: Size(85.w, 18.h)),
                                          child: Text(
                                            "도착지 입력",
                                            style: textTheme.subtitle2
                                                ?.copyWith(
                                                    color:
                                                        colorScheme.onTertiary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('assets/change.png'),
                                    iconSize: 36,
                                    color: colorScheme.tertiary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24.w, left: 23.w),
                            child: SizedBox(
                              height: 20.h,
                              width: 295.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _dateController.selectDate(context);
                                    },
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: 24,
                                      color: colorScheme.tertiary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    DateFormat('M월 d일, EE')
                                        .format(//요일 설정 해줘야 함.
                                            _dateController.pickedDate!),
                                    style: textTheme.subtitle2?.copyWith(
                                        color: colorScheme.onTertiary),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 24.w, left: 23.w, top: 8.h),
                            child: SizedBox(
                              //getbuilder controller를 써야 함.
                              width: 295.w,
                              height: 56.59.h,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 24,
                                    color: colorScheme.tertiary,
                                  ),
                                  SizedBox(width: 74.83.w),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _screenController.changeTabIndex(0);
                                      _postController.getPosts(
                                        depId: _placeController.dep?.id,
                                        dstId: _placeController.dst?.id,
                                        time:
                                            _dateController.formattingDateTime(
                                          _dateController.mergeDateAndTime(),
                                        ),
                                        postType:
                                            _screenController.currentTabIndex,
                                      );
                                    },
                                    child:
                                        (_screenController.currentTabIndex == 0)
                                            ? selectedTabView(
                                                viewTitle: '전체',
                                                context: context,
                                              )
                                            : unSelectedTabView(
                                                viewTitle: '전체',
                                                context: context,
                                              ),
                                  ),
                                  SizedBox(
                                    width: 16.0.w,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _screenController.changeTabIndex(1);
                                      _postController.getPosts(
                                        depId: _placeController.dep?.id,
                                        dstId: _placeController.dst?.id,
                                        time:
                                            _dateController.formattingDateTime(
                                          _dateController.mergeDateAndTime(),
                                        ),
                                        postType:
                                            _screenController.currentTabIndex,
                                      );
                                    },
                                    child:
                                        (_screenController.currentTabIndex == 1)
                                            ? selectedTabView(
                                                viewTitle: '택시',
                                                context: context,
                                              )
                                            : unSelectedTabView(
                                                viewTitle: '택시',
                                                context: context,
                                              ),
                                  ),
                                  SizedBox(
                                    width: 16.0.w,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _screenController.changeTabIndex(2);
                                      _postController.getPosts(
                                        depId: _placeController.dep?.id,
                                        dstId: _placeController.dst?.id,
                                        time:
                                            _dateController.formattingDateTime(
                                          _dateController.mergeDateAndTime(),
                                        ),
                                        postType:
                                            _screenController.currentTabIndex,
                                      );
                                    },
                                    child:
                                        (_screenController.currentTabIndex == 2)
                                            ? selectedTabView(
                                                viewTitle: '카풀',
                                                context: context,
                                              )
                                            : unSelectedTabView(
                                                viewTitle: '카풀',
                                                context: context,
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 23.w, right: 24.w, bottom: 24.82.h),
                            child: SizedBox(
                              height: 56.59.h,
                              width: 295.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  Icon(
                                    Icons.person,
                                    size: 24,
                                    color: colorScheme.tertiary,
                                  ),
                                  SizedBox(width: 76.17.w),
                                  IconButton(
                                    onPressed: () {
                                      if (personCount != 1)
                                        setState(() {
                                          personCount--;
                                        });
                                    },
                                    icon: Image.asset('assets/removeP.png'),
                                    color: (personCount == 1)
                                        ? colorScheme.tertiaryContainer
                                        : colorScheme.secondary,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text("$personCount명",
                                      style: textTheme.subtitle2?.copyWith(
                                          color: colorScheme.onTertiary)),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (personCount != 4)
                                        setState(() {
                                          personCount++;
                                        });
                                    },
                                    icon: Image.asset('assets/addPerson.png'),
                                    color: (personCount == 4)
                                        ? colorScheme.tertiaryContainer
                                        : colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          minimumSize: Size(342.w, 57.h),
                        ),
                        onPressed: () {
                          Get.to(CheckPlaceScreen());
                        },
                        child: Text(
                          "조회하기",
                          style: textTheme.subtitle2?.copyWith(
                            color: colorScheme.primary,
                          ),
                        )),
                  ],
                )),
          ],
        );
      } else {
        return GatherScreen();
      }
    });
  }
}
