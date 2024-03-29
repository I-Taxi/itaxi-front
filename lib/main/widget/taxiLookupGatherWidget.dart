import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/tools/controller/navigationController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/post/controller/addPostController.dart';
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/place/controller/placeController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/tools/controller/screenController.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/tools/widget/tabView.dart';
import 'package:itaxi/tools/widget/snackBar.dart';

import 'package:itaxi/user/controller/userController.dart';

import 'package:itaxi/place/screen/placeSearchScreen.dart';
import 'package:itaxi/place/controller/placeSearchController.dart';
import 'package:itaxi/tools/widget/setTimeDateFormater.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/history/model/history.dart';


PlaceSearchController _placeSearchController = Get.find();
PlaceController _placeController = Get.find();
DateController _dateController = Get.find();
PostController _postController = Get.find();
UserController _userController = Get.find();
AddPostController _addPostController = Get.find();
ScreenController _screenController = Get.find();
NavigationController _navigationController = Get.find();
HistoryController _historyController = Get.put(HistoryController());

Padding lookupSetDepDstWidget(ColorScheme colorScheme, TextTheme textTheme, ScreenController controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(23.w, 20.h, 24.w, 8.h),
    child: Container(
      width: 295.w,
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          Center(
            child: Image(
              image: AssetImage('assets/Image/dep-dest.png'),
              width: 23.w,
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
          Container(
            height: 118.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, bottom: 17.h),
                  child: GetBuilder<PlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () async {
                        _placeSearchController.changeDepOrDst(0);
                        _placeSearchController.changeIsLookup(true);
                        _placeSearchController.filterPlacesByIndex();
                        _placeSearchController.fetchFavoritePlace();
                        Get.to(() => PlaceSearchScreen());
                      },
                      child: (!_placeController.hasDep ||
                              _placeController.dep != null && _placeController.dep!.id == 3232)
                          ? Text(
                              "출발지 전체",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _placeController.dep!.name!,
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
                Container(
                  width: 180.w,
                  height: 1.h,
                  color: Color(0xffE1E1E1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 17.h),
                  child: GetBuilder<PlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () async {
                        _placeSearchController.changeDepOrDst(1);
                        _placeSearchController.changeIsLookup(true);
                        _placeSearchController.filterPlacesByIndex();
                        _placeSearchController.fetchFavoritePlace();
                        Get.to(() => PlaceSearchScreen());
                      },
                      child: (!_placeController.hasDst || _placeController.dst != null && _placeController.dst!.id == 3232)
                          ? Text(
                              "도착지 전체",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _placeController.dst!.name!,
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _placeController.swapDepAndDst();
            },
            icon: Image.asset('assets/button/change_dep_des.png'),
            iconSize: 36.sp,
            color: colorScheme.tertiary,
          ),
        ],
      ),
    ),
  );
}

Padding gatherSetDepDstWidget(ColorScheme colorScheme, TextTheme textTheme, ScreenController controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(23.w, 20.h, 24.w, 8.h),
    child: Container(
      width: 295.w,
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          Center(
            child: Image(
              image: AssetImage('assets/Image/dep-dest.png'),
              width: 23.w,
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
          Container(
            height: 118.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, bottom: 17.h),
                  child: GetBuilder<PlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () async {
                        _placeSearchController.changeDepOrDst(0);
                        _placeSearchController.changeIsLookup(false);
                        _placeSearchController.filterPlacesByIndex();
                        _placeSearchController.fetchFavoritePlace();
                        Get.to(() => PlaceSearchScreen());
                      },
                      child: !(_placeController.hasDep)
                          ? Text(
                              "출발지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _placeController.dep!.name!,
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
                Container(
                  width: 180.w,
                  height: 1.h,
                  color: Color(0xffE1E1E1),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 17.h),
                  child: GetBuilder<PlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () async {
                        _placeSearchController.changeDepOrDst(1);
                        _placeSearchController.changeIsLookup(false);
                        _placeSearchController.filterPlacesByIndex();
                        _placeSearchController.fetchFavoritePlace();
                        Get.to(() => PlaceSearchScreen());
                      },
                      child: !(_placeController.hasDst)
                          ? Text(
                              "도착지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _placeController.dst!.name!,
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(left: 8.w, bottom: 10.5.h),
                onPressed: () {
                  _placeController.swapDepAndDst();
                },
                icon: Image.asset('assets/button/change_dep_des.png'),
                iconSize: 36.sp,
                color: colorScheme.tertiary,
              ),
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(left: 8.w, top: 10.5.h),
                onPressed: () {
                  _placeController.changeStopOverCount(true);
                },
                icon: Image.asset('assets/button/add_place.png'),
                iconSize: 36,
                color: colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Padding gatherSetDepDstStopOverWidget(ColorScheme colorScheme, TextTheme textTheme, ScreenController controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(23.w, 20.h, 24.w, 8.h),
    child: Container(
      width: 295.w,
      height: 174.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          Center(
            child: Image(
              image: AssetImage('assets/Image/dep-stop-dest.png'),
              width: 23.w,
            ),
          ),
          SizedBox(
            width: 19.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, bottom: 17.h),
                child: GetBuilder<PlaceController>(builder: (_) {
                  return GestureDetector(
                    onTap: () async {
                      _placeSearchController.changeDepOrDst(0);
                      _placeSearchController.changeIsLookup(false);
                      _placeSearchController.filterPlacesByIndex();
                      _placeSearchController.fetchFavoritePlace();
                      Get.to(() => PlaceSearchScreen());
                    },
                    child: !(_placeController.hasDep)
                        ? Text(
                            "출발지 입력",
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                          )
                        : Text(
                            _placeController.dep!.name!,
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                          ),
                  );
                }),
              ),
              Container(
                width: 180.w,
                height: 1.h,
                color: Color(0xffE1E1E1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 16.h, bottom: 17.h),
                child: GetBuilder<PlaceController>(builder: (_) {
                  return GestureDetector(
                    onTap: () async {
                      _placeSearchController.changeDepOrDst(2);
                      _placeSearchController.changeIsLookup(false);
                      _placeSearchController.filterPlacesByIndex();
                      _placeSearchController.fetchFavoritePlace();
                      Get.to(() => PlaceSearchScreen());
                    },
                    child: !(_placeController.stopOver.isNotEmpty)
                        ? Text(
                            "경유지 입력",
                            style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiary),
                          )
                        : Text(
                            _placeController.printStopOvers(),
                            style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiary),
                          ),
                  );
                }),
              ),
              Container(
                width: 180.w,
                height: 1.h,
                color: Color(0xffE1E1E1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 16.h),
                child: GetBuilder<PlaceController>(builder: (_) {
                  return GestureDetector(
                    onTap: () async {
                      _placeSearchController.changeDepOrDst(1);
                      _placeSearchController.changeIsLookup(false);
                      _placeSearchController.filterPlacesByIndex();
                      _placeSearchController.fetchFavoritePlace();
                      Get.to(() => PlaceSearchScreen());
                    },
                    child: !(_placeController.hasDst)
                        ? Text(
                            "도착지 입력",
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                          )
                        : Text(
                            _placeController.dst!.name!,
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                          ),
                  );
                }),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(left: 8.w, bottom: 10.5.h),
                onPressed: () {
                  _placeController.swapDepAndDst();
                },
                icon: Image.asset('assets/button/change_dep_des.png'),
                iconSize: 35.sp,
                color: colorScheme.tertiary,
              ),
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(left: 8.w, top: 10.5.h, bottom: 52.h),
                onPressed: () {
                  if (_placeController.stopOver.length > 0) {
                    _placeController.popStopOver();
                  } else if (_placeController.hasStopOver) {
                    _placeController.changeStopOverCount(false);
                  }
                },
                icon: Image.asset('assets/button/delete_stopover.png'),
                iconSize: 36,
                color: colorScheme.tertiary,
              ),
            ],
            // IconButton(
            //   onPressed: () {},
            //   icon: Image.asset('assets/button/change.png'),
            //   iconSize: 32,
            //   color: colorScheme.tertiary,
            // ),
            // IconButton(
            //   onPressed: () {
            //     controller.changeStopOver(1);
            //   },
            //   icon: Image.asset('assets/button/addPlace.png'),
            //   iconSize: 32,
            //   color: colorScheme.tertiary,
            // ),
          ),
        ],
      ),
    ),
  );
}

Padding lookupSetTimeWidget(ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _dateController.selectDate(context);
      },
      child: Container(
        height: 56.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20.w,
            ),
            ImageIcon(
              AssetImage('assets/icon/calendar.png'),
              size: 24,
              color: colorScheme.tertiaryContainer,
            ),
            SizedBox(
              width: 25.w,
            ),
            GetBuilder<DateController>(builder: (_) {
              return Text(
                lookupDateFormater(_dateController.pickedDate),
                style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
              );
            })
          ],
        ),
      ),
    ),
  );
}

Padding gatherSetTimeWidget(ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _dateController.selectDate(context).then((_) => _dateController.selectTime(context));
      },
      child: Container(
        height: 56.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20.w,
            ),
            ImageIcon(
              AssetImage('assets/icon/calendar.png'),
              size: 24,
              color: colorScheme.tertiaryContainer,
            ),
            SizedBox(
              width: 25.w,
            ),
            GetBuilder<DateController>(builder: (_) {
              return Text(
                gatherDateFormater(_dateController.mergeDateAndTime()),
                style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
              );
            })
          ],
        ),
      ),
    ),
  );
}

Padding lookupSetPostTypeWidget(ColorScheme colorScheme, ScreenController controller, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
    child: Container(
      //getbuilder controller를 써야 함.
      width: 295.w,
      height: 56.59.h,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          ImageIcon(
            AssetImage('assets/logo/logo_type.png'),
            size: 24,
            color: colorScheme.tertiaryContainer,
          ),
          SizedBox(width: 74.83.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              controller.changeMainScreenTabIndex(0);
              _postController.getPosts(
                depId: _placeController.dep?.id,
                dstId: _placeController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                postType: controller.mainScreenCurrentTabIndex,
              );
            },
            child: (controller.mainScreenCurrentTabIndex == 0)
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
              controller.changeMainScreenTabIndex(1);

              _postController.getPosts(
                depId: _placeController.dep?.id,
                dstId: _placeController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                postType: controller.mainScreenCurrentTabIndex,
              );
            },
            child: (controller.mainScreenCurrentTabIndex == 1)
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
              controller.changeMainScreenTabIndex(2);
              _postController.getPosts(
                depId: _placeController.dep?.id,
                dstId: _placeController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                postType: controller.mainScreenCurrentTabIndex,
              );
            },
            child: (controller.mainScreenCurrentTabIndex == 2)
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
  );
}

Padding gatherSetPostTypeWidget(ColorScheme colorScheme, ScreenController controller, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
    child: Container(
      //getbuilder controller를 써야 함.
      width: 295.w,
      height: 56.59.h,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          ImageIcon(
            AssetImage('assets/logo/logo_type.png'),
            size: 24,
            color: colorScheme.tertiaryContainer,
          ),
          SizedBox(width: 96.83.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              controller.changeMainScreenTabIndex(1);
              _postController.getPosts(
                depId: _placeController.dep?.id,
                dstId: _placeController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                postType: controller.mainScreenCurrentTabIndex,
              );
            },
            child: (controller.mainScreenCurrentTabIndex == 1)
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
              controller.changeMainScreenTabIndex(2);
              _postController.getPosts(
                depId: _placeController.dep?.id,
                dstId: _placeController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                postType: controller.mainScreenCurrentTabIndex,
              );
            },
            child: (controller.mainScreenCurrentTabIndex == 2)
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
  );
}

Padding lookupSetCapacityWidget(ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.only(left: 23.w, right: 24.w),
    child: Container(
      height: 56.59.h,
      width: 295.w,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 19.w,
          ),
          ImageIcon(
            AssetImage('assets/icon/person.png'),
            size: 24,
            color: colorScheme.tertiaryContainer,
          ),
          SizedBox(width: 80.w),
          IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.mainScreenSubtractCapacity();
            },
            icon: Image.asset('assets/button/decrease_capacity.png'),
            iconSize: 26,
            color: (controller.capacity == 1) ? colorScheme.tertiaryContainer : colorScheme.secondary,
          ),
          SizedBox(
            width: 12.w,
          ),
          Container(
            width: 50.w,
            alignment: Alignment.center,
            child: Text("${controller.capacity}명", style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary)),
          ),
          SizedBox(
            width: 12.w,
          ),
          IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.addCapacity();
            },
            icon: Image.asset('assets/button/increase_capacity.png'),
            iconSize: 26,
            color: (controller.capacity == 4) ? colorScheme.tertiaryContainer : colorScheme.secondary,
          ),
        ],
      ),
    ),
  );
}

ElevatedButton lookupButton(TextTheme textTheme, ColorScheme colorScheme, BuildContext context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimaryContainer,
          minimumSize: Size(342.w, 57.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      onPressed: () {
        _screenController.setCheckScreen(true);
        // if (_placeController.dep == null) {
        //   snackBar(context: context, title: '출발지를 선택해주세요.');
        // } else if (_placeController.dst == null) {
        //   snackBar(context: context, title: '도착지를 선택해주세요.');
        // } else {
        //   _screenController.setCheckScreen(true);
        // }
      },
      child: Text(
        "조회하기",
        style: textTheme.subtitle2?.copyWith(
          color: colorScheme.primary,
        ),
      ));
}

GetBuilder gatherButton(
    TextTheme textTheme, ColorScheme colorScheme, ScreenController controller, BuildContext context) {
  bool isRoomExist = false;
  return GetBuilder<AddPostController>(builder: (_) {
    return FutureBuilder<List<History>>(
        future: _historyController.historys,
        builder: (BuildContext context, snapshot) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _addPostController.loaded ? colorScheme.onPrimaryContainer : colorScheme.tertiaryContainer,
                  minimumSize: Size(342.w, 57.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () async {
                _addPostController.capacity = controller.capacity;
                if (_addPostController.loaded) {
                  if (_placeController.dep == null) {
                    snackBar(context: context, title: '출발지를 선택해주세요.');
                  } else if (_placeController.dep!.id == -1) {
                    snackBar(context: context, title: '출발지를 다시 선택해주세요.');
                  } else if (_placeController.dst == null) {
                    snackBar(context: context, title: '도착지를 선택해주세요.');
                  } else if (_placeController.dst!.id == -1) {
                    snackBar(context: context, title: '도착지를 다시 선택해주세요.');
                  } else if (DateTime.now().difference(_dateController.mergeDateAndTime()).isNegative == false) {
                    snackBar(context: context, title: '출발시간을 다시 선택해주세요.');
                  } else if (_addPostController.capacity == 0) {
                    snackBar(context: context, title: '최대인원을 선택해주세요.');
                  } else {
                    for (int i = snapshot.data!.length - 1; i >= 0; i--) {
                      if (DateTime.tryParse(snapshot.data![i].deptTime!)!.isAfter(DateTime.now())) {
                        if (snapshot.data![i].deptTime! ==
                                _dateController.formattingDateTime(
                                  _dateController.mergeDateAndTime(),
                                ) &&
                            snapshot.data![i].departure!.name == _placeController.dep!.name &&
                            snapshot.data![i].destination!.name == _placeController.dst!.name) {
                          isRoomExist = true;
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0.r),
                                  ),
                                  child: Container(
                                    width: 312.w,
                                    height: 253.h,
                                    padding: EdgeInsets.fromLTRB(
                                      36.0.w,
                                      24.0.h,
                                      36.0.w,
                                      24.0.h,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "중복 오류",
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
                                              "이미 동일한 구성의 방이 존재합니다. 추가로 생성하겠습니까?",
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
                                                  Post post = Post(
                                                    uid: _userController.uid,
                                                    postType: controller.mainScreenCurrentTabIndex,
                                                    departure: _placeController.dep,
                                                    destination: _placeController.dst,
                                                    deptTime: _dateController.formattingDateTime(
                                                      _dateController.mergeDateAndTime(),
                                                    ),
                                                    capacity: _addPostController.capacity,
                                                    stopovers: _placeController.stopOver,
                                                  );

                                                  http.Response response =
                                                      await _addPostController.fetchAddPost(post: post);
                                                  if (response.statusCode == 200) {
                                                    await _postController.getPosts(
                                                      depId: _placeController.dep?.id,
                                                      dstId: _placeController.dst?.id,
                                                      time: _dateController.formattingDateTime(
                                                        _dateController.mergeDateAndTime(),
                                                      ),
                                                      postType: controller.mainScreenCurrentTabIndex,
                                                    );
                                                    _navigationController.changeIndex(3);
                                                  } else {
                                                    _addPostController.completeLoad();
                                                    // if (context.mounted) snackBar(context: context, title: '알 수 없는 에러로 방 만들기에 실패했습니다.');
                                                  }
                                                },
                                                child: Text(
                                                  "생성",
                                                  style: textTheme.subtitle2
                                                      ?.copyWith(color: colorScheme.onSecondaryContainer),
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
                    }
                    if (!isRoomExist) {
                      Post post = Post(
                        uid: _userController.uid,
                        postType: controller.mainScreenCurrentTabIndex,
                        departure: _placeController.dep,
                        destination: _placeController.dst,
                        deptTime: _dateController.formattingDateTime(
                          _dateController.mergeDateAndTime(),
                        ),
                        capacity: _addPostController.capacity,
                        stopovers: _placeController.stopOver,
                      );
                      http.Response response = await _addPostController.fetchAddPost(post: post);
                      if (response.statusCode == 200) {
                        await _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: controller.mainScreenCurrentTabIndex,
                        );
                        _navigationController.changeIndex(3);
                      } else {
                        _addPostController.completeLoad();
                        // if (context.mounted) snackBar(context: context, title: '알 수 없는 에러로 방 만들기에 실패했습니다.');
                      }
                    }
                  }
                }
              },
              child: Text(
                "방 만들기",
                style: textTheme.subtitle2?.copyWith(
                  color: colorScheme.primary,
                ),
              ));
        });
  });
}
