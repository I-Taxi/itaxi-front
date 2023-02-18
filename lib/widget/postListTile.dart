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
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/chat/chatRoomScreen_bak.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/snackBar.dart';
import 'package:itaxi/model/history.dart';

import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/chat/chatroomDetailScreen.dart';

Widget postListTile({
  required BuildContext context,
  required Post post,
}) {
  late ScreenController _screenController = Get.find();
  late PlaceController _placeController = Get.find();
  late DateController _dateController = Get.find();
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
                                style: textTheme.subtitle1?.copyWith(
                                    color: colorScheme.secondary,
                                    fontWeight: FontWeight.w500),
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
                                      style: textTheme.subtitle2?.copyWith(
                                          color: colorScheme.tertiaryContainer),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 78.w,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      await _postController.fetchJoin(
                                          post: post);
                                      await _postController.getPosts(
                                        depId: _placeController.dep?.id,
                                        dstId: _placeController.dst?.id,
                                        time:
                                            _dateController.formattingDateTime(
                                          _dateController.mergeDateAndTime(),
                                        ),
                                        postType: _screenController
                                            .mainScreenCurrentTabIndex,
                                      );
                                      Get.back();
                                      await _historyController.getHistorys();
                                      await _historyController.getHistoryInfo(
                                          postId: post.id!,
                                          postType: post.postType!);
                                      _historyController.history.then((value) {
                                        if (value.postType != 3) {
                                          _chatRoomController.getPost(
                                              post: value.toPost());
                                          _chatRoomController.getChats(
                                              post: value.toPost());
                                        } else {
                                          _chatRoomController.getKtxPost(
                                              ktxPost: value.toKtxPost());
                                          _chatRoomController.getKtxChats(
                                              ktxPost: value.toKtxPost());
                                        }
                                        Get.to(
                                            () => const ChatRoomDetailScreen());
                                      });
                                    },
                                    child: Text(
                                      "입장",
                                      style: textTheme.subtitle2?.copyWith(
                                          color:
                                              colorScheme.onPrimaryContainer),
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
            decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                    bottom: BorderSide(
                        color: colorScheme.onSurfaceVariant, width: 1))),
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.onTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
                  post.postType == 1
                      ? Container(
                          width: 44.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.9931.r),
                              color: colorScheme.secondary),
                          alignment: Alignment.center,
                          child: Text(
                            '택시',
                            style: textTheme.bodyText1
                                ?.copyWith(color: colorScheme.onSecondary),
                          ))
                      : Container(
                          width: 44.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.9931.r),
                              color: colorScheme.outline),
                          alignment: Alignment.center,
                          child: Text(
                            '카풀',
                            style: textTheme.bodyText1
                                ?.copyWith(color: colorScheme.onSecondary),
                          )),
                  // Image(
                  //   image: post.postType == 2
                  //       ? AssetImage("assets/type/taxi_text.png")
                  //       : AssetImage("assets/type/car_text.png"),
                  //   width: 44.w,
                  //   height: 24.h,
                  // ),
                  const Spacer(),
                  Text(
                    "${post.participantNum}/${post.capacity}명",
                    style: textTheme.subtitle1?.copyWith(
                        color: colorScheme.onTertiary,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 22.w,
                  ),
                  Image(
                    image: AssetImage(
                      "assets/arrow/arrow_forward.png",
                    ),
                    color: colorScheme.tertiary,
                    width: 12.w,
                    height: 12.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}
