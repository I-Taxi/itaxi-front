import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';

Widget soonTimelineListTile(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      _historyController.getHistoryInfo(postId: post.id!);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            child: Container(
              width: 360.w,
              height: 320.h,
              padding: EdgeInsets.fromLTRB(20.0.w, 20.0.h, 20.0.w, 12.0.h),
              child: FutureBuilder<Post>(
                future: _historyController.history,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.postType == 1 ? '택시' : '카풀',
                            style: textTheme.headline1
                                ?.copyWith(color: colorScheme.tertiary),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            DateFormat('yyyy년 MM월 dd일 E').format(
                                DateTime.parse(snapshot.data!.deptTime!)),
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
                                        snapshot.data!.deptTime!)),
                                    style: textTheme.headline2?.copyWith(
                                        color: colorScheme.onPrimary),
                                  ),
                                  SizedBox(
                                    height: 9.0.h,
                                  ),
                                  Image.asset(
                                    width: 24.w,
                                    height: 24.h,
                                    'assets/participant/${snapshot.data!.participantNum}_2.png',
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
                                        '${snapshot.data!.departure?.name}',
                                        style: textTheme.bodyText1?.copyWith(
                                            color: colorScheme.onPrimary),
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
                                        '${snapshot.data!.destination?.name}',
                                        style: textTheme.bodyText1?.copyWith(
                                            color: colorScheme.onPrimary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              if (snapshot.data!.largeLuggageNum != 0)
                                for (int i = 0;
                                    i < snapshot.data!.largeLuggageNum!;
                                    i++)
                                  Image.asset(
                                    width: 24.w,
                                    height: 32.h,
                                    'assets/luggage/luggage_large.png',
                                  ),
                              if (snapshot.data!.smallLuggageNum != 0)
                                for (int i = 0;
                                    i < snapshot.data!.smallLuggageNum!;
                                    i++)
                                  Image.asset(
                                    width: 16.w,
                                    height: 22.h,
                                    'assets/luggage/luggage_small.png',
                                  ),
                              if (snapshot.data!.largeLuggageNum != 0 ||
                                  snapshot.data!.smallLuggageNum != 0)
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
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '연락처',
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.tertiary),
                              ),
                              Expanded(
                                child: Divider(
                                  color: colorScheme.shadow,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _postController.fetchOutJoin(
                                      postId: snapshot.data!.id!);
                                  _historyController.getHistorys();
                                  Get.back();
                                },
                                child: Text(
                                  '방 나가기',
                                  style: textTheme.headline1
                                      ?.copyWith(color: colorScheme.tertiary),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  '확인',
                                  style: textTheme.headline1
                                      ?.copyWith(color: colorScheme.secondary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          '글 내용 가져오기가 실패하였습니다',
                          style: textTheme.headline2?.copyWith(
                            color: colorScheme.tertiary,
                            fontFamily: 'NotoSans',
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
            ),
          );
        },
      );
    },
    child: Container(
      width: 352.w,
      height: 80.0.h,
      margin: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 10.h),
      padding: EdgeInsets.fromLTRB(18.w, 4.h, 0.w, 0.h),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        // borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 2,
          color: colorScheme.secondary,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: colorScheme.shadow,
        //     offset: const Offset(1.0, 1.0),
        //     blurRadius: 2.0,
        //   ),
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(post.deptTime!)),
                style:
                    textTheme.headline2?.copyWith(color: colorScheme.onPrimary),
              ),
              SizedBox(
                height: 9.0.h,
              ),
              Image.asset(
                width: 24.w,
                height: 24.h,
                'assets/participant/${post.participantNum}_2.png',
              ),
            ],
          ),
          SizedBox(
            width: 22.w,
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
                    '${post.departure?.name}',
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
                    '${post.destination?.name}',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (post.largeLuggageNum != 0)
            for (int i = 0; i < post.largeLuggageNum!; i++)
              Image.asset(
                width: 24.w,
                height: 32.h,
                'assets/luggage/luggage_large.png',
              ),
          if (post.smallLuggageNum != 0)
            for (int i = 0; i < post.smallLuggageNum!; i++)
              Image.asset(
                width: 16.w,
                height: 22.h,
                'assets/luggage/luggage_small.png',
              ),
          if (post.largeLuggageNum != 0 || post.smallLuggageNum != 0)
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
    ),
  );
}
