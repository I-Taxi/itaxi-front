import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:numberpicker/numberpicker.dart';

void addPostDialog({required BuildContext context}) {
  AddPostController _addPostController = Get.put(AddPostController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  PostController _postController = Get.find();
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 360,
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 12.0),
          child: Column(
            children: [
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
                      padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        border: Border.all(
                          color: Colors.grey,
                          // color: colorScheme.tertiary,
                          width: 0.3,
                        ),
                      ),
                      child: GetBuilder<PlaceController>(
                        builder: (_) {
                          return _placeController.dep == null
                              ? Text(
                                  '출발',
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                )
                              : Text(
                                  '${_placeController.dep?.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                );
                        },
                      ),
                    ),
                  ),

                  const Spacer(),

                  // 화살표
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),

                  const Spacer(),

                  // 도착 설정 버튼
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      selectPlaceDialog(context: context, type: 1);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        border: Border.all(
                          color: Colors.grey,
                          // color: colorScheme.tertiary,
                          width: 0.3,
                        ),
                      ),
                      child: GetBuilder<PlaceController>(
                        builder: (context) {
                          return _placeController.dst == null
                              ? Text(
                                  '도착',
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                )
                              : Text(
                                  '${_placeController.dst?.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '출발일',
                    style: textTheme.headline2
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  const Spacer(),
                  GetBuilder<DateController>(
                    builder: (_) {
                      return Text(
                        DateFormat('yyyy MM dd E')
                            .format(_dateController.pickedDate!),
                        style: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 12.0,
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
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '출발시간',
                    style: textTheme.headline2
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  const Spacer(),
                  GetBuilder<DateController>(
                    builder: (_) {
                      return Text(
                        '${_dateController.pickedTime?.hour} : ${_dateController.pickedTime?.minute}',
                        style: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 12.0,
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
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '추가인원',
                    style: textTheme.headline2
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  StatefulBuilder(
                    builder: (_, setState) {
                      return NumberPicker(
                        value: _addPostController.capacity,
                        minValue: 0,
                        maxValue: 6,
                        step: 1,
                        itemHeight: 20,
                        itemWidth: 50,
                        itemCount: 2,
                        axis: Axis.horizontal,
                        haptics: true,
                        onChanged: (value) {
                          setState(() {
                            _addPostController.capacity = value;
                          });
                        },
                        textStyle: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                        selectedTextStyle: textTheme.headline2
                            ?.copyWith(color: colorScheme.secondary),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '나의 짐',
                    style: textTheme.headline2
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                  StatefulBuilder(
                    builder: (_, setState) {
                      return NumberPicker(
                        value: _addPostController.luggage,
                        minValue: 0,
                        maxValue: 6,
                        step: 1,
                        itemHeight: 20,
                        itemWidth: 50,
                        itemCount: 2,
                        axis: Axis.horizontal,
                        haptics: true,
                        onChanged: (value) {
                          setState(() {
                            _addPostController.luggage = value;
                          });
                        },
                        textStyle: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                        selectedTextStyle: textTheme.headline2
                            ?.copyWith(color: colorScheme.secondary),
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
                      style: textTheme.headline1
                          ?.copyWith(color: colorScheme.tertiary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      String uid = 'neo_uid';
                      Post post = Post(
                          uid: uid,
                          postType: 1,
                          departure: _placeController.dep,
                          destination: _placeController.dst,
                          deptTime: _dateController.formattingDateTime(
                              _dateController.mergeDateAndTime()),
                          capacity: _addPostController.capacity + 1,
                          luggage: _addPostController.luggage);
                      print('1');
                      _addPostController.fetchAddPost(post: post);
                      _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                              _dateController.mergeDateAndTime()));
                      Get.back();
                    },
                    child: Text(
                      '올리기',
                      style: textTheme.headline1
                          ?.copyWith(color: colorScheme.secondary),
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
