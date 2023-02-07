import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/snackBar.dart';

import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/dateController.dart';

Widget postListTile({
  required BuildContext context,
  required Post post,
}) {
  late AddPostController _addPostController = Get.find();
  late PostController _postController = Get.find();
  late NavigationController _navigationController = Get.find();
  HistoryController _historyController = Get.put(HistoryController());
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late ScreenController _screenController = Get.find();
  late PlaceController _placeController = Get.find();
  late DateController _dateController = Get.find();

  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      String ownerInfo = '''
  ${_userController.name}님이 방장입니다.
                              
  알아두면 좋습니다.
  1. 탑승할 차량의 번호를 꼭 알려 주세요.
  2. 모일 장소를 미리 정하세요.
  3. 정산 방법을 제시하세요.
      ''';
      String nonOnwerInfo = '''
  ${_userController.name}님 환영합니다.
  
  알아두면 좋습니다.
  1. 탑승할 차량의 번호를 숙지하세요.
  2. 모일 장소를 숙지하세요.
  3. 정산 완료 시 채팅으로 꼭 기록을 
  남겨 주세요.
      ''';
      if (post.joiners!.length >= post.capacity!) {
        snackBar(context: context, title: '이미 인원이 가득 찬 모집입니다.');
      } else {
        for (int i = 0; i < post.joiners!.length; i++) {
          if (post.joiners![i].uid == _userController.uid) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  elevation: 0,
                  child: Container(
                    width: 360.w,
                    height: post.joiners![i].owner! ? 300.h : 320.h,
                    padding:
                    EdgeInsets.fromLTRB(28.0.w, 32.0.h, 28.0.w, 12.0.h),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '채팅방 안내',
                            style: textTheme.headline1?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            post.joiners![i].owner!
                                ? Text(
                                  ownerInfo,
                                  style: textTheme.bodyText1?.copyWith(
                                    color: colorScheme.tertiary,
                                  ),
                                )
                                : Text(
                                    nonOnwerInfo,
                                    style: textTheme.bodyText1?.copyWith(
                                      color: colorScheme.tertiary,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0.h,
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
                              onPressed: () async {
                                await _historyController.getHistorys();
                                _navigationController.changeIndex(0);
                                _chatRoomController.getPost(post: post);
                                _chatRoomController.getChats(post: post);
                                Get.back();
                                Get.to(() => const ChatRoomScreen());
                              },
                              child: Text(
                                '입장',
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
            break;
          } else if (i == post.joiners!.length - 1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  elevation: 0,
                  child: Container(
                    width: 360.w,
                    height: 293.h,
                    padding:
                        EdgeInsets.fromLTRB(28.0.w, 32.0.h, 28.0.w, 12.0.h),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '방 입장 안내',
                            style: textTheme.headline1?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              nonOnwerInfo,
                              style: textTheme.bodyText1?.copyWith(
                                color: colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0.h,
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
                              onPressed: () async {
                                await _postController.fetchJoin(
                                    post: post,
                                    luggage: _addPostController.luggage);
                                await _historyController.getHistorys();
                                _navigationController.changeIndex(0);
                                _chatRoomController.getPost(post: post);
                                _chatRoomController.getChats(post: post);
                                Get.back();
                                Get.to(() => const ChatRoomScreen());
                              },
                              child: Text(
                                '입장',
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
            break;
          }
        }
      }
    },
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Stack(
        children: [
          Image(
              image: AssetImage('assets/ListView_Taxi_Car.png'),
          ),
          Row(
            children: [
              Container(
                width: 150.w,
                height: 120.h,
                margin: EdgeInsets.fromLTRB(36.5.w,30.h, 64.5.w, 20.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "출발 시간",
                          style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.tertiary,
                          ),
                        ),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Text(
                          DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                          style:
                              textTheme.subtitle1?.copyWith(
                                  color: colorScheme.onPrimary,
                              ),
                        ),
                        SizedBox(
                          height: 24.0.h,
                        ),
                        Text(
                          "탑승 인원",
                          style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.tertiary
                          ),
                        ),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Text(
                          "${post.participantNum}/4명", //이 명수도 총 인원에 따라 달라짐.
                          style: textTheme.subtitle1?.copyWith(
                              color: colorScheme.onPrimary
                          ),
                        ),
                        // Image.asset(
                        //   width: 24.w,
                        //   height: 24.h,
                        //   'assets/participant/${post.participantNum}_2.png',
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: 66.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "출발일",
                          style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.tertiary
                          ),
                        ),
                        Text(
                          DateFormat('MM/dd').format(DateTime.parse(post.deptTime!)), //경유지 받아와야 함.
                          style: textTheme.subtitle1?.copyWith(
                              color: colorScheme.onPrimary
                          ),
                        ),
                        SizedBox(
                          height: 24.0.h,
                        ),
                        Text(
                          "모집유형",
                          style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.tertiary
                          ),
                        ),
                        Text(
                          post.postType == 1 ? '택시' : '카풀', //차량 유형 받아와야 함.
                          style: textTheme.subtitle1?.copyWith(
                              color: colorScheme.onPrimary
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // if (post.largeLuggageNum != 0)
                    //   for (int i = 0; i < post.largeLuggageNum!; i++)
                    //     Image.asset(
                    //       width: 24.w,
                    //       height: 32.h,
                    //       'assets/luggage/luggage_large.png',
                    //     ),
                    // if (post.smallLuggageNum != 0)
                    //   for (int i = 0; i < post.smallLuggageNum!; i++)
                    //     Image.asset(
                    //       width: 16.w,
                    //       height: 22.h,
                    //       'assets/luggage/luggage_small.png',
                    //     ),
                    // if (post.largeLuggageNum != 0 || post.smallLuggageNum != 0)
                    //   Padding(
                    //     padding: EdgeInsets.only(left: 7.w),
                    //     child: Image.asset(
                    //       width: 7.w,
                    //       height: 48.h,
                    //       'assets/luggage/human.png',
                    //     ),
                    //   ),
                  ],
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              TextButton(
                child: Text(
                  "탑승",
                  style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.primary
                  ),
                ),
                onPressed: () async {
                  Post post = Post(
                    uid: _userController.uid,
                    postType: _screenController.currentTabIndex,
                    departure: _placeController.dep,
                    destination: _placeController.dst,
                    deptTime: _dateController.formattingDateTime(
                      _dateController.mergeDateAndTime(),
                    ),
                    capacity: _addPostController.capacity,
                  );
                  Get.back();
                  await _addPostController.fetchAddPost(post: post);
                  await _postController.getPosts(
                    depId: _placeController.dep?.id,
                    dstId: _placeController.dst?.id,
                    time: _dateController.formattingDateTime(
                      _dateController.mergeDateAndTime(),
                    ),
                    postType: _screenController.currentTabIndex,
                  );
                }, // 누르면 모집창으로 넘어가도록 바꿔야 함.
              )
            ],
          ),
        ],
      ),
    ),
  );
}

