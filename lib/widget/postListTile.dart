import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/navigationController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';

Widget postListTile({
  required BuildContext context,
  required Post post,
}) {
  late AddPostController _addPostController = Get.find();
  late PostController _postController = Get.find();
  late NavigationController _navigationController = Get.find();
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            child: Container(
              width: 360.w,
              height: 132.h,
              padding: EdgeInsets.fromLTRB(28.0.w, 32.0.h, 28.0.w, 12.0.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '나의 짐',
                        style: textTheme.headline2?.copyWith(
                          color: colorScheme.tertiary,
                          fontFamily: 'NotoSans',
                        ),
                      ),
                      GetBuilder<AddPostController>(
                        builder: (_) {
                          return Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _addPostController.changeLuggage(0);
                                },
                                child: (_addPostController.luggage == 0)
                                    ? Text(
                                        '없음',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.secondary),
                                      )
                                    : Text(
                                        '없음',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.tertiary),
                                      ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _addPostController.changeLuggage(1);
                                },
                                child: (_addPostController.luggage == 1)
                                    ? Text(
                                        '소',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.secondary),
                                      )
                                    : Text(
                                        '소',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.tertiary),
                                      ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  _addPostController.changeLuggage(2);
                                },
                                child: (_addPostController.luggage == 2)
                                    ? Text(
                                        '대',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.secondary),
                                      )
                                    : Text(
                                        '대',
                                        style: textTheme.headline2?.copyWith(
                                            color: colorScheme.tertiary),
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '취소',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.tertiary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _postController.fetchJoin(
                              postId: post.id!,
                              luggage: _addPostController.luggage);
                          _navigationController.changeIndex(0);
                          Get.back();
                        },
                        child: Text(
                          '입장',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
    child: Container(
      width: 352.w,
      height: 80.0.h,
      margin: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 0.w, 12.h),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            offset: const Offset(1.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
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
