import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/screen/chatRoomDetailScreen.dart';
import 'package:itaxi/post/controller/addPostController.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/history/model/history.dart';
import 'package:itaxi/place/widget/abbreviatePlaceName.dart';

Widget chatRoomListTile({required BuildContext context, required History history}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late AddPostController _addPostController = Get.find();
  late PostController _postController = Get.find();
  HistoryController _historyController = Get.put(HistoryController());
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  String time = history.deptTime ?? 'null';
  int postId = history.id ?? 0;
  int postType = history.postType ?? -1;

  return InkWell(
    onTap: () async {
      await _historyController.getHistoryInfo(postId: postId, postType: postType);
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
    child: Container(
      width: 342.w,
      height: 88.h,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colorScheme.onBackground))),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: Row(children: [
          history.postType != 3
              ? Image.asset(
                  'assets/icon/icon-Car.png',
                  width: 56.w,
                  height: 56.h,
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  'assets/icon/icon-KTX.png',
                  width: 56.w,
                  height: 56.h,
                  fit: BoxFit.fill,
                ),
          SizedBox(
            width: 16.w,
          ),
          SizedBox(
              width: 270.w,
              child: Padding(
                  padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${abbreviatePlaceName(history.departure!.name)}-${abbreviatePlaceName(history.destination!.name)}(${DateFormat('MM/dd').format(DateTime.parse(time))})",
                              style: textTheme.subtitle2?.copyWith(
                                color: colorScheme.onTertiary,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            "${DateFormat.Hm().format(DateTime.parse(time))} 출발",
                            style: textTheme.bodyText2?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "방장: ${history.ownerName}",
                            style: textTheme.bodyText2?.copyWith(
                              color: colorScheme.tertiaryContainer,
                            ),
                          ),
                          Text(
                            "${history.participantNum}명",
                            style: textTheme.bodyText2?.copyWith(
                              color: colorScheme.tertiary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
        ]),
      ),
    ),
  );
}
