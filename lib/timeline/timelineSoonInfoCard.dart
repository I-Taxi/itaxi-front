import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/chatRoomScreen.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/timeline/timelineDetailScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/HorizontalDashedDivider.dart';

Container timelineSoonInfoCard({required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  _historyController.getHistoryInfo(postId: post.id!);

  Text postTypeToText(int? postType) {
    if (postType == 0) {
      return Text(
        '택시',
        style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
      );
    } else if (postType == 1) {
      return Text(
        '카풀',
        style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
      );
    } else if (postType == 2) {
      return Text(
        'KTX',
        style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
      );
    } else {
      return const Text('error');
    }
  }

  return Container(
    width: 339.w,
    height: 230.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: colorScheme.primary, boxShadow: [
      BoxShadow(
        color: colorScheme.shadow,
        blurRadius: 40,
        offset: const Offset(2, 4),
      )
    ]),
    child: FutureBuilder<Post>(
      future: _historyController.history,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return Padding(
                padding: EdgeInsets.fromLTRB(25.w, 18.h, 21.w, 0.h),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '곧 출발 예정',
                    style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(width: 24, 'assets/icon/location.png'),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        '${snapshot.data!.departure?.name}',
                        style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(width: 24, 'assets/icon/location.png'),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        '${snapshot.data!.destination?.name}',
                        style: textTheme.subtitle2?.copyWith(color: colorScheme.onTertiary),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  HorizontalDashedDivider(
                    length: 5,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MM/dd').format(DateTime.parse(snapshot.data!.deptTime!)),
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          // TODO: post type별로 text 다르게 나오게 하기
                          postTypeToText(snapshot.data!.postType),
                        ],
                      ),
                      SizedBox(
                        width: 49.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MM/dd').format(DateTime.parse(snapshot.data!.deptTime!)),
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            '${snapshot.data!.participantNum}/${snapshot.data!.capacity}명',
                            style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiaryContainer),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () async {
                            if (post.postType == null) {
                              // TODO: ktx container 제작하면 연결
                              _historyController.getHistoryInfo(postId: post.id!);
                            } else {
                              _historyController.getHistoryInfo(postId: post.id!);
                              Get.to(() => TimelineDetailScreen());
                            }
                          },
                          child: Image.asset(width: 81.w, 'assets/button/go_descript.png'))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Spacer(),
                ]));
          } else {
            return Center(
              child: Text(
                '글 내용 가져오기가 실패하였습니다',
                style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.tertiary,
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.tertiary,
              strokeWidth: 2,
            ),
          );
        }
      },
    ),
  );
}