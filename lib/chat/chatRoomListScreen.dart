import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/model/history.dart';
import 'package:itaxi/widget/chatroomListListTile.dart';

class ChatroomListScreen extends StatefulWidget {
  const ChatroomListScreen({super.key});

  @override
  State<ChatroomListScreen> createState() => _ChatroomListScreenState();
}

class _ChatroomListScreenState extends State<ChatroomListScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    PostController _postController = Get.put(PostController());
    DateController _dateController = Get.put(DateController());
    UserController _userController = Get.put(UserController());
    HistoryController _historyController = Get.put(HistoryController());
    final NavigationController _navController = Get.put(NavigationController());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: colorScheme.tertiary,
        backgroundColor: colorScheme.background,
        strokeWidth: 2.0,
        onRefresh: () async {
          await _historyController.getHistorys();
        },
        child: GetBuilder<HistoryController>(builder: (_) {
          return FutureBuilder<List<History>>(
            future: _historyController.historys,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                // history가 있을 때
                if (snapshot.data!.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(left: 24.w, top: 55.h, right: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "채팅",
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.onTertiary,
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Container(
                            width: 342.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/banner.png',
                                  width: 342.w,
                                  height: 75.h,
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 7.w, bottom: 5.h),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset('assets/button/contact.png'),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 13.h,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                "탑승 예정 톡방",
                                style: textTheme.bodyText2?.copyWith(
                                  color: colorScheme.tertiaryContainer,
                                ),
                              ),
                              // if deptTime is later than current time
                              for (int i = snapshot.data!.length - 1; i >= 0; i--)
                                if (DateTime.tryParse(snapshot.data![i].deptTime!)!.isAfter(DateTime.now()))
                                  chatroomListListTile(
                                    context: context,
                                    history: snapshot.data![i],
                                  ),
                              SizedBox(
                                height: 29.h,
                              ),
                              Text(
                                "전체 톡방 내역",
                                style: textTheme.bodyText2?.copyWith(
                                  color: colorScheme.tertiaryContainer,
                                ),
                              ),
                              // if deptTime is earlier than current time
                              for (int i = snapshot.data!.length - 1; i >= 0; i--)
                                if (DateTime.tryParse(snapshot.data![i].deptTime!)!.isBefore(DateTime.now()))
                                  chatroomListListTile(
                                    context: context,
                                    history: snapshot.data![i],
                                  ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  );
                }

                // history가 없을 때
                else {
                  return Padding(
                    padding: EdgeInsets.only(left: 24.w, top: 55.h, right: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "채팅",
                            style: textTheme.headline2?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Container(
                            width: 342.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                Image.asset('assets/banner.png'),
                                Padding(
                                  padding: EdgeInsets.only(right: 7.w, bottom: 5.h),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset('assets/button/contact.png'),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 13.h,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '아직 입장한 톡방이 없습니다\n방을 새로 만들거나 기존 방에 참여해보세요!',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline1?.copyWith(color: colorScheme.tertiaryContainer, fontWeight: FontWeight.w500, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    _navController.changeIndex(0);
                                  },
                                  child: Image.asset(
                                    width: 198,
                                    'assets/button/add_timeline.png',
                                  ),
                                  style: OutlinedButton.styleFrom(side: BorderSide(width: 0, color: colorScheme.onBackground)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }

              // history load 중에 오류 발생
              else if (snapshot.hasError) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 160.h,
                    ),
                    Align(
                      child: Text(
                        '${snapshot.error}',
                        style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
                      ),
                    ),
                  ],
                );
              }

              // history data loading bar
              return LinearProgressIndicator(
                color: colorScheme.secondary,
              );
            },
          );
        }),
      ),
    );
  }
}

// class ChatroomListScreen extends StatelessWidget {
//   const ChatroomListScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.only(left: 24.w, top: 55.h, right: 24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "채팅",
//               style: textTheme.headline2?.copyWith(
//                 color: colorScheme.onTertiary,
//               ),
//             ),
//             SizedBox(
//               height: 13.h,
//             ),
//             Container(
//                 width: 342.w,
//                 height: 75.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Stack(
//                   children: [
//                     Image.asset('assets/banner.png'),
//                     Padding(
//                       padding: EdgeInsets.only(right: 7.w, bottom: 5.h),
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Image.asset('assets/button/contact.png'),
//                       ),
//                     )
//                   ],
//                 )),
//             SizedBox(
//               height: 13.h,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "탑승 예정 톡방",
//                         style: textTheme.bodyText2?.copyWith(
//                           color: colorScheme.tertiaryContainer,
//                         ),
//                       ),
//                       chatroomListListTile(context),
//                       chatroomListListTile(context),
//                       SizedBox(
//                         height: 29.h,
//                       ),
//                       Text(
//                         "전체 톡방 내역",
//                         style: textTheme.bodyText2?.copyWith(
//                           color: colorScheme.tertiaryContainer,
//                         ),
//                       ),
//                       chatroomListListTile(context),
//                       chatroomListListTile(context),
//                       chatroomListListTile(context),
//                       chatroomListListTile(context),
//                       chatroomListListTile(context),
//                     ]),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
