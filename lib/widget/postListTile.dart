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
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/snackBar.dart';
import 'package:itaxi/model/history.dart';

import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/dateController.dart';

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

  Future<bool> checkUser(int id) async {
    List<History> his = await _historyController.fetchHistorys();
    for(History history in his){
      if(history.id == id) {
        return true;
      }
    }
    return false;
  }

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () async {
      bool checkId = await checkUser(post.id!);

      if (post.joiners!.length >= post.capacity!) {
        snackBar(context: context, title: '이미 인원이 가득 찬 모집입니다.');
      } else {
        for(int i = 0; i< post.joiners!.length; i++){
          if(post.joiners![i].uid == _userController.uid){
            snackBar(context: context, title: '이미 입장한 방입니다.');
            break;
          } else if(i == post.joiners!.length -1){
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
                                  Get.to(() => const ChatRoomScreen());
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
                  DateFormat('HH:mm')
                      .format(DateTime.parse(post.deptTime!)),
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onTertiary,
                  ),
                ),
                SizedBox(
                  width: 21.w,
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
      ],
    ),
  );
}
