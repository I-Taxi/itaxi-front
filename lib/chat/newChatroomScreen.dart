import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:itaxi/chat/newChatListTile.dart';
import 'package:itaxi/settings/settingScreen.dart';

class NewChatroomScreen extends StatefulWidget {
  const NewChatroomScreen({super.key});

  @override
  State<NewChatroomScreen> createState() => _NewChatroomScreenState();
}

class _NewChatroomScreenState extends State<NewChatroomScreen> {
  late TextEditingController _controller;
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
    // _chatRoomController.chats.listen((event) {
    //   if (_scrollController.hasClients && _scrollController.position.pixels !=
    //       _scrollController.position.maxScrollExtent) {
    //     setState(() {
    //       isScrollDown = true;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 152.h,
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
                        "출발지-도착지 #1225(날짜)",
                        style: textTheme.headline5?.copyWith(
                            color: colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "출발/도착지",
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
                            width: 8.w,
                          ),
                          Text("포항고속버스터미널",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              ))
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
                            width: 8.w,
                          ),
                          Text("포항고속버스터미널",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              ))
                        ],
                      ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Container(
              height: 276.h,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "대화상대",
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: (Colors.yellow),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text("김형진학부생",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.call_outlined),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.email_outlined),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Text("김형진학부생",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.call_outlined),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.email_outlined),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Text("김형진학부생",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.call_outlined),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.email_outlined),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Text("김형진학부생",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                              )),
                          const Spacer(),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.call_outlined),
                          SizedBox(
                            width: 16.w,
                          ),
                          const Icon(Icons.email_outlined),
                        ],
                      ),
                    ]),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 157.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 43.h, left: 30.w),
              child: Row(children: [
                const Icon(
                  Icons.logout,
                  size: 24,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "방 나가기",
                  style: textTheme.bodySmall?.copyWith(fontSize: 13),
                )
              ]),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 44.h),
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
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "출발지-도착지 (날짜)",
                    style: textTheme.headline5?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //ScaffoldState().openDrawer();
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 9.h,
            // ),
            //Image.asset('assets/first_chat.png'),
            // SizedBox(
            //   height: 565.h,
            // ),
            SizedBox(height: 15.h),

            Text(
              "1월 24일",
              style: textTheme.bodySmall
                  ?.copyWith(color: colorScheme.shadow, fontSize: 13),
            ),
            SizedBox(
              height: 20.h,
            ),

            Padding(
              padding: EdgeInsets.only(left: 6.w, right: 6.w),
              child: Column(
                children: [
                  youChatListTile(context, "안녕하세요", true),
                  youChatListTile(context, "동해물과 백두산이?", false),
                  meChatListTile(context, "안녕하세요", true),
                  meChatListTile(context, "하느님이?", false),
                  SizedBox(height: 29.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colorScheme.shadow),
                    width: 181.w,
                    height: 24.h,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      child: Text(
                        "OOO학부생 님이 입장하셨습니다",
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  youChatListTile(context, "혹시 두명 탈 수 있나요?", true),
                ],
              ),
            ),

            SizedBox(height: 13.h),
            Padding(
              padding: EdgeInsets.only(left: 6.w, right: 6.w),
              child: TextField(
                // controller: _controller,
                cursorColor: Colors.grey[400],
                style:
                    textTheme.subtitle1?.copyWith(color: colorScheme.onPrimary),
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
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
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {},
                      color: Colors.grey[400]),
                  hintText: '',
                  hintStyle: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),

                onChanged: (text) {
                  // if (_chatRoomController
                  //     .chatTextController.text.isNotEmpty) {
                  //   _chatRoomController.changeTexting(true);
                  // } else {
                  //   _chatRoomController.changeTexting(false);
                  // }
                },
                onSubmitted: (text) {
                  // _chatRoomController.submitChat();
                  // _chatRoomController.clearTexting();
                  _scrollDown();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
