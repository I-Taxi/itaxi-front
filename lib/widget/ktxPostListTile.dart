import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/chat/chatRoomDetailScreen.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/snackBar.dart';

import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/dateController.dart';

import '../chat/chatRoomDetailScreen.dart';

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
                                Get.to(() => const ChatRoomDetailScreen());
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
                                Get.to(() => const ChatRoomDetailScreen());
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
    child: Column(
      children: [
        SizedBox(
          height: 1.5.h,
        ),
        GestureDetector(
          onTap: ()  {
            chatParticipation(context, "톡방에 참여하시겠어요?");
          },
          child: Container(
            height: 92.h,
            color: colorScheme.background,
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00:00",
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
                  Column(
                    children: [
                      Text(
                        "KTX",
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: Platform.isIOS ? 22 : 20,
                          color: colorScheme.onTertiary,
                        ),
                      ),
                      Text(
                        "30%",
                        style: textTheme.subtitle1?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      )
                    ],
                  ),
                  Image(
                    image: post.postType == 1 ? AssetImage("assets/type/taxi_text.png") : AssetImage("assets/type/car_text.png"),
                    width: 44.w,
                    height: 24.h,
                  ),
                  const Spacer(),
                  Text(
                    "${post.participantNum}/4명",
                    style: textTheme.subtitle1
                        ?.copyWith(color: colorScheme.onTertiary),
                  ),
                  SizedBox(
                    width: 22.w,
                  ),
                  Image(image: AssetImage("assets/arrow/arrow_forward.png", ),color: colorScheme.tertiary, width: 10.w, height: 10.h,)
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void chatParticipation(BuildContext context, String? title) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  late ScreenController _screenController = Get.find();
  late PlaceController _placeController = Get.find();
  late DateController _dateController = Get.find();
  late AddPostController _addPostController = Get.find();
  late PostController _postController = Get.find();
  late UserController _userController = Get.find();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            width: 312.w,
            height: 230.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              62.0.w,
              52.0.h,
              62.0.w,
              52.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  title as String,
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        "취소",
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        Post post = Post(
                          uid: _userController.uid,
                          postType: _screenController.mainScreenCurrentTabIndex,
                          departure: _placeController.dep,
                          destination: _placeController.dst,
                          deptTime: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          capacity: _addPostController.capacity,
                        );
                        Get.back();
                        Get.back();
                        await _addPostController.fetchAddPost(post: post);
                        await _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: _screenController.mainScreenCurrentTabIndex,
                        );
                      },
                      child: Text(
                        "확인",
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.onPrimaryContainer),
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