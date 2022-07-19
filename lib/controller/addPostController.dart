import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';

class AddPostController extends GetxController {
  int capacity = 3;
  int luggage = 0;

  Future<http.Response> fetchAddPost({required Post post}) async {
    var addPostUrl = "http://203.252.99.211:8080/";
    addPostUrl = addPostUrl + 'post';

    var body = json.encode(post.toMap());

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      body: body,
    );

    return response;
  }

  void addPostDialog({required BuildContext context}) {
    PlaceController _placeController = Get.put(PlaceController());
    DateController _dateController = Get.put(DateController());
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
                        child: _placeController.dep == null
                            ? Text(
                                '출발',
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.tertiary),
                              )
                            : Text(
                                '${_placeController.dep?.name}',
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.tertiary),
                              ),
                      ),
                    ),

                    const SizedBox(
                      width: 16.0,
                    ),

                    // 화살표
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.grey,
                    ),

                    const SizedBox(
                      width: 16.0,
                    ),

                    // 도착 설정 버튼
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        selectPlaceDialog(context: context, type: 1);
                      },
                      child: Container(
                          padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            border: Border.all(
                              color: Colors.grey,
                              // color: colorScheme.tertiary,
                              width: 0.3,
                            ),
                          ),
                          child: _placeController.dst == null
                              ? Text(
                                  '도착',
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                )
                              : Text(
                                  '${_placeController.dst?.name}',
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: colorScheme.tertiary),
                                )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                Text('추가인원'),
                const SizedBox(
                  height: 20.0,
                ),
                Text('나의 짐'),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '취소',
                        style: textTheme.headline1
                            ?.copyWith(color: colorScheme.tertiary),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String uid = '1';
                        DateTime deptTime = DateTime(
                            _dateController.pickedDate!.year,
                            _dateController.pickedDate!.month,
                            _dateController.pickedDate!.day,
                            _dateController.pickedTime!.hour,
                            _dateController.pickedTime!.minute);
                        Post post = Post(
                            uid: uid,
                            departure: '한동대학교',
                            destination: '유야',
                            deptTime: DateFormat('yyyy-MM-ddTHH:mm:ss')
                                .format(deptTime),
                            capacity: capacity,
                            luggage: luggage);
                        fetchAddPost(post: post);
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
}
