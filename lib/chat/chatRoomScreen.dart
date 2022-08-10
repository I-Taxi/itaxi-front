import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/widget/chatListTile.dart';

class ChatRoonScreen extends StatelessWidget {
  const ChatRoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    late ChatRoomController _chatRoomController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '${_chatRoomController.post.departure!.name} - ${_chatRoomController.post.destination!.name}',
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: colorScheme.tertiary,
            ),
          ),
        ),
        endDrawer: Drawer(
          width: 280.w,
          elevation: 0.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 32.h, 0.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _chatRoomController.post.postType == 1 ? '택시' : '카풀',
                  style: textTheme.headline1?.copyWith(
                    color: colorScheme.tertiary,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  DateFormat('yyyy년 MM월 dd일 E').format(
                      DateTime.parse(_chatRoomController.post.deptTime!)),
                  style: textTheme.subtitle1
                      ?.copyWith(color: colorScheme.tertiary),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(DateTime.parse(
                              _chatRoomController.post.deptTime!)),
                          style: textTheme.headline2
                              ?.copyWith(color: colorScheme.onPrimary),
                        ),
                        SizedBox(
                          height: 9.0.h,
                        ),
                        Image.asset(
                          width: 24.w,
                          height: 24.h,
                          'assets/participant/${_chatRoomController.post.participantNum}_2.png',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
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
                              '${_chatRoomController.post.departure?.name}',
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
                              '${_chatRoomController.post.destination?.name}',
                              style: textTheme.bodyText1
                                  ?.copyWith(color: colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (_chatRoomController.post.largeLuggageNum != 0)
                      for (int i = 0;
                          i < _chatRoomController.post.largeLuggageNum!;
                          i++)
                        Image.asset(
                          width: 24.w,
                          height: 32.h,
                          'assets/luggage/luggage_large.png',
                        ),
                    if (_chatRoomController.post.smallLuggageNum != 0)
                      for (int i = 0;
                          i < _chatRoomController.post.smallLuggageNum!;
                          i++)
                        Image.asset(
                          width: 16.w,
                          height: 22.h,
                          'assets/luggage/luggage_small.png',
                        ),
                    if (_chatRoomController.post.largeLuggageNum != 0 ||
                        _chatRoomController.post.smallLuggageNum != 0)
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
                SizedBox(
                  height: 12.h,
                ),
                Divider(
                  thickness: 1,
                  color: colorScheme.shadow,
                ),
                SizedBox(
                  height: 12.h,
                ),
                // for (int joiner = 0;
                //     joiner < _chatRoomController.post.joiners!.length;
                //     joiner++)
                //   Text(
                //     _chatRoomController.post.joiners!
                //         .elementAt(joiner)
                //         .memberName
                //         .toString(),
                //     style: textTheme.subtitle1?.copyWith(
                //       color: colorScheme.onPrimary,
                //     ),
                //   ),
              ],
            ),
          ),
        ),
        backgroundColor: colorScheme.background,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<List<Chat>>(
                stream: _chatRoomController.chats,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 12.h),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  if (DateTime.now()
                                          .difference(snapshot
                                              .data![index].chatTime!
                                              .toDate())
                                          .isNegative ==
                                      false)
                                    if (index == 0 ||
                                        (index - 1 > 0 &&
                                            DateTime.parse(DateFormat('yyyy-MM-dd').format(snapshot.data![index].chatTime!.toDate()))
                                                    .compareTo(DateTime.parse(
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(snapshot
                                                                .data![index - 1]
                                                                .chatTime!
                                                                .toDate()))) !=
                                                0))
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6.h,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Divider(
                                                color: colorScheme.shadow,
                                                thickness: 1,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('M월 d일 E').format(
                                                  snapshot
                                                      .data![index].chatTime!
                                                      .toDate()),
                                              style: textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme.tertiary),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: colorScheme.shadow,
                                                thickness: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  chatListTile(
                                    context: context,
                                    chat: snapshot.data![index],
                                  ),
                                ],
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Text(
                            '아직 대화가 없습니다 :<',
                            style: textTheme.headline2?.copyWith(
                              color: colorScheme.tertiary,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        ),
                      );
                    }
                  } else if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.shadow,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text(
                          '에러가 발생하였습니다 :<',
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.tertiary,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.tertiary,
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(8.w, 4.w, 8.w, 4.w),
                  padding: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 1.0,
                      color: colorScheme.shadow,
                    ),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: GetBuilder<ChatRoomController>(builder: (_) {
                            return TextField(
                              controller:
                                  _chatRoomController.chatTextController,
                              cursorColor: colorScheme.shadow,
                              style: textTheme.subtitle1?.copyWith(
                                color: colorScheme.primary,
                              ),
                              minLines: 1,
                              maxLines: 4,
                              decoration: InputDecoration.collapsed(
                                hintText: '',
                                hintStyle: textTheme.subtitle1?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                              onChanged: (text) {
                                if (_chatRoomController
                                    .chatTextController.text.isNotEmpty) {
                                  _chatRoomController.changeTexting(true);
                                } else {
                                  _chatRoomController.changeTexting(false);
                                }
                              },
                              onSubmitted: (text) {
                                _chatRoomController.submitChat();
                                _chatRoomController.clearTexting();
                              },
                            );
                          }),
                        ),
                      ),
                      GetBuilder<ChatRoomController>(
                        builder: (_) {
                          if (_chatRoomController.texting == true) {
                            return GestureDetector(
                              onTap: () {
                                _chatRoomController.submitChat();
                                _chatRoomController.clearTexting();
                              },
                              child: CircleAvatar(
                                radius: 24.h,
                                backgroundColor: colorScheme.tertiary,
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: colorScheme.primary,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 24.h,
                                backgroundColor: colorScheme.tertiary,
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: colorScheme.tertiary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
