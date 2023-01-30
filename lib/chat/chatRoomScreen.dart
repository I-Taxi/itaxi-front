import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/widget/chatListTile.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.find();
  ScrollController _scrollController = ScrollController();
  bool isScrollDown = false;
  bool needScrollDown = false;

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 10),
    );
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            isScrollDown = false;
            needScrollDown = false;
          });
        }
        if (_scrollController.position.pixels <
            _scrollController.position.maxScrollExtent) {
          setState(() {
            needScrollDown = true;
          });
        }
      }
    });
    _chatRoomController.chats.listen((event) {
      if (_scrollController.hasClients && _scrollController.position.pixels !=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isScrollDown = true;
        });
      }
    });
    super.initState();
  }

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
            children: [
              Expanded(
                child: StreamBuilder<List<Chat>>(
                  stream: _chatRoomController.chats,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 4.h),
                          child: Stack(
                            children: [
                              ListView.builder(
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
                                                      snapshot.data![index]
                                                          .chatTime!
                                                          .toDate()),
                                                  style: textTheme.bodyText1
                                                      ?.copyWith(
                                                          color: colorScheme
                                                              .tertiary),
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
                                      snapshot.data![index].memberName == null
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                              ),
                                              child: Text(
                                                snapshot.data![index].chatData!,
                                                style: textTheme.bodyText1
                                                    ?.copyWith(
                                                  color: colorScheme.tertiary,
                                                ),
                                              ),
                                            )
                                          : chatListTile(
                                              context: context,
                                              chat: snapshot.data![index],
                                              joiners: _chatRoomController.post.joiners,
                                            ),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              ),
                              if (isScrollDown == true &&
                                  snapshot.data![snapshot.data!.length - 1]
                                          .uid !=
                                      _userController.uid)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isScrollDown = false;
                                      });
                                      _scrollDown();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        color: colorScheme.tertiary
                                            .withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            16.w, 8.h, 16.w, 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data![snapshot
                                                              .data!.length -
                                                          1]
                                                      .memberName!,
                                                  style: textTheme.subtitle1
                                                      ?.copyWith(
                                                    color: colorScheme.primary,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![snapshot
                                                              .data!.length -
                                                          1]
                                                      .chatData!,
                                                  style: textTheme.subtitle1
                                                      ?.copyWith(
                                                    color: colorScheme.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.arrow_downward_rounded,
                                              color: colorScheme.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (isScrollDown == false &&
                                  needScrollDown == true)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        needScrollDown = false;
                                      });
                                      _scrollDown();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          colorScheme.tertiary.withOpacity(0.7),
                                      child: Icon(
                                        Icons.arrow_downward_rounded,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            '아직 대화가 없습니다 :<',
                            style: textTheme.headline2?.copyWith(
                              color: colorScheme.tertiary,
                              fontFamily: 'NotoSans',
                            ),
                          ),
                        );
                      }
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.shadow,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          '에러가 발생하였습니다 :<',
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.tertiary,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                      );
                    }
                  },
                ),
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
                        child: GetBuilder<ChatRoomController>(
                          builder: (_) {
                            return TextField(
                              controller:
                                  _chatRoomController.chatTextController,
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
                          },
                        ),
                      ),
                    ),
                    GetBuilder<ChatRoomController>(
                      builder: (_) {
                        if (_chatRoomController.texting == true) {
                          return GestureDetector(
                            onTap: () async {
                              await _chatRoomController.submitChat();
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
