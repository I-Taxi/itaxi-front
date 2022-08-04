import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/tabViewController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/addPostDialog.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TabViewController _tabViewController = Get.put(TabViewController());
  AddPostController _addPostController = Get.put(AddPostController());
  PostController _postController = Get.put(PostController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _postController.getPosts(
      depId: _placeController.dep?.id,
      dstId: _placeController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
      postType: _tabViewController.currentIndex,
    );
    _placeController.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '조회 / 모집',
            style: textTheme.subtitle1?.copyWith(color: colorScheme.onPrimary),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                addPostDialog(context: context);
                _postController.getPosts(
                  depId: _placeController.dep?.id,
                  dstId: _placeController.dst?.id,
                  time: _dateController.formattingDateTime(
                    _dateController.mergeDateAndTime(),
                  ),
                  postType: _tabViewController.currentIndex,
                );
              },
              child: Image.asset(
                width: 24.w,
                height: 24.h,
                'assets/button/add_1.png',
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
        backgroundColor: colorScheme.background,
        body: GetBuilder<TabViewController>(
          builder: (_) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _tabViewController.changeIndex(1);
                        _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: _tabViewController.currentIndex,
                        );
                      },
                      child: (_tabViewController.currentIndex == 1)
                          ? selectedTabView(
                              viewTitle: '택시',
                              context: context,
                            )
                          : unSelectedTabView(
                              viewTitle: '택시',
                              context: context,
                            ),
                    ),
                    SizedBox(
                      width: 20.0.w,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _tabViewController.changeIndex(0);
                        _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: _tabViewController.currentIndex,
                        );
                      },
                      child: (_tabViewController.currentIndex == 0)
                          ? selectedTabView(
                              viewTitle: '전체',
                              context: context,
                            )
                          : unSelectedTabView(
                              viewTitle: '전체',
                              context: context,
                            ),
                    ),
                    SizedBox(
                      width: 20.0.w,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _tabViewController.changeIndex(2);
                        _postController.getPosts(
                          depId: _placeController.dep?.id,
                          dstId: _placeController.dst?.id,
                          time: _dateController.formattingDateTime(
                            _dateController.mergeDateAndTime(),
                          ),
                          postType: _tabViewController.currentIndex,
                        );
                      },
                      child: (_tabViewController.currentIndex == 2)
                          ? selectedTabView(
                              viewTitle: '카풀',
                              context: context,
                            )
                          : unSelectedTabView(
                              viewTitle: '카풀',
                              context: context,
                            ),
                    ),
                  ],
                ),
                // 출발 도착 날짜 선택
                Column(
                  children: [
                    SizedBox(
                      height: 22.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 출발 설정 버튼
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            selectPlaceDialog(context: context, type: 0);
                          },
                          child: Container(
                            width: 122.w,
                            height: 32.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                color: colorScheme.tertiary,
                                width: 0.3,
                              ),
                            ),
                            child: GetBuilder<PlaceController>(
                              builder: (_) {
                                return _placeController.dep == null
                                    ? Text(
                                        '출발',
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      )
                                    : Text(
                                        '${_placeController.dep?.name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      );
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 16.0.w,
                        ),
                        // 화살표
                        Image.asset(
                          width: 20.w,
                          height: 12.h,
                          'assets/arrow/arrow.png',
                        ),
                        SizedBox(
                          width: 16.0.w,
                        ),

                        // 도착 설정 버튼
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            selectPlaceDialog(context: context, type: 1);
                          },
                          child: Container(
                            width: 122.w,
                            height: 32.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                color: colorScheme.tertiary,
                                width: 0.3,
                              ),
                            ),
                            child: GetBuilder<PlaceController>(
                              builder: (_) {
                                return _placeController.dst == null
                                    ? Text(
                                        '도착',
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      )
                                    : Text(
                                        '${_placeController.dst?.name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    GetBuilder<DateController>(
                      builder: (_) {
                        return (DateFormat.yMd().format(DateTime.now()) ==
                                DateFormat.yMd()
                                    .format(_dateController.pickedDate!))
                            ? Text(
                                '오늘',
                                style: textTheme.bodyText1
                                    ?.copyWith(color: colorScheme.secondary),
                              )
                            : Text(
                                ' ',
                                style: textTheme.bodyText1
                                    ?.copyWith(color: colorScheme.secondary),
                              );
                      },
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              color: colorScheme.shadow,
                              size: 16.0.w,
                            ),
                            GetBuilder<DateController>(
                              builder: (_) {
                                return Text(
                                  DateFormat(' d E ')
                                      .format(_dateController.pickedDate!),
                                  style: textTheme.headline2?.copyWith(
                                    color: colorScheme.secondary,
                                    fontFamily: 'NotoSans',
                                  ),
                                );
                              },
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: colorScheme.shadow,
                              size: 16.0.w,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _dateController.selectDate(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 59.0.w),
                              child: Image.asset(
                                width: 20.w,
                                height: 20.w,
                                'assets/button/calendar.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    const Divider(
                      thickness: 0.3,
                    ),
                  ],
                ),

                // post list
                Expanded(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    color: colorScheme.tertiary,
                    backgroundColor: colorScheme.background,
                    strokeWidth: 2.0,
                    onRefresh: () async {
                      _postController.getPosts(
                        depId: _placeController.dep?.id,
                        dstId: _placeController.dst?.id,
                        time: _dateController.formattingDateTime(
                          _dateController.mergeDateAndTime(),
                        ),
                        postType: _tabViewController.currentIndex,
                      );
                    },
                    child: GetBuilder<PostController>(
                      builder: (_) {
                        return FutureBuilder<List<Post>>(
                          future: _postController.posts,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              // post가 있을 떼
                              if (snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return postListTile(
                                      context: context,
                                      post: snapshot.data![index],
                                    );
                                  },
                                );
                              }
                              // post가 없을 때
                              else {
                                return postIsEmpty(context);
                              }
                            }
                            // post load 중에 오류 발생
                            else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  '${snapshot.error}',
                                ),
                              );
                            }

                            // post data loading bar
                            return LinearProgressIndicator(
                              color: colorScheme.secondary,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget postIsEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0.h),
          child: Text(
            '검색 결과가 없습니다',
            style: textTheme.headline2?.copyWith(
              color: colorScheme.tertiary,
              fontFamily: 'NotoSans',
            ),
          ),
        ),
        InkWell(
          onTap: () {
            addPostDialog(context: context);
            _postController.getPosts(
              depId: _placeController.dep?.id,
              dstId: _placeController.dst?.id,
              time: _dateController.formattingDateTime(
                _dateController.mergeDateAndTime(),
              ),
              postType: _tabViewController.currentIndex,
            );
          },
          child: Container(
            width: 352.0.w,
            height: 80.0.h,
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow,
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 18.0.h,
                ),
                Image.asset(
                  width: 16.0.w,
                  height: 16.0.h,
                  'assets/button/add_2.png',
                ),
                SizedBox(
                  height: 12.0.h,
                ),
                Text(
                  '새로 모집하기',
                  style: textTheme.subtitle1
                      ?.copyWith(color: colorScheme.tertiary),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
