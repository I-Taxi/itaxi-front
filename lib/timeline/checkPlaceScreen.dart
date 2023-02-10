import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';

import 'package:itaxi/controller/userController.dart';

class CheckPlaceScreen extends StatefulWidget {
  const CheckPlaceScreen({Key? key}) : super(key: key);

  @override
  State<CheckPlaceScreen> createState() => _CheckPlaceScreenState();
}

class _CheckPlaceScreenState extends State<CheckPlaceScreen> {
  ScreenController _screenController = Get.put(ScreenController());
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.put(PostController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  HistoryController _historyController = Get.put(HistoryController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _userController.getUsers();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
      postType: _screenController.mainScreenCurrentTabIndex,
    );
    _placeController.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          height: 214.h,
          color: colorScheme.onBackground,
          alignment: Alignment.topCenter,
          child: Container(
            width: 390.w,
            height: 206.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[
                  Color(0xff8fc0f1),
                  Color(0Xff62a6ea),
                ]),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), bottomRight: Radius.circular(16.r))),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  _screenController.setCheckScreen(false);
                },
                icon: Image.asset("assets/arrow/arrow_back_1.png",
                    color: colorScheme.primary, width: 20.w, height: 20.h)),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.r),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/button/menu.png",
                    color: colorScheme.background,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: GetBuilder<ScreenController>(builder: (_) {
            return Column(
              children: [
                Container(
                  height: 100.h,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 107.w,
                            alignment: Alignment.centerRight,
                            child: Text(abbreviatePlaceName(_placeController.dep!.name!),
                                style: textTheme.subtitle1?.copyWith(color: colorScheme.primary)),
                          ),
                          SizedBox(
                            width: 37.0.w,
                          ),
                          Image.asset(
                            width: 102.5.w,
                            height: 16.52.h,
                            'assets/DeptoDes.png',
                          ),
                          SizedBox(
                            width: 35.5.w,
                          ),
                          Container(
                            width: 107.w,
                            alignment: Alignment.centerLeft,
                            child: Text(abbreviatePlaceName(_placeController.dst!.name!),
                                style: textTheme.subtitle1?.copyWith(color: colorScheme.primary)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            checkPlaceScreenBeforeDateWidget(textTheme, colorScheme, -2),
                            SizedBox(
                              width: 25.w,
                            ),
                            checkPlaceScreenBeforeDateWidget(textTheme, colorScheme, -1),
                            SizedBox(
                              width: 25.w,
                            ),
                            GetBuilder<DateController>(
                              builder: (_) {
                                return Container(
                                  height: 24.h,
                                  width: 72.w,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    DateFormat('MM월 dd일').format(_dateController.pickedDate!),
                                    style: textTheme.subtitle2?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            checkPlaceScreenAfterDateWidget(textTheme, colorScheme, 1),
                            SizedBox(
                              width: 26.w,
                            ),
                            checkPlaceScreenAfterDateWidget(textTheme, colorScheme, 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Expanded(
                  child: Container(
                    color: colorScheme.onBackground,
                    child: GetBuilder<PostController>(builder: (_) {
                      return FutureBuilder<List<Post>>(
                          future: _postController.posts,
                          builder: (context, snapshot) {
                            if (snapshot.data == null || snapshot.data!.length == 0) return postIsEmpty(context);
                            return RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView(
                                children: [
                                  for (int index = 0; index < snapshot.data!.length; index++)
                                    postListTile(context: context, post: snapshot.data![index])
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }

  GetBuilder<DateController> checkPlaceScreenAfterDateWidget(
      TextTheme textTheme, ColorScheme colorScheme, int difference) {
    return GetBuilder<DateController>(
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _dateController.afterDate();
          },
          child: Container(
            height: 24.h,
            width: 42.w,
            alignment: Alignment.center,
            child: Text(
              DateFormat('MM.d').format(_dateController.pickedDate!.add(Duration(days: difference))),
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.surfaceTint,
              ),
            ),
          ),
        );
      },
    );
  }

  GetBuilder<DateController> checkPlaceScreenBeforeDateWidget(
      TextTheme textTheme, ColorScheme colorScheme, int difference) {
    return GetBuilder<DateController>(
      builder: (_) {
        if (DateTime.now().day <= _dateController.pickedDate!.add(Duration(days: difference)).day) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _dateController.beforDate();
            },
            child: Container(
              height: 24.h,
              width: 42.w,
              alignment: Alignment.center,
              child: Text(
                DateFormat('MM.dd').format(_dateController.pickedDate!.add(Duration(days: difference))),
                style: textTheme.bodyText1?.copyWith(
                  color: colorScheme.surfaceTint,
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Container(
            height: 24.h,
            width: 42.w,
            alignment: Alignment.center,
            child: Text(
              DateFormat(' - ').format(_dateController.pickedDate!.add(const Duration(days: -2))),
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.surfaceTint,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget postIsEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 192.h,
            ),
            Text(
              '검색된 내용이 없습니다\n직접 방을 만들어 사람들을 모아보세요!',
              textAlign: TextAlign.center,
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.tertiary,
                height: 1.5,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(side: BorderSide(width: 0.01, color: colorScheme.onBackground)),
              child: Image.asset(
                height: 40.h,
                width: 178.w,
                'assets/button/add_timeline.png',
              ),
            )
          ],
        )
      ],
    );
  }
}
