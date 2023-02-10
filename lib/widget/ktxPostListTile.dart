import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addKtxPostController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/chat/chatroomDetailScreen.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/widget/snackBar.dart';

import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/ktxPlaceController.dart';
import 'package:itaxi/controller/dateController.dart';

Widget ktxPostListTile({
  required BuildContext context,
  required KtxPost post,
}) {
  late AddKtxPostController _addKtxPostController = Get.find();
  late KtxPostController _ktxPostController = Get.find();
  late DateController _dateController = Get.find();
  late NavigationController _navigationController = Get.find();
  HistoryController _historyController = Get.put(HistoryController());
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late KtxPlaceController _ktxPlaceController = Get.find();

  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      if (post.joiners!.length >= post.capacity!) {
        snackBar(context: context, title: '이미 인원이 가득 찬 모집입니다.');
      } else {
        for (int i = 0; i < post.joiners!.length; i++) {
          print("${post.joiners![i].memberId} 탑승자들 member ID");
          print("${_userController.memberId} 내 member ID");
          if (post.joiners![i].memberId == _userController.memberId) {
            snackBar(context: context, title: '이미 입장한 방입니다.');
            break;
          } else if (i == post.joiners!.length - 1) {
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
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(62.w, 52.h, 62.w, 52.h),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "톡방에 참여하시겠어요?",
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
                                    style: textTheme.subtitle2?.copyWith(
                                        color: colorScheme.tertiaryContainer),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () async {
                                    await _ktxPostController.fetchJoin(ktxPost: post);
                                    await _ktxPostController.getPosts(
                                      depId: _ktxPlaceController.dep?.id,
                                      dstId: _ktxPlaceController.dst?.id,
                                      time: _dateController.formattingDateTime(
                                        _dateController.mergeDateAndTime(),
                                      ),
                                    );
                                    Get.back();
                                    await _historyController.getHistoryInfo(
                                        postId: post.id!, postType: 3); //수정 요망
                                    _historyController.history.then((value) {
                                      if (value.postType != 3) {
                                        _chatRoomController.getPost(post: value.toPost());
                                        _chatRoomController.getChats(post: value.toPost());
                                      } else {
                                        _chatRoomController.getKtxPost(ktxPost: value.toKtxPost());
                                        _chatRoomController.getKtxChats(ktxPost: value.toKtxPost());
                                      }
                                      Get.to(() => const ChatRoomDetailScreen());
                                    });
                                  },
                                  child: Text(
                                    "입장",
                                    style: textTheme.subtitle2?.copyWith(
                                        color: colorScheme.onPrimaryContainer),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      }
    },
    child: Column(
      children: [
        SizedBox(
          height: 1.5.h,
        ),
        Container(
          height: 92.h,
          color: colorScheme.background,
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onTertiary,
                  ),
                ),
                SizedBox(
                  width: 41.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "KTX",
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: Platform.isIOS ? 22 : 20,
                          color: colorScheme.onTertiary,
                        ),
                      ),
                      Text(
                        "${post.sale}%",
                        style: textTheme.subtitle2?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  "${post.participantNum}/${post.capacity}명",
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
      ],
    ),
  );
}