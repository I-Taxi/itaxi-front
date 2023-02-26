import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/post/controller/addKtxPostController.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/tools/controller/navigationController.dart';
import 'package:itaxi/post/controller/ktxPostController.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/chat/screen/chatRoomDetailScreen.dart';
import 'package:itaxi/post/model/ktxPost.dart';
import 'package:itaxi/tools/widget/snackBar.dart';

import 'package:itaxi/place/controller/ktxPlaceController.dart';
import 'package:itaxi/tools/controller/dateController.dart';

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
                        padding: EdgeInsets.only(top: 57.h, bottom: 52.h),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "톡방에 참여하시겠어요?",
                              style: textTheme.subtitle1
                                  ?.copyWith(color: colorScheme.secondary, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 69.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    Get.back();
                                  },
                                  child: Text(
                                    "취소",
                                    style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                                  ),
                                ),
                                SizedBox(
                                  width: 78.w,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    await _ktxPostController.fetchJoin(ktxPost: post);
                                    await _ktxPostController.getPosts(
                                      depId: _ktxPlaceController.dep?.id,
                                      dstId: _ktxPlaceController.dst?.id,
                                      time: _dateController.formattingDateTime(
                                        _dateController.mergeDateAndTime(),
                                      ),
                                    );
                                    Get.back();
                                    await _historyController.getHistorys();
                                    await _historyController.getHistoryInfo(postId: post.id!, postType: 3);
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
                                    style: textTheme.subtitle2?.copyWith(color: colorScheme.onPrimaryContainer),
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
          height: 110.h,
          decoration: BoxDecoration(
              color: colorScheme.background,
              border: Border(bottom: BorderSide(color: colorScheme.onSurfaceVariant, width: 1))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 46.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.99.r), color: const Color(0xFF617ABB)),
                              alignment: Alignment.center,
                              child: Text(
                                'KTX',
                                style: textTheme.bodyText1?.copyWith(color: colorScheme.onSecondary),
                              )),
                          // Image(image: AssetImage("assets/type/train_text.png"), width: 46.w, height: 24.h,),
                          SizedBox(
                            height: 13.h,
                          ),
                          SizedBox(
                            width: 57.w,
                            child: Text(
                              DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                              style: textTheme.subtitle1
                                  ?.copyWith(color: colorScheme.onTertiary, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage("assets/icon/discount_check.png"),
                            size: 16.2.r,
                          ),
                          // Image(image: AssetImage("assets/icon/discount_check.png"), width: 16.2.w, height: 16.2.h, color: colorScheme.onTertiary,),
                          SizedBox(
                            width: 10.69.w,
                          ),
                          Text(
                            "${post.sale}%",
                            style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                    ]),
                Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${post.participantNum}/${post.capacity}명",
                          style:
                              textTheme.subtitle1?.copyWith(color: colorScheme.onTertiary, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 22.w,
                        ),
                        Image(
                          image: AssetImage(
                            "assets/arrow/arrow_forward.png",
                          ),
                          color: colorScheme.tertiary,
                          width: 10.w,
                          height: 10.h,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
