import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/post/controller/addKtxPostController.dart';
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/place/controller/ktxPlaceController.dart';
import 'package:itaxi/post/controller/ktxPostController.dart';
import 'package:itaxi/tools/controller/screenController.dart';
import 'package:itaxi/tools/controller/navigationController.dart';
import 'package:itaxi/post/model/ktxPost.dart';
import 'package:itaxi/tools/widget/snackBar.dart';

import 'package:itaxi/user/controller/userController.dart';

import 'package:itaxi/place/screen/ktxPlaceSearchScreen.dart';
import 'package:itaxi/place/controller/ktxPlaceSearchController.dart';
import 'package:itaxi/tools/widget/setTimeDateFormater.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/history/model/history.dart';

KtxPlaceSearchController _ktxPlaceSearchController = Get.find();
KtxPlaceController _ktxPlaceController = Get.find();
DateController _dateController = Get.find();
KtxPostController _ktxPostController = Get.find();
UserController _userController = Get.find();
AddKtxPostController _addKtxPostController = Get.find();
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
                        Get.to(() => KtxPlaceSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDep)
                          ? Text(
                              "출발지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dep!.name!,
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(1);
                        Get.to(() => KtxPlaceSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDst)
                          ? Text(
                              "도착지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dst!.name!,
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
              _ktxPlaceController.swapDepAndDst();
            },
            icon: Image.asset('assets/button/change_dep_des.png'),
            iconSize: 35,
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
                        Get.to(() => KtxPlaceSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDep)
                          ? Text(
                              "출발지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dep!.name!,
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
                  child: GetBuilder<KtxPlaceController>(builder: (_) {
                    return GestureDetector(
                      onTap: () {
                        _ktxPlaceSearchController.changeDepOrDst(1);
                        Get.to(() => KtxPlaceSearchScreen());
                      },
                      child: !(_ktxPlaceController.hasDst)
                          ? Text(
                              "도착지 입력",
                              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                            )
                          : Text(
                              _ktxPlaceController.dst!.name!,
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
              _ktxPlaceController.swapDepAndDst();
            },
            icon: Image.asset('assets/change.png'),
            iconSize: 35.sp,
            color: colorScheme.tertiary,
          ),
        ],
      ),
    ),
  );
}

Padding lookupSetTimeWidget(ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
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
              lookupDateFormater(_dateController.pickedDate),
              style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
            );
          })
        ],
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

Padding discountWidget(ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
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
                style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
              ),
              SizedBox(
                width: 60.w,
              ),
              Text(
                '${controller.sale}%',
                style: textTheme.subtitle2?.copyWith(color: colorScheme.onPrimaryContainer),
              ),
            ],
          ),
        ),
      ));
}

Padding discountActivatedWidget(ColorScheme colorScheme, ScreenController controller, TextTheme textTheme) {
  return Padding(
      padding: EdgeInsets.only(left: 23.w, right: 24.w, bottom: 8.h),
      child: Container(
        height: 113.h,
        width: 295.w,
        decoration: BoxDecoration(
          color: colorScheme.surfaceTint,
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
                      style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      '${controller.sale}%',
                      style: textTheme.subtitle2?.copyWith(color: colorScheme.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(29.w, 20.h, 28.w, 13.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () {
                    controller.setSale(15);
                  },
                  child: SizedBox(
                    height: 24.h,
                    child: Text('15%',
                        style: textTheme.subtitle2
                            ?.copyWith(color: controller.sale == 15 ? colorScheme.onSurface : colorScheme.tertiary)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.setSale(20);
                  },
                  child: SizedBox(
                    height: 24.h,
                    child: Text('20%',
                        style: textTheme.subtitle2
                            ?.copyWith(color: controller.sale == 20 ? colorScheme.onSurface : colorScheme.tertiary)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.setSale(25);
                  },
                  child: SizedBox(
                    height: 24.h,
                    child: Text('25%',
                        style: textTheme.subtitle2
                            ?.copyWith(color: controller.sale == 25 ? colorScheme.onSurface : colorScheme.tertiary)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.setSale(30);
                  },
                  child: SizedBox(
                    height: 24.h,
                    child: Text('30%',
                        style: textTheme.subtitle2
                            ?.copyWith(color: controller.sale == 30 ? colorScheme.onSurface : colorScheme.tertiary)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.setSale(35);
                  },
                  child: SizedBox(
                    height: 24.h,
                    child: Text('35%',
                        style: textTheme.subtitle2
                            ?.copyWith(color: controller.sale == 35 ? colorScheme.onSurface : colorScheme.tertiary)),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ));
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
          SizedBox(width: 76.17.w),
          IconButton(
            onPressed: () {
              controller.ktxScreenSubtractCapacity();
            },
            icon: Image.asset('assets/button/decrease_capacity.png'),
            color: (controller.capacity == 1) ? colorScheme.tertiaryContainer : colorScheme.secondary,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text("${controller.capacity}명", style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary)),
          SizedBox(
            width: 8.w,
          ),
          IconButton(
            onPressed: () {
              controller.addCapacity();
            },
            icon: Image.asset('assets/button/increase_capacity.png'),
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
        if (_ktxPlaceController.dep == null) {
          snackBar(context: context, title: '출발지를 선택해주세요.');
        } else if (_ktxPlaceController.dst == null) {
          snackBar(context: context, title: '도착지를 선택해주세요.');
        } else {
          _screenController.setKtxCheckScreen(true);
        }
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
  bool isKTXRoomExist = false;
  return GetBuilder<AddKtxPostController>(builder: (_) {
    return FutureBuilder<List<History>>(
        future: _historyController.historys,
        builder: (BuildContext context, snapshot) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _addKtxPostController.loaded ? colorScheme.onPrimaryContainer : colorScheme.tertiaryContainer,
                  minimumSize: Size(342.w, 57.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () async {
                _addKtxPostController.capacity = controller.capacity;
                _addKtxPostController.sale = controller.sale;
                if (_addKtxPostController.loaded) {
                  if (_ktxPlaceController.dep == null) {
                    snackBar(context: context, title: '출발지를 선택해주세요.');
                  } else if (_ktxPlaceController.dep!.id == -1) {
                    snackBar(context: context, title: '출발지를 다시 선택해주세요.');
                  } else if (_ktxPlaceController.dst == null) {
                    snackBar(context: context, title: '도착지를 선택해주세요.');
                  } else if (_ktxPlaceController.dst!.id == -1) {
                    snackBar(context: context, title: '도착지를 다시 선택해주세요.');
                  } else if (DateTime.now().difference(_dateController.mergeDateAndTime()).isNegative == false) {
                    snackBar(context: context, title: '출발시간을 다시 선택해주세요.');
                  } else if (_addKtxPostController.capacity == 0) {
                    snackBar(context: context, title: '최대인원을 선택해주세요.');
                  } else {
                    for (int i = snapshot.data!.length - 1; i >= 0; i--) {
                      if (DateTime.tryParse(snapshot.data![i].deptTime!)!.isAfter(DateTime.now())) {
                        if (snapshot.data![i].deptTime! ==
                                _dateController.formattingDateTime(
                                  _dateController.mergeDateAndTime(),
                                ) &&
                            snapshot.data![i].departure!.name == _ktxPlaceController.dep!.name &&
                            snapshot.data![i].destination!.name == _ktxPlaceController.dst!.name) {
                          isKTXRoomExist = true;
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
                                                  KtxPost post = KtxPost(
                                                    uid: _userController.uid,
                                                    departure: _ktxPlaceController.dep,
                                                    destination: _ktxPlaceController.dst,
                                                    deptTime: _dateController.formattingDateTime(
                                                      _dateController.mergeDateAndTime(),
                                                    ),
                                                    sale: _addKtxPostController.sale,
                                                    capacity: _addKtxPostController.capacity,
                                                  );
                                                  _navigationController.changeIndex(3);
                                                  await _addKtxPostController.fetchAddPost(ktxPost: post);
                                                  await _ktxPostController.getPosts(
                                                    depId: _ktxPlaceController.dep?.id,
                                                    dstId: _ktxPlaceController.dst?.id,
                                                    time: _dateController.formattingDateTime(
                                                      _dateController.mergeDateAndTime(),
                                                    ),
                                                  );
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
                    if (!isKTXRoomExist) {
                      KtxPost post = KtxPost(
                        uid: _userController.uid,
                        departure: _ktxPlaceController.dep,
                        destination: _ktxPlaceController.dst,
                        deptTime: _dateController.formattingDateTime(
                          _dateController.mergeDateAndTime(),
                        ),
                        sale: _addKtxPostController.sale,
                        capacity: _addKtxPostController.capacity,
                      );
                      _navigationController.changeIndex(3);
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
