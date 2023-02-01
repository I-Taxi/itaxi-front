import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/snackBar.dart';

void addPostDialog({required BuildContext context}) {
  ScreenController _tabViewController = Get.find();
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.find();
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());

  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        child: Container(
          width: 360.w,
          height: 372.h,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(28.0.w, 32.0.h, 28.0.w, 12.0.h),
          child: Column(
            children: [
              GetBuilder<ScreenController>(
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _tabViewController.changeTabIndex(1);
                        },
                        child: (_tabViewController.currentTabIndex == 1)
                            ? Text(
                                DateFormat('택시').format(_dateController.pickedDate!),
                                style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                              )
                            : Text(
                                DateFormat('택시').format(_dateController.pickedDate!),
                                style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                              ),
                      ),
                      SizedBox(
                        width: 40.0.h,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _tabViewController.changeTabIndex(2);
                        },
                        child: (_tabViewController.currentTabIndex == 2)
                            ? Text(
                                DateFormat('카풀').format(_dateController.pickedDate!),
                                style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                              )
                            : Text(
                                DateFormat('카풀').format(_dateController.pickedDate!),
                                style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                              ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: 16.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 출발 설정 버튼
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      selectPlaceDialog(context: context, type: 0);
                    },
                    child: Container(
                      width: 100.w,
                      height: 32.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        border: Border.all(
                          color: colorScheme.tertiary,
                          width: 0.3,
                        ),
                      ),
                      child: GetBuilder<PlaceController>(
                        builder: (_) {
                          return _placeController.dep == null
                              ? Text(
                                  '출발',
                                  style: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                                )
                              : Text(
                                  '${_placeController.dep?.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                                );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 16.0.w,
                  ),
                  // 화살표
                  Image.asset(
                    width: 20.w,
                    height: 12.h,
                    'assets/arrow/arrow.png',
                  ),

                  SizedBox(
                    width: 16.0.w,
                  ),

                  // 도착 설정 버튼
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      selectPlaceDialog(context: context, type: 1);
                    },
                    child: Container(
                      width: 100.w,
                      height: 32.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        border: Border.all(
                          color: colorScheme.tertiary,
                          width: 0.3,
                        ),
                      ),
                      child: GetBuilder<PlaceController>(
                        builder: (context) {
                          return _placeController.dst == null
                              ? Text(
                                  '도착',
                                  style: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                                )
                              : Text(
                                  '${_placeController.dst?.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 28.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '출발일',
                    style: textTheme.headline2?.copyWith(
                      color: colorScheme.tertiary,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<DateController>(
                    builder: (_) {
                      return Text(
                        DateFormat('yyyy MM dd E').format(_dateController.pickedDate!),
                        style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                      );
                    },
                  ),
                  SizedBox(
                    width: 12.0.h,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _dateController.selectDate(context);
                    },
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: colorScheme.tertiary,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '출발시간',
                    style: textTheme.headline2?.copyWith(
                      color: colorScheme.tertiary,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<DateController>(
                    builder: (_) {
                      return Text(
                        '${_dateController.pickedTime?.hour} : ${_dateController.pickedTime?.minute}',
                        style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                      );
                    },
                  ),
                  SizedBox(
                    width: 12.0.h,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _dateController.selectTime(context);
                    },
                    child: Icon(
                      Icons.access_time,
                      color: colorScheme.tertiary,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '최대인원',
                    style: textTheme.headline2?.copyWith(
                      color: colorScheme.tertiary,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  GetBuilder<AddPostController>(
                    builder: (_) {
                      return Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeCapacity(2);
                            },
                            child: (_addPostController.capacity == 2)
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '2',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '2',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeCapacity(3);
                            },
                            child: (_addPostController.capacity == 3)
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '3',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '3',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeCapacity(4);
                            },
                            child: (_addPostController.capacity == 4)
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '4',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      '4',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '나의 짐',
                    style: textTheme.headline2?.copyWith(
                      color: colorScheme.tertiary,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  GetBuilder<AddPostController>(
                    builder: (_) {
                      return Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeLuggage(0);
                            },
                            child: (_addPostController.luggage == 0)
                                ? Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '없음',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '없음',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeLuggage(1);
                            },
                            child: (_addPostController.luggage == 1)
                                ? Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '소',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '소',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _addPostController.changeLuggage(2);
                            },
                            child: (_addPostController.luggage == 2)
                                ? Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '대',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.secondary),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      '대',
                                      style: textTheme.headline2?.copyWith(color: colorScheme.tertiary),
                                    ),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      '취소',
                      style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_tabViewController.currentTabIndex == 0) {
                        snackBar(context: context, title: '택시 또는 카풀을 선택해주세요.');
                      } else if (_placeController.dep == null) {
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
                        Post post = Post(
                            uid: _userController.uid,
                            postType: _tabViewController.currentTabIndex,
                            departure: _placeController.dep,
                            destination: _placeController.dst,
                            deptTime: _dateController.formattingDateTime(
                              _dateController.mergeDateAndTime(),
                            ),
                            capacity: _addPostController.capacity);
                        Get.back();
                        await _addPostController.fetchAddPost(post: post);
                        await _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: _tabViewController.currentTabIndex,
                        );
                      }
                    },
                    child: Text(
                      '올리기',
                      style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
