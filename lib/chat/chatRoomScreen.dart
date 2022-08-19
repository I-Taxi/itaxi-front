import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/widget/chatListTile.dart';

class ChatRoonScreen extends StatefulWidget {
  const ChatRoonScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoonScreen> createState() => _ChatRoonScreenState();
}

class _ChatRoonScreenState extends State<ChatRoonScreen> {
  final ScrollController _scrollController = ScrollController();
  late ChatRoomController _chatRoomController = Get.find();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(microseconds: 10),
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _scrollDown();
    });
  }

  // @override
  // void dispose() {
  //   _chatRoomController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: GestureDetector(
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
                            controller: _scrollController,
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
                            controller: _chatRoomController.chatTextController,
                            cursorColor: colorScheme.shadow,
                            style: textTheme.subtitle1?.copyWith(
                              color: colorScheme.tertiary,
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
                              _scrollDown();
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
                              _scrollDown();
                            },
                            child: CircleAvatar(
                              radius: 20.h,
                              backgroundColor: colorScheme.primary,
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: colorScheme.tertiary,
                              ),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 20.h,
                              backgroundColor: colorScheme.primary,
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
