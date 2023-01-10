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
                    height: post.joiners![i].owner! ? 255.h : 272.h,
                    padding:
                    EdgeInsets.fromLTRB(28.0.w, 32.0.h, 28.0.w, 12.0.h),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '채팅방 안내',
                            style: textTheme.headline1?.copyWith(
                              color: colorScheme.onPrimary,
                              fontFamily: 'NotoSans',
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
                                    fontFamily: 'NotoSans',
                                  ),
                                )
                                : Text(
                                    nonOnwerInfo,
                                    style: textTheme.bodyText1?.copyWith(
                                      color: colorScheme.tertiary,
                                      fontFamily: 'NotoSans',
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
                              fontFamily: 'NotoSans',
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
                                fontFamily: 'NotoSans',
                              ),
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
                                          ? Text(
                                              '없음',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color: colorScheme
                                                          .secondary),
                                            )
                                          : Text(
                                              '없음',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.tertiary),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _addPostController.changeLuggage(1);
                                      },
                                      child: (_addPostController.luggage == 1)
                                          ? Text(
                                              '소',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color: colorScheme
                                                          .secondary),
                                            )
                                          : Text(
                                              '소',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.tertiary),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _addPostController.changeLuggage(2);
                                      },
                                      child: (_addPostController.luggage == 2)
                                          ? Text(
                                              '대',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color: colorScheme
                                                          .secondary),
                                            )
                                          : Text(
                                              '대',
                                              style: textTheme.headline2
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.tertiary),
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
    child: Container(
      width: 352.w,
      height: 80.0.h,
      margin: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 0.w, 12.h),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            offset: const Offset(1.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                style:
                    textTheme.headline2?.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(
                height: 9.0.h,
              ),
              Image.asset(
                width: 24.w,
                height: 24.h,
                'assets/participant/${post.participantNum}_2.png',
              ),
            ],
          ),
          SizedBox(
            width: 22.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    width: 10.w,
                    height: 10.h,
                    'assets/place/departure.png',
                  ),
                  SizedBox(
                    width: 12.0.w,
                  ),
                  Text(
                    '${post.departure?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0.h,
              ),
              Row(
                children: [
                  Image.asset(
                    width: 10.w,
                    height: 10.h,
                    'assets/place/destination.png',
                  ),
                  SizedBox(
                    width: 12.0.w,
                  ),
                  Text(
                    '${post.destination?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (post.largeLuggageNum != 0)
            for (int i = 0; i < post.largeLuggageNum!; i++)
              Image.asset(
                width: 24.w,
                height: 32.h,
                'assets/luggage/luggage_large.png',
              ),
          if (post.smallLuggageNum != 0)
            for (int i = 0; i < post.smallLuggageNum!; i++)
              Image.asset(
                width: 16.w,
                height: 22.h,
                'assets/luggage/luggage_small.png',
              ),
          if (post.largeLuggageNum != 0 || post.smallLuggageNum != 0)
            Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Image.asset(
                width: 7.w,
                height: 48.h,
                'assets/luggage/human.png',
              ),
            ),
        ],
      ),
    ),
  );
}
