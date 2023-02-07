import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/newChatListTile.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';
import 'package:itaxi/widget/chatListTile.dart';

class NewChatroomScreen extends StatefulWidget {
  const NewChatroomScreen({super.key});

  @override
  State<NewChatroomScreen> createState() => _NewChatroomScreenState();
}

class _NewChatroomScreenState extends State<NewChatroomScreen> {
  late TextEditingController _controller;
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.find();
  late HistoryController _historyController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      if (_scrollController.hasClients &&
          _scrollController.position.pixels !=
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
    String time = _chatRoomController.post.deptTime ?? 'null';

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 158.h,
              width: 325.w,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
              ),
              child: Column(children: [
                SizedBox(
                  height: 44.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 22.w, 36.h),
                  child: Row(
                    children: [
                      Text(
                        "${AbbreviatePlaceName(_chatRoomController.post.departure!.name)}-${AbbreviatePlaceName(_chatRoomController.post.destination!.name)} #${DateFormat('Md').format(DateTime.parse(time))}",
                        style: textTheme.subtitle1?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 16,
                        color: colorScheme.primary,
                      )
                    ],
                  ),
                )
              ]),
            ),
            Container(
              height: 180.h,
              width: 325.w,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "출발/도착지",
                        style: textTheme.subtitle2?.copyWith(),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                              _chatRoomController.post.departure!.name ??
                                  'null',
                              style: textTheme.bodyText1?.copyWith())
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                              _chatRoomController.post.destination!.name ??
                                  'null',
                              style: textTheme.bodyText1?.copyWith())
                        ],
                      ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "대화상대",
                        style: textTheme.subtitle2?.copyWith(),
                      ),
                      FutureBuilder<Post>(
                        future: _historyController.history,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            for (int i = 0;
                                i < snapshot.data!.joiners!.length;
                                i++) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Row(
                                    children: [
                                      (snapshot.data!.joiners![i].owner ??
                                              false)
                                          ? const Icon(
                                              Icons.star,
                                              size: 18,
                                              color: (Colors.yellow),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                          snapshot.data!.joiners![i]
                                                  .memberName ??
                                              '',
                                          style:
                                              textTheme.bodyText1?.copyWith()),
                                      const Spacer(),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Image.asset(
                                        'assets/button/phone.png',
                                        width: 24.w,
                                        height: 24.h,
                                        color: colorScheme.tertiaryContainer,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Image.asset(
                                        'assets/button/message.png',
                                        width: 24.w,
                                        height: 24.h,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                          return SizedBox();
                        },
                      ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 0.5,
            ),
            const Spacer(),
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 43.h, left: 30.w),
                child: Row(children: [
                  Image.asset('assets/icon/icon-LogOut.png'),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "방 나가기",
                    style: textTheme.bodyText2
                        ?.copyWith(color: colorScheme.tertiaryContainer),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Chat>>(
              stream: _chatRoomController.chats,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 18.w, right: 18.w, top: 44.h),
                      child: Column(
                        children: [
                          Container(
                            height: 56.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 24,
                                    color: colorScheme.tertiaryContainer,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "${AbbreviatePlaceName(_chatRoomController.post.departure!.name)}-${AbbreviatePlaceName(_chatRoomController.post.destination!.name)} (${DateFormat('Md').format(DateTime.parse(time))})",
                                    style: textTheme.subtitle1?.copyWith(
                                      color: colorScheme.onTertiary,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 24,
                                    color: colorScheme.tertiaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat('M월 d일 E').format(
                                                snapshot.data![index].chatTime!
                                                    .toDate()),
                                            style: textTheme.bodyText2
                                                ?.copyWith(
                                                    color: colorScheme
                                                        .tertiaryContainer),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      ),
                                  snapshot.data![index].memberName == null
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6.h,
                                          ),
                                          child: Text(
                                            snapshot.data![index].chatData!,
                                            style:
                                                textTheme.bodyText1?.copyWith(
                                              color: colorScheme.tertiary,
                                            ),
                                          ),
                                        )
                                      : newChatListTile(
                                          context: context,
                                          chat: snapshot.data![index],
                                          joiners:
                                              _chatRoomController.post.joiners,
                                        ),
                                ],
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                          if (isScrollDown == true &&
                              snapshot.data![snapshot.data!.length - 1].uid !=
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
                                    color:
                                        colorScheme.tertiary.withOpacity(0.7),
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
                                                  .data![
                                                      snapshot.data!.length - 1]
                                                  .memberName!,
                                              style:
                                                  textTheme.subtitle1?.copyWith(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![
                                                      snapshot.data!.length - 1]
                                                  .chatData!,
                                              style:
                                                  textTheme.subtitle1?.copyWith(
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
                          if (isScrollDown == false && needScrollDown == true)
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
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 18.w, right: 18.w, top: 44.h),
                      child: Column(
                        children: [
                          Container(
                            height: 56.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 24,
                                    color: colorScheme.tertiaryContainer,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "${_chatRoomController.post.departure!.name}-${_chatRoomController.post.destination!.name} (${DateFormat('Md').format(DateTime.parse(time))})",
                                    style: textTheme.subtitle1?.copyWith(
                                      color: colorScheme.onTertiary,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 24,
                                    color: colorScheme.tertiaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Image.asset('assets/first_chat.png'),
                        ],
                      ),
                    );
                  }
                } else if (!snapshot.hasData) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 18.w, right: 18.w, top: 44.h),
                    child: Column(
                      children: [
                        Container(
                          height: 56.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 24,
                                  color: colorScheme.tertiaryContainer,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "${_chatRoomController.post.departure!.name}-${_chatRoomController.post.destination!.name} (${DateFormat('Md').format(DateTime.parse(time))})",
                                  style: textTheme.subtitle1?.copyWith(
                                    color: colorScheme.onTertiary,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: 24,
                                  color: colorScheme.tertiaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Image.asset('assets/first_chat.png'),
                      ],
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
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6.w, 12.h, 6.w, 44.h),
                  child: TextField(
                    controller: _chatRoomController.chatTextController,
                    cursorColor: Colors.grey[400],
                    style: textTheme.subtitle1
                        ?.copyWith(color: colorScheme.onPrimary),
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: (Colors.grey[200])!),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: (Colors.grey[200])!),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      fillColor: colorScheme.onBackground,
                      suffixIcon: GetBuilder<ChatRoomController>(
                        builder: (_) {
                          if (_chatRoomController.texting == true) {
                            return GestureDetector(
                              onTap: () async {
                                await _chatRoomController.submitChat();
                                _chatRoomController.clearTexting();
                                _scrollDown();
                              },
                              child: Image.asset('assets/button/send.png'),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {},
                              child: Image.asset('assets/button/send.png'),
                            );
                          }
                        },
                      ),
                      hintText: '',
                      hintStyle: textTheme.subtitle1?.copyWith(
                        color: colorScheme.onPrimary,
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
                  ),
                )),
          ),
        ],
      ),

      // Padding(
      //   padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 44.h),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 56.h,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             IconButton(
      //               onPressed: () {
      //                 Get.back();
      //               },
      //               icon: Icon(
      //                 Icons.arrow_back_ios,
      //                 size: 24,
      //                 color: colorScheme.tertiaryContainer,
      //               ),
      //             ),
      //             Flexible(
      //               child: Text(
      //                 "${_chatRoomController.post.departure!.name}-${_chatRoomController.post.destination!.name} (${DateFormat('Md').format(DateTime.parse(time))})",
      //                 style: textTheme.subtitle1?.copyWith(
      //                   color: colorScheme.onTertiary,
      //                 ),
      //                 maxLines: 1,
      //               ),
      //             ),
      //             IconButton(
      //               onPressed: () {
      //                 _scaffoldKey.currentState!.openEndDrawer();
      //               },
      //               icon: Icon(
      //                 Icons.menu,
      //                 size: 24,
      //                 color: colorScheme.tertiaryContainer,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // SizedBox(
      //       //   height: 9.h,
      //       // ),
      //       //Image.asset('assets/first_chat.png'),
      //       SizedBox(height: 15.h),
      //       Text(
      //         "1월 24일 (화)",
      //         style: textTheme.bodyText2
      //             ?.copyWith(color: colorScheme.tertiaryContainer),
      //       ),
      //       SizedBox(
      //         height: 20.h,
      //       ),

      //       Padding(
      //         padding: EdgeInsets.only(left: 6.w, right: 6.w),
      //         child: Column(
      //           children: [
      //             youChatListTile(context, "안녕하세요", true),
      //             youChatListTile(context, "동해물과 백두산이?", false),
      //             meChatListTile(context, "안녕하세요", true),
      //             meChatListTile(context, "하느님이?", false),
      //             SizedBox(height: 21.h),
      //             Container(
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(5),
      //                   color: colorScheme.onBackground),
      //               width: 181.w,
      //               height: 24.h,
      //               child: Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      //                 child: Text(
      //                   "OOO학부생 님이 입장하셨습니다",
      //                   style: textTheme.bodyText2?.copyWith(
      //                     color: colorScheme.tertiaryContainer,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 17.h),
      //             youChatListTile(context, "혹시 두명 탈 수 있나요?", true),
      //           ],
      //         ),
      //       ),
      //       //Image.asset('assets/new_message.png'),
      //       Expanded(
      //         child: Align(
      //             alignment: FractionalOffset.bottomCenter,
      //             child: Padding(
      //               padding: EdgeInsets.fromLTRB(6.w, 12.h, 6.w, 44.h),
      //               child: TextField(
      //                 // controller: _controller,
      //                 cursorColor: Colors.grey[400],
      //                 style: textTheme.subtitle1
      //                     ?.copyWith(color: colorScheme.onPrimary),
      //                 minLines: 1,
      //                 maxLines: 4,
      //                 decoration: InputDecoration(
      //                   contentPadding: EdgeInsets.only(
      //                       top: 10.h, bottom: 10.h, left: 10.w),
      //                   filled: true,
      //                   border: InputBorder.none,
      //                   enabledBorder: OutlineInputBorder(
      //                     borderSide:
      //                         BorderSide(width: 1, color: (Colors.grey[200])!),
      //                     borderRadius: BorderRadius.circular(24),
      //                   ),
      //                   focusedBorder: OutlineInputBorder(
      //                     borderSide:
      //                         BorderSide(width: 1, color: (Colors.grey[200])!),
      //                     borderRadius: BorderRadius.circular(24),
      //                   ),
      //                   fillColor: colorScheme.onBackground,
      //                   suffixIcon: Image.asset('assets/button/send.png'),
      //                   hintText: '',
      //                   hintStyle: textTheme.subtitle1?.copyWith(
      //                     color: colorScheme.onPrimary,
      //                   ),
      //                 ),

      //                 onChanged: (text) {
      //                   if (_chatRoomController
      //                       .chatTextController.text.isNotEmpty) {
      //                     _chatRoomController.changeTexting(true);
      //                   } else {
      //                     _chatRoomController.changeTexting(false);
      //                   }
      //                 },
      //                 onSubmitted: (text) {
      //                   _chatRoomController.submitChat();
      //                   _chatRoomController.clearTexting();
      //                   _scrollDown();
      //                 },
      //               ),
      //             )),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
