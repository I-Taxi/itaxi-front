import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addKtxPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/ktxPlaceController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';
import 'package:itaxi/widget/snackBar.dart';

import 'package:itaxi/controller/userController.dart';

import 'package:itaxi/placeSearch/ktxSearchScreen.dart';
import 'package:itaxi/placeSearch/ktxPlaceSearchController.dart';
import 'package:itaxi/widget/postTypeToggleButton.dart';

KtxPlaceSearchController _ktxPlaceSearchController = Get.find();
KtxPlaceController _ktxPlaceController = Get.find();
DateController _dateController = Get.find();
KtxPostController _ktxPostController = Get.find();
UserController _userController = Get.find();
AddKtxPostController _addKtxPostController = Get.find();

Padding lookupSetDepDstWidget(
    ColorScheme colorScheme, TextTheme textTheme, ScreenController controller) {
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
              image: AssetImage('assets/place/dep-dest.png'),
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(0);
                        Get.to(() => KtxSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDep)
                          ? Text(
                              "출발지 입력",
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dep!.name!,
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(1);
                        Get.to(() => KtxSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDst)
                          ? Text(
                              "도착지 입력",
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dst!.name!,
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _ktxPlaceController.swapDepAndDst();
            },
            icon: Image.asset('assets/change.png'),
            iconSize: 36,
            color: colorScheme.tertiary,
          ),
        ],
      ),
    ),
  );
}

Padding gatherSetDepDstWidget(
    ColorScheme colorScheme, TextTheme textTheme, ScreenController controller) {
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
              image: AssetImage('assets/place/dep-dest.png'),
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(0);
                        Get.to(() => KtxSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDep)
                          ? Text(
                              "출발지 입력",
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dep!.name!,
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(1);
                        Get.to(() => KtxSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDst)
                          ? Text(
                              "도착지 입력",
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dst!.name!,
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _ktxPlaceController.swapDepAndDst();
            },
            icon: Image.asset('assets/change.png'),
            iconSize: 36,
            color: colorScheme.tertiary,
          ),
        ],
      ),
    ),
  );
}

Padding lookupSetTimeWidget(
    ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _dateController.selectDate(context);
            },
            child: ImageIcon(
              AssetImage('assets/icon/calendar.png'),
              size: 24,
              color: colorScheme.tertiaryContainer,
            ),
          ),
          SizedBox(
            width: 25.w,
          ),
          GetBuilder<DateController>(builder: (_) {
            return Text(
              DateFormat('MM월 dd일 (E)').format(//요일 설정 해줘야 함.
                  _dateController.pickedDate!),
              style:
                  textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
            );
          })
        ],
      ),
    ),
  );
}

Padding gatherSetTimeWidget(
    ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w, left: 23.w, bottom: 8.h),
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _dateController.selectDate(context);
            },
            child: ImageIcon(
              AssetImage('assets/icon/calendar.png'),
              size: 24,
              color: colorScheme.tertiaryContainer,
            ),
          ),
          SizedBox(
            width: 25.w,
          ),
          GetBuilder<DateController>(builder: (_) {
            return Text(
              DateFormat('MM월 dd일 (E) HH:MM').format(//요일 설정 해줘야 함.
                  _dateController.pickedDate!),
              style:
                  textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
            );
          })
        ],
      ),
    ),
  );
}

Padding discountWidget(
    ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
  return Padding(
      padding: EdgeInsets.only(left: 23.w, right: 24.w, bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          controller.toggleDiscount();
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
                AssetImage('assets/icon/discount.png'),
                size: 24,
                color: colorScheme.tertiaryContainer,
              ),
              SizedBox(
                width: 25.w,
              ),
              Text(
                '할인율',
                style: textTheme.subtitle2
                    ?.copyWith(color: colorScheme.onTertiary),
              ),
              SizedBox(
                width: 60.w,
              ),
              Text(
                '${controller.discountRate}%',
                style: textTheme.subtitle2
                    ?.copyWith(color: colorScheme.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ));
}

Padding discountActivatedWidget(
    ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
  return Padding(
      padding: EdgeInsets.only(left: 23.w, right: 24.w, bottom: 8.h),
      child: Container(
        height: 113.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: colorScheme.outline,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.toggleDiscount();
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
                      AssetImage('assets/icon/discount.png'),
                      size: 24,
                      color: colorScheme.tertiaryContainer,
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                      '할인율',
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.onTertiary),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      '${controller.discountRate}%',
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(29.w, 20.h, 28.w, 13.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setDiscountRate(15);
                      },
                      child: SizedBox(
                        height: 24.h,
                        child: Text('15%',
                            style: textTheme.subtitle2?.copyWith(
                                color: controller.discountRate == 15
                                    ? colorScheme.onSurface
                                    : colorScheme.tertiary)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setDiscountRate(20);
                      },
                      child: SizedBox(
                        height: 24.h,
                        child: Text('20%',
                            style: textTheme.subtitle2?.copyWith(
                                color: controller.discountRate == 20
                                    ? colorScheme.onSurface
                                    : colorScheme.tertiary)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setDiscountRate(25);
                      },
                      child: SizedBox(
                        height: 24.h,
                        child: Text('25%',
                            style: textTheme.subtitle2?.copyWith(
                                color: controller.discountRate == 25
                                    ? colorScheme.onSurface
                                    : colorScheme.tertiary)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setDiscountRate(30);
                      },
                      child: SizedBox(
                        height: 24.h,
                        child: Text('30%',
                            style: textTheme.subtitle2?.copyWith(
                                color: controller.discountRate == 30
                                    ? colorScheme.onSurface
                                    : colorScheme.tertiary)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setDiscountRate(35);
                      },
                      child: SizedBox(
                        height: 24.h,
                        child: Text('35%',
                            style: textTheme.subtitle2?.copyWith(
                                color: controller.discountRate == 35
                                    ? colorScheme.onSurface
                                    : colorScheme.tertiary)),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ));
}

Padding lookupSetCapacityWidget(
    ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
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
          SizedBox(width: 76.17.w),
          IconButton(
            onPressed: () {
              controller.subtractCapacity();
            },
            icon: Image.asset('assets/removeP.png'),
            color: (controller.capacity == 1)
                ? colorScheme.tertiaryContainer
                : colorScheme.secondary,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text("${controller.capacity}명",
              style:
                  textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary)),
          SizedBox(
            width: 8.w,
          ),
          IconButton(
            onPressed: () {
              controller.addCapacity();
            },
            icon: Image.asset('assets/addPerson.png'),
            color: (controller.capacity == 4)
                ? colorScheme.tertiaryContainer
                : colorScheme.secondary,
          ),
        ],
      ),
    ),
  );
}

ElevatedButton lookupButton(TextTheme textTheme, ColorScheme colorScheme) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimaryContainer,
          minimumSize: Size(342.w, 57.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      onPressed: () {
        // Get.to(CheckPlaceScreen());
      },
      child: Text(
        "조회하기",
        style: textTheme.subtitle2?.copyWith(
          color: colorScheme.primary,
        ),
      ));
}

GetBuilder gatherButton(TextTheme textTheme, ColorScheme colorScheme,
    ScreenController controller, BuildContext context) {
  return GetBuilder<AddKtxPostController>(builder: (_) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: _addKtxPostController.loaded
                ? colorScheme.onPrimaryContainer
                : colorScheme.tertiaryContainer,
            minimumSize: Size(342.w, 57.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: () async {
          _addKtxPostController.capacity = controller.capacity;
          if (_addKtxPostController.loaded) {
            if (_ktxPlaceController.dep == null) {
              snackBar(context: context, title: '출발지를 선택해주세요.');
            } else if (_ktxPlaceController.dep!.id == -1) {
              snackBar(context: context, title: '출발지를 다시 선택해주세요.');
            } else if (_ktxPlaceController.dst == null) {
              snackBar(context: context, title: '도착지를 선택해주세요.');
            } else if (_ktxPlaceController.dst!.id == -1) {
              snackBar(context: context, title: '도착지를 다시 선택해주세요.');
            } else if (DateTime.now()
                    .difference(_dateController.mergeDateAndTime())
                    .isNegative ==
                false) {
              snackBar(context: context, title: '출발시간을 다시 선택해주세요.');
            } else if (_addKtxPostController.capacity == 0) {
              snackBar(context: context, title: '최대인원을 선택해주세요.');
            } else {
              KtxPost post = KtxPost(
                uid: _userController.uid,
                departure: _ktxPlaceController.dep,
                destination: _ktxPlaceController.dst,
                deptTime: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
                capacity: _addKtxPostController.capacity,
              );
              Get.back();
              await _addKtxPostController.fetchAddPost(ktxPost: post);
              await _ktxPostController.getPosts(
                depId: _ktxPlaceController.dep?.id,
                dstId: _ktxPlaceController.dst?.id,
                time: _dateController.formattingDateTime(
                  _dateController.mergeDateAndTime(),
                ),
              );
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
}
