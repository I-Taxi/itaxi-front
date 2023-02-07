import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/chat/newChatroomScreen.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';

Widget chatroomListListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late AddPostController _addPostController = Get.find();
  late PostController _postController = Get.find();
  HistoryController _historyController = Get.put(HistoryController());
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  String time = post.deptTime ?? 'null';
  int postId = post.id ?? 0;

  return InkWell(
    onTap: () async {
      await _historyController.getHistoryInfo(postId: postId);
      _chatRoomController.getPost(post: post);
      _chatRoomController.getChats(post: post);
      Get.to(() => const NewChatroomScreen());
    },
    child: Container(
      width: 342.w,
      height: 88.h,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colorScheme.shadow))),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: Row(children: [
          SizedBox(
            width: 56.w,
            height: 56.h,
            child: post.postType != null
                ? Image.asset('assets/icon/icon-Car.png')
                : Image.asset('assets/icon/icon-KTX.png'),
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
                              "${AbbreviatePlaceName(post.departure!.name)}-${AbbreviatePlaceName(post.destination!.name)}(${DateFormat('Md').format(DateTime.parse(time))})",
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
                          // for (int i = 0; i < post.joiners!.length; i++)
                          //   if (post.joiners![i].owner!)
                          Text(
                            "방장: ${post.id}",
                            style: textTheme.bodyText2?.copyWith(
                              color: colorScheme.tertiaryContainer,
                            ),
                          ),
                          Text(
                            "${post.capacity}명",
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
