import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:itaxi/placeSearch/placeSearchController.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/controller/navigationController.dart';

import 'package:itaxi/placeSearch/searchScreen.dart';
import 'package:itaxi/placeSearch/placeSearchWidget.dart';

import 'package:itaxi/model/place.dart';
import 'package:itaxi/model/post.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final PlaceSearchController _placeSearchController =
      Get.put(PlaceSearchController());
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.find();
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  NavigationController _navigationController = Get.find();

  Place? selectedPlace;

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
          '검색 메인',
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
                        ? selectedView(viewText: '조회', context: context)
                        : unselectedView(viewText: '조회', context: context)),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _placeSearchController.changeIndex(1);
                      },
                      child: (_placeSearchController.currentIndex == 1)
                        ? selectedView(viewText: '모집', context: context)
                        : unselectedView(viewText: '모집', context: context)),
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
                          _placeSearchController.changeDepOrDst(0);
                          Get.to(() => const SearchScreen());
                        },
                        child: Container(
                          width: 286.0.w,
                          height: 49.0.h,
                          alignment: Alignment.center,
                          child: (_placeController.dep == null)
                            ? Text(
                              '출발지',
                              style: textTheme.headline1
                                ?.copyWith(color: colorScheme.secondary),
                            )
                            : Text(
                              '${_placeController.dep?.name}',
                              style: textTheme.headline1
                                ?.copyWith(color: colorScheme.secondary),
                            ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('도착지 설정');
                          _placeSearchController.changeDepOrDst(1);
                          Get.to(() => const SearchScreen());
                        },
                        child: Container(
                          width: 286.0.w,
                          height: 49.0.h,
                          alignment: Alignment.center,
                          child: (_placeController.dst == null)
                            ? Text(
                            '도착지',
                            style: textTheme.headline1
                              ?.copyWith(color: colorScheme.secondary),
                            )
                            : Text(
                            '${_placeController.dst?.name}',
                            style: textTheme.headline1
                              ?.copyWith(color: colorScheme.secondary),
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
                                viewText: '전체', context: context)
                              : unSelectedTypeView(
                                viewText: '전체', context: context)),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.changePostType(1);
                            },
                            child: (_placeSearchController.postType == 1)
                              ? selectedTypeView(
                                viewText: '택시', context: context)
                              : unSelectedTypeView(
                                viewText: '택시', context: context),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _placeSearchController.changePostType(2);
                            },
                          child: (_placeSearchController.postType == 2)
                              ? selectedTypeView(
                                viewText: '카풀', context: context)
                              : unSelectedTypeView(
                                viewText: '카풀', context: context),
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
                  child: GetBuilder<DateController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('출발 시간'),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _dateController.selectTime(context);
                                },
                                child: Text(
                                  '${_dateController.pickedTime.hour} : ${_dateController.pickedTime.minute}',
                                  style: textTheme.headline2
                                      ?.copyWith(color: colorScheme.tertiary),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _dateController.selectDate(context);
                                },
                                child: Text(
                                  DateFormat('yyyy MM dd E')
                                      .format(_dateController.pickedDate),
                                  style: textTheme.headline2
                                      ?.copyWith(color: colorScheme.tertiary),
                                ),
                              )),
                        ],
                      );
                    },
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
                        child: Icon(Icons.remove)),
                      Text(
                        '${_placeSearchController.peopleCount}',
                        style: textTheme.headline2
                          ?.copyWith(color: colorScheme.secondary),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _placeSearchController.increasePeople();
                        },
                        child: Icon(Icons.add)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90.0.h,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    if (_placeSearchController.postType == 0) {
                      placeSearchSnackBar(context: context, title: const Text('택시 또는 카풀을 선택해주세요.'));
                    } else if (_placeController.dep == null) {
                      placeSearchSnackBar(context: context, title: const Text('출발지를 선택해주세요.'));
                    } else if (_placeController.dep!.id == -1) {
                      placeSearchSnackBar(context: context, title: const Text('출발지를 다시 선택해주세요.'));
                    } else if (_placeController.dst == null) {
                      placeSearchSnackBar(context: context, title: const Text('도착지를 선택해주세요.'));
                    } else if (_placeController.dst!.id == -1) {
                      placeSearchSnackBar(context: context, title: const Text('도착지를 다시 선택해주세요.'));
                    } else if (DateTime.now()
                        .difference(_dateController.mergeDateAndTime())
                        .isNegative ==
                        false) {
                      placeSearchSnackBar(context: context, title: const Text('출발시간을 다시 선택해주세요.'));
                    } else if (_placeSearchController.peopleCount == 0) {
                      placeSearchSnackBar(context: context, title: const Text('최대인원을 선택해주세요.'));
                    } else {
                      Post post = Post(
                          uid: _userController.uid,
                          postType: _placeSearchController.postType,
                          departure: _placeController.dep,
                          destination: _placeController.dst,
                          deptTime: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          capacity: _placeSearchController.peopleCount,
                      );
                      Get.back();
                      await _addPostController.fetchAddPost(post: post);
                      await _postController.getPosts(
                        depId: _placeController.dep?.id,
                        dstId: _placeController.dst?.id,
                        time: _dateController.formattingDateTime(
                          _dateController.mergeDateAndTime(),
                        ),
                        postType: _placeSearchController.postType,
                      );
                    }
                  },
                  child: Container(
                    width: 360.0.w,
                    height: 59.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.shadow,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: colorScheme.secondary,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

