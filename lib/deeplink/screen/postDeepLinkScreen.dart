import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/screen/chatRoomDetailScreen.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itaxi/deeplink/controller/dynamicLinkController.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/history/model/history.dart';
import 'package:itaxi/main/screen/home.dart';
import 'package:itaxi/place/model/place.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/post/widget/postTypeToString.dart';
import 'package:itaxi/tools/widget/showErrorDialog.dart';

class PostDeepLinkScreen extends StatefulWidget {
  PostDeepLinkScreen({Key? key}) : super(key: key);
  @override
  State<PostDeepLinkScreen> createState() => _PostDeepLinkScreenState();
}

class _PostDeepLinkScreenState extends State<PostDeepLinkScreen> {
  Container insertBordingCompleteIcon(String? time) {
    print("hi");
    if (DateTime.now().difference(DateTime.parse(time!)).isNegative == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(15.w, 0.h, 0.w, 0.h),
        child: Image.asset(
          width: 57,
          'assets/icon/boarding_complete.png',
        ),
      );
    } else {
      return Container(padding: EdgeInsets.fromLTRB(15.w, 0.h, 0.w, 0.h));
    }
  }

  double addPlaceContainerSize(double size, List<Place?>? stopovers) {
    if (stopovers != null && stopovers.isNotEmpty) {
      return size + 35.h;
    } else {
      return size;
    }
  }

  Container insertStopoverContainer({required BuildContext context, required List<Place?>? stopovers}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (stopovers != null && stopovers.isNotEmpty) {
      return Container(
        padding: EdgeInsets.fromLTRB(0.w, 11.h, 0.w, 11.h),
        width: 300.h,
        height: 48.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 22.w),
            Text('경유', style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer)),
            SizedBox(width: 16.w),
            Text('${stopovers[0]!.name}', style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiaryContainer)),
            const Spacer(),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
      );
    }
  }

  PostController _postController = Get.put(PostController());
  HistoryController _historyController = Get.put(HistoryController());
  ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  DynamicLinkController _dynamicLinkController = Get.put(DynamicLinkController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];

    WidgetsBinding.instance.addPostFrameCallback((_) => _dynamicLinkController.setDynamicStatus(false));

    return Scaffold(
        backgroundColor: colorScheme.onBackground,
        body: GetBuilder<PostController>(builder: (_) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 61.36.h, 24.w, 22.47.h),
                height: 156.47.h,
                color: colorScheme.primary,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Get.back(),
                          child: Image.asset('assets/button/close_current_page2.png'),
                        ),
                      ),
                      SizedBox(
                        height: 18.1.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '초대된 ${postTypeToString(_postController.deepLinkPost.postType)} 채팅방 정보입니다.',
                            style: textTheme.headline3?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                          insertBordingCompleteIcon(_postController.deepLinkPost.deptTime),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: addPlaceContainerSize(528.h, _postController.deepLinkPost.stopovers),
                decoration: BoxDecoration(color: colorScheme.primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                      height: 112.h,
                      color: colorScheme.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '출발일자/시간',
                            style: textTheme.subtitle2?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                DateFormat('yyyy년 MM월 dd일 (${korDays[DateTime.parse(_postController.deepLinkPost.deptTime!).weekday - 1]}) HH:mm').format(DateTime.parse(_postController.deepLinkPost.deptTime!)),
                                style: textTheme.bodyText1?.copyWith(
                                  color: colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 8.h,
                      color: colorScheme.onBackground,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                      height: addPlaceContainerSize(130.h, _postController.deepLinkPost.stopovers),
                      color: colorScheme.primary,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '출발/목적지',
                              style: textTheme.subtitle2?.copyWith(
                                color: colorScheme.onTertiary,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  width: 18.w,
                                  height: 18.h,
                                  'assets/icon/location.png',
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${_postController.deepLinkPost.departure?.name}',
                                  style: textTheme.bodyText1?.copyWith(
                                    color: colorScheme.onTertiary,
                                  ),
                                ),
                              ],
                            ),
                            insertStopoverContainer(context: context, stopovers: _postController.deepLinkPost.stopovers),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  width: 18.w,
                                  height: 18.h,
                                  'assets/icon/location.png',
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${_postController.deepLinkPost.destination?.name}',
                                  style: textTheme.bodyText1?.copyWith(
                                    color: colorScheme.onTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 8.h,
                      color: colorScheme.onBackground,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
                      height: 112.h,
                      color: colorScheme.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '탑승 인원',
                            style: textTheme.subtitle2?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                '${_postController.deepLinkPost.capacity}명 중 ${_postController.deepLinkPost.participantNum}명이 탑승하여 있습니다.',
                                style: textTheme.bodyText1?.copyWith(
                                  color: colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _postController.deepLinkPost.stopovers != null && _postController.deepLinkPost.stopovers!.isNotEmpty ? 0.53.h : 35.53.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    backgroundColor: colorScheme.secondaryContainer,
                    elevation: 1.0,
                    minimumSize: Size.fromHeight(57.h),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  // TODO: 방 입장하시겠습니까 다이얼로그 띄우기
                  onPressed: () async {
                    enterChatRecruitDialog(context: context, post: _postController.deepLinkPost);

                    await _historyController.getHistoryInfo(postId: _postController.deepLinkPost.id ?? 0, postType: _postController.deepLinkPost.postType ?? -1);
                    _historyController.history.then((value) {
                      if (value.postType != 3) {
                        _chatRoomController.getPost(post: value.toPost());
                        _chatRoomController.getChats(post: value.toPost());
                      } else {
                        _chatRoomController.getKtxPost(ktxPost: value.toKtxPost());
                        _chatRoomController.getKtxChats(ktxPost: value.toKtxPost());
                      }
                    });
                  },
                  child: Text(
                    '채팅방 입장하기',
                    style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                  ),
                ),
              ),
            ],
          );
        }));
  }

  enterChatRecruitDialog({required BuildContext context, required Post post}) async {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0.r),
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
                      style: textTheme.subtitle1?.copyWith(color: colorScheme.secondary, fontWeight: FontWeight.w500),
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
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                          ),
                        ),
                        SizedBox(
                          width: 78.w,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            try {
                              await _postController.fetchJoin(post: post);
                              Get.back();
                              await _historyController.getHistorys();
                              await _historyController.getHistoryInfo(postId: post.id!, postType: post.postType!);
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
                            } catch (e) {
                              print(e);
                              Get.back();
                              Get.back();
                              showErrorDialog(context, textTheme, colorScheme, e);
                            }
                          },
                          child: Text(
                            "입장",
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.onPrimaryContainer),
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
