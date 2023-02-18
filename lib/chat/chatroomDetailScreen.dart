import 'dart:io';
import 'dart:core';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/chatDetailListTile.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/chat.dart';
import 'package:itaxi/model/history.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/model/place.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/settings/settingScreen.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';
import 'package:itaxi/widget/chatListTile.dart';
import 'package:itaxi/widget/timelineDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:itaxi/widget/showErrorDialog.dart';

class ChatRoomDetailScreen extends StatefulWidget {
  const ChatRoomDetailScreen({super.key});

  @override
  State<ChatRoomDetailScreen> createState() => _ChatRoomDetailScreenState();
}

class _ChatRoomDetailScreenState extends State<ChatRoomDetailScreen> {
  late TextEditingController _controller;
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.find();
  late PostController _postController = Get.find();
  late KtxPostController _ktxPostController = Get.put(KtxPostController());
  late HistoryController _historyController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  bool isScrollDown = false;
  bool needScrollDown = false;
  Post? currentPost = null;
  KtxPost? currentKtxPost = null;

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 10),
      );
    }
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
    String time = _chatRoomController.postType != 3
        ? _chatRoomController.post.deptTime ?? 'null'
        : _chatRoomController.ktxPost.deptTime ?? 'null';
    List<HistoryPlace?> stopovers;
    bool isOwner = false;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: GetBuilder<HistoryController>(builder: (_) {
          return FutureBuilder<History>(
            future: _historyController.history,
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  height: 134.h,
                  width: 325.w,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                  ),
                );
              }
              stopovers = snapshot.data?.stopovers ?? [];
              if (_chatRoomController.postType != 3) {
                currentPost = _chatRoomController.post;
              } else {
                currentKtxPost = _chatRoomController.ktxPost;
              }

              for (int i = 0; i < snapshot.data!.joiners!.length; i++) {
                String? checkOwner = snapshot.data!.joiners![i].uid;
                if ((checkOwner ?? '') == _userController.uid) {
                  isOwner = true;
                }
              }
              return Column(
                children: [
                  Container(
                    height: 134.h,
                    width: 325.w,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 44.h,
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _chatRoomController.postType != 3
                                      ? "${abbreviatePlaceName(_chatRoomController.post.departure!.name)}-${abbreviatePlaceName(_chatRoomController.post.destination!.name)} #${DateFormat('MMd').format(DateTime.parse(time))}"
                                      : "${abbreviatePlaceName(_chatRoomController.ktxPost.departure!.name)}-${abbreviatePlaceName(_chatRoomController.ktxPost.destination!.name)} #${DateFormat('MMd').format(DateTime.parse(time))}",
                                  style: textTheme.subtitle1?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ]),
                  ),
                  Container(
                    width: 325.w,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "출발/도착지",
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icon/location.png',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                _chatRoomController.postType != 3
                                    ? Text(
                                        _chatRoomController
                                                .post.departure!.name ??
                                            'null',
                                        style: textTheme.bodyText1?.copyWith())
                                    : Text(
                                        _chatRoomController
                                                .ktxPost.departure!.name ??
                                            'null',
                                        style: textTheme.bodyText1?.copyWith())
                              ],
                            ),
                            if (stopovers.isNotEmpty)
                              for (int i = 0; i < stopovers.length; i++)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 23.w,
                                          height: 18.h,
                                        ),
                                        Text(
                                          '경유',
                                          style: textTheme.bodyText1?.copyWith(
                                              color: colorScheme
                                                  .tertiaryContainer),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          stopovers[i]!.name ?? '',
                                          style: textTheme.bodyText1?.copyWith(
                                              color: colorScheme
                                                  .tertiaryContainer),
                                        ),
                                      ],
                                    ),
                                    if ((i + 1).isEqual(stopovers.length))
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                  ],
                                ),
                            if (stopovers.isEmpty)
                              SizedBox(
                                height: 24.h,
                              ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icon/location.png',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                _chatRoomController.postType != 3
                                    ? Text(
                                        _chatRoomController
                                                .post.destination!.name ??
                                            'null',
                                        style: textTheme.bodyText1?.copyWith())
                                    : Text(
                                        _chatRoomController
                                                .ktxPost.destination!.name ??
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
                              style: textTheme.subtitle2
                                  ?.copyWith(color: colorScheme.onTertiary),
                            ),
                            if (snapshot.hasData)
                              for (int i = 0;
                                  i < snapshot.data!.joiners!.length;
                                  i++)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Row(
                                      children: [
                                        (snapshot.data!.joiners![i].owner ??
                                                false)
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: 3.h, bottom: 3.h),
                                                child: SizedBox(
                                                  child: Icon(
                                                    Icons.star,
                                                    size: Platform.isIOS
                                                        ? 20
                                                        : 18,
                                                    color: (Colors.yellow),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                            snapshot.data!.joiners![i]
                                                    .memberName ??
                                                '',
                                            style: textTheme.bodyText1
                                                ?.copyWith()),
                                        const Spacer(),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        InkWell(
                                          child: Image.asset(
                                            'assets/icon/phone.png',
                                            width: 24.w,
                                            height: 24.h,
                                          ),
                                          onTap: () async {
                                            final Uri launchUri = Uri.parse(
                                                'tel:${snapshot.data!.joiners![i].memberPhone}');
                                            if (await canLaunchUrl(launchUri)) {
                                              await launchUrl(launchUri);
                                            } else {
                                              throw Exception('Failed call');
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        InkWell(
                                          child: Image.asset(
                                            'assets/icon/message.png',
                                            width: 24.w,
                                            height: 24.h,
                                          ),
                                          onTap: () async {
                                            final Uri launchUri = Uri.parse(
                                                'sms:${snapshot.data!.joiners![i].memberPhone}');
                                            if (await canLaunchUrl(launchUri)) {
                                              await launchUrl(launchUri);
                                            } else {
                                              throw Exception('Failed sms');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                            SizedBox(),
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
                      child: InkWell(
                        onTap: () async {
                          showExitDialog(
                              context,
                              '방 나가기',
                              '방을 나가시겠습니까?',
                              _postController,
                              _ktxPostController,
                              _historyController,
                              _chatRoomController,
                              currentPost,
                              currentKtxPost);
                        },
                        child: Row(children: [
                          Image.asset('assets/icon/icon-LogOut.png'),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "방 나가기",
                            style: textTheme.bodyText2?.copyWith(
                                color: colorScheme.tertiaryContainer),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
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
                                    _chatRoomController.postType != 3
                                        ? "${abbreviatePlaceName(_chatRoomController.post.departure!.name)}-${abbreviatePlaceName(_chatRoomController.post.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})"
                                        : "${abbreviatePlaceName(_chatRoomController.ktxPost.departure!.name)}-${abbreviatePlaceName(_chatRoomController.ktxPost.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})",
                                    style: textTheme.subtitle1?.copyWith(
                                        color: colorScheme.onTertiary,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  icon: Image.asset('assets/button/menu.png'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isFirst;
                                    List<String> korDays = [
                                      '월',
                                      '화',
                                      '수',
                                      '목',
                                      '금',
                                      '토',
                                      '일'
                                    ];

                                    if (index != 0) {
                                      final difference = snapshot
                                          .data![index].chatTime!
                                          .toDate()
                                          .difference(snapshot
                                              .data![index - 1].chatTime!
                                              .toDate());
                                      if (difference.inMinutes >= 1) {
                                        isFirst = true;
                                      } else {
                                        isFirst = false;
                                      }

                                      if (snapshot.data![index].memberId !=
                                          snapshot.data![index - 1].memberId) {
                                        isFirst = true;
                                      }
                                      if (index == 1 &&
                                          snapshot.data![0].memberId ==
                                              snapshot.data![1].memberId) {
                                        isFirst = false;
                                      }
                                    } else {
                                      isFirst = true;
                                    }
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
                                                  DateTime.parse(DateFormat('yyyy-MM-dd')
                                                              .format(snapshot
                                                                  .data![index]
                                                                  .chatTime!
                                                                  .toDate()))
                                                          .compareTo(DateTime.parse(
                                                              DateFormat('yyyy-MM-dd').format(snapshot.data![index - 1].chatTime!.toDate()))) !=
                                                      0))
                                            Column(
                                              children: [
                                                Text(
                                                  DateFormat(
                                                          'M월 d일 (${korDays[snapshot.data![index].chatTime!.toDate().weekday - 1]})')
                                                      .format(snapshot
                                                          .data![index]
                                                          .chatTime!
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
                                            ? Column(
                                                children: [
                                                  index > 0 &&
                                                          snapshot
                                                                  .data![
                                                                      index - 1]
                                                                  .memberName ==
                                                              null
                                                      ? SizedBox()
                                                      : SizedBox(
                                                          height: 21.h,
                                                        ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: colorScheme
                                                              .onBackground,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 6.h,
                                                                horizontal:
                                                                    8.w),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .chatData!,
                                                          style: textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                            color: colorScheme
                                                                .tertiaryContainer,
                                                          ),
                                                        ),
                                                      )),
                                                  index > 0 &&
                                                          snapshot
                                                                  .data![
                                                                      index - 1]
                                                                  .memberName ==
                                                              null
                                                      ? SizedBox()
                                                      : SizedBox(
                                                          height: 17.h,
                                                        )
                                                ],
                                              )
                                            : ChatDetailListTile(
                                                context: context,
                                                isFirst: isFirst,
                                                chat: snapshot.data![index],
                                                joiners: _chatRoomController
                                                            .postType !=
                                                        3
                                                    ? _chatRoomController
                                                        .post.joiners
                                                    : _chatRoomController
                                                        .ktxPost.joiners,
                                              )
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                    style: textTheme.bodyText1
                                                        ?.copyWith(
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                          .data![snapshot.data!
                                                                  .length -
                                                              1]
                                                          .chatData!,
                                                      style: textTheme.bodyText1
                                                          ?.copyWith(
                                                        color:
                                                            colorScheme.primary,
                                                      ),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 91.w,
                                                height: 27.h,
                                                child: Image.asset(
                                                    'assets/button/new_message.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (isScrollDown == false &&
                                    needScrollDown == true)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            needScrollDown = false;
                                          });
                                          _scrollDown();
                                        },
                                        child: Container(
                                          width: 91.w,
                                          height: 27.h,
                                          child: Image.asset(
                                              'assets/button/new_message.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
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
                                    _chatRoomController.postType != 3
                                        ? "${abbreviatePlaceName(_chatRoomController.post.departure!.name)}-${abbreviatePlaceName(_chatRoomController.post.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})"
                                        : "${abbreviatePlaceName(_chatRoomController.ktxPost.departure!.name)}-${abbreviatePlaceName(_chatRoomController.ktxPost.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})",
                                    style: textTheme.subtitle1?.copyWith(
                                        color: colorScheme.onTertiary,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  icon: Image.asset('assets/button/menu.png'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Container(
                              width: 342.w,
                              padding:
                                  EdgeInsets.fromLTRB(21.w, 20.h, 21.w, 22.h),
                              decoration: BoxDecoration(
                                color: colorScheme.secondary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  isOwner
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '환영합니다. ${_userController.name}님이 방장입니다.',
                                              style: textTheme.subtitle2!
                                                  .copyWith(
                                                      color:
                                                          colorScheme.primary),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              '알아두면 좋습니다.',
                                              style: textTheme.bodyText2!
                                                  .copyWith(
                                                      color:
                                                          colorScheme.primary),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '탑승할 차 번호를 꼭 알려주세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '모일 장소를 숙지하세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '정산 완료시 채팅으로 꼭 기록을 남겨 주세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${_userController.name}님 환영합니다.',
                                              style: textTheme.subtitle2!
                                                  .copyWith(
                                                      color:
                                                          colorScheme.primary),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              '알아두면 좋습니다.',
                                              style: textTheme.bodyText2!
                                                  .copyWith(
                                                      color:
                                                          colorScheme.primary),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '탑승할 차 번호를 숙지하세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '모일 장소를 숙지하세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 13,
                                                  color: colorScheme.primary,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  '정산 완료시 채팅으로 꼭 기록을 남겨 주세요.',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                          color: colorScheme
                                                              .primary),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              )),
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
                                  _chatRoomController.postType != 3
                                      ? "${abbreviatePlaceName(_chatRoomController.post.departure!.name)}-${abbreviatePlaceName(_chatRoomController.post.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})"
                                      : "${abbreviatePlaceName(_chatRoomController.ktxPost.departure!.name)}-${abbreviatePlaceName(_chatRoomController.ktxPost.destination!.name)} (${DateFormat('MMd').format(DateTime.parse(time))})",
                                  style: textTheme.subtitle1?.copyWith(
                                      color: colorScheme.onTertiary,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                },
                                icon: Image.asset('assets/button/menu.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Container(
                            width: 342.w,
                            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isOwner
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '환영합니다. ${_userController.name}님이 방장입니다.',
                                            style: textTheme.subtitle2!
                                                .copyWith(
                                                    color: colorScheme.primary),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            '알아두면 좋습니다.',
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    color: colorScheme.primary),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '탑승할 차 번호를 꼭 알려주세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '모일 장소를 숙지하세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '정산 완료시 채팅으로 꼭 기록을 남겨 주세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_userController.name}님 환영합니다.',
                                            style: textTheme.subtitle2!
                                                .copyWith(
                                                    color: colorScheme.primary),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            '알아두면 좋습니다.',
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    color: colorScheme.primary),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '탑승할 차 번호를 숙지하세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '모일 장소를 숙지하세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 13,
                                                color: colorScheme.primary,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                '정산 완료시 채팅으로 꼭 기록을 남겨 주세요.',
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                        color: colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
                            )),
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
          Align(
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
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.w, 2.h, 8.68.w, 1.68.h),
                              child: Image.asset('assets/button/send.png'),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.w, 2.h, 8.68.w, 1.68.h),
                              child: Image.asset('assets/button/send.png'),
                            ),
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
        ],
      ),
    );
  }
}

Future<dynamic> showExitDialog(
    BuildContext context,
    String? title,
    String? content,
    PostController _postController,
    KtxPostController _ktxPostController,
    HistoryController _historyController,
    ChatRoomController _chatRoomController,
    Post? post,
    KtxPost? ktxPost) async {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  late NavigationController _navController = Get.find();

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
            height: 268.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(36.w, 24.h, 36.w, 24.h),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.h,
                  child: Text(
                    title as String,
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  width: 240.w,
                  height: 99.h,
                  alignment: Alignment.topLeft,
                  child: Text(
                    content as String,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                // const Spacer(),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          if (_chatRoomController.postType != 3) {
                            await _postController.fetchOutJoin(post: post!);
                          } else {
                            await _ktxPostController.fetchOutJoin(
                                post: ktxPost!);
                          }
                          await _historyController.getHistorys();
                          Get.back();
                          Get.back();
                          _navController.changeIndex(0);
                          Get.back();
                        } catch (e) {
                          print(e);
                          Get.back();
                          Get.back();
                          showErrorDialog(context, textTheme, colorScheme, e);
                        }
                      },
                      child: Text(
                        "나가기",
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.secondary),
                      ),
                    ),
                    SizedBox(
                      width: 78.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "취소",
                        style: textTheme.subtitle2
                            ?.copyWith(color: colorScheme.tertiaryContainer),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
