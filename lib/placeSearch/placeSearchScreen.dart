import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:io';
import 'package:intl/intl.dart';

import 'package:itaxi/screen/placeSearchController.dart';


class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  PlaceSearchController _placeSearchController = Get.put(PlaceSearchController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '몰루',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: GetBuilder<PlaceSearchController>(
          builder: (_) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _placeSearchController.changeIndex(0);
                      },
                      child: (_placeSearchController.currentIndex == 0)
                        ? selectedView(viewText: '조회', context: context) : unselectedView(viewText: '조회', context: context)
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _placeSearchController.changeIndex(1);
                        },
                        child: (_placeSearchController.currentIndex == 1)
                          ? selectedView(viewText: '모집', context: context) : unselectedView(viewText: '모집', context: context)
                    ),
                  ],
                ),
                Container(
                  width: 360.0.w,
                  height: 176.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.shadow,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.surface,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('출발지 설정');
                        },
                        child: Container(
                          width: 286.0.w,
                          height: 49.0.h,
                          alignment: Alignment.center,
                          child: Text(
                              '출발지',
                            style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('도착지 설정');
                        },
                        child: Container(
                          width: 286.0.w,
                          height: 49.0.h,
                          alignment: Alignment.center,
                          child: Text(
                            '도착지',
                            style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0.h,
                ),
                Container(
                  width: 360.0.w,
                  height: 59.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.shadow,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.surface,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('이동 수단'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.changePostType(0);
                            },
                            child: (_placeSearchController.postType == 0)
                              ? selectedTypeView(
                                  viewText: '전체',
                                  context: context
                              ) : unSelectedTypeView(
                                viewText: '전체',
                                context: context
                              )
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.changePostType(1);
                            },
                            child: (_placeSearchController.postType == 1)
                                ? selectedTypeView(
                                viewText: '택시',
                                context: context
                            ) : unSelectedTypeView(
                                viewText: '택시',
                                context: context
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.changePostType(2);
                            },
                            child: (_placeSearchController.postType == 2)
                              ? selectedTypeView(
                              viewText: '카풀',
                              context: context
                              ) : unSelectedTypeView(
                              viewText: '카풀',
                              context: context
                              ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Container(
                  width: 360.0.w,
                  height: 59.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.shadow,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.surface,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('출발 시간'),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.selectTime(context);
                            },
                            child: Text(
                              '${_placeSearchController.pickedTime.hour} : ${_placeSearchController.pickedTime.minute}',
                              style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _placeSearchController.selectDate(context);
                          },
                          child: Text(
                            DateFormat('yyyy MM dd E').format(_placeSearchController.pickedDate),
                            style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Container(
                  width: 360.0.w,
                  height: 59.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.shadow,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.surface,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _placeSearchController.decreasePeople();
                        },
                        child: Icon(Icons.remove)
                      ),
                      Text(
                        '${_placeSearchController.peopleCount}',
                        style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _placeSearchController.increasePeople();
                          },
                          child: Icon(Icons.add)
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 360.0.w,
                  height: 59.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.shadow,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.surface,
                    shape: BoxShape.rectangle,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget selectedView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: EdgeInsets.fromLTRB(20.0.w, 15.0.h, 20.0.w, 25.0.h),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorScheme.secondary,
          shape: BoxShape.rectangle,
        ),
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.primary),
        ),
      )
  );
}

Widget unselectedView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary),
        ),
      )
  );
}

Widget selectedTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
    ),
  );
}

Widget unSelectedTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
    ),
  );
}
