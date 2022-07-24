// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postsController.dart';
import 'package:itaxi/controller/tabViewController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/addPostDialog.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TabViewController _tabViewController = Get.put(TabViewController());
  AddPostController _addPostController = Get.put(AddPostController());
  PostsController _postsController = Get.put(PostsController());
  PlaceController _placeController = Get.put(PlaceController());
  DateController _dateController = Get.put(DateController());

  @override
  void initState() {
    super.initState();
    _postsController.getPosts(
        time: _dateController
            .formattingDateTime(_dateController.mergeDateAndTime()));
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
            IconButton(
              onPressed: () {
                addPostDialog(context: context);
              },
              tooltip: 'Add Post',
              icon: Icon(
                Icons.add_circle_outline,
                color: colorScheme.secondary,
              ),
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
                        _tabViewController.changeIndex(0);
                      },
                      child: (_tabViewController.currentIndex == 0)
                          ? selectedTabView(
                              viewTitle: '택시', textTheme: textTheme)
                          : unSelectedTabView(
                              viewTitle: '택시', textTheme: textTheme),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _tabViewController.changeIndex(1);
                      },
                      child: (_tabViewController.currentIndex == 1)
                          ? selectedTabView(
                              viewTitle: '전체', textTheme: textTheme)
                          : unSelectedTabView(
                              viewTitle: '전체', textTheme: textTheme),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _tabViewController.changeIndex(2);
                      },
                      child: (_tabViewController.currentIndex == 2)
                          ? selectedTabView(
                              viewTitle: '카풀', textTheme: textTheme)
                          : unSelectedTabView(
                              viewTitle: '카풀', textTheme: textTheme),
                    ),
                  ],
                ),
                // 출발 도착 날짜 선택
                Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
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
                            padding: EdgeInsets.fromLTRB(48, 8, 48, 8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                color: Colors.grey,
                                // color: colorScheme.tertiary,
                                width: 0.3,
                              ),
                            ),
                            child: GetBuilder<PlaceController>(
                              builder: (_) {
                                return _placeController.dep == null
                                    ? Text(
                                        '출발',
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      )
                                    : Text(
                                        '${_placeController.dep?.name}',
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 16.0,
                        ),

                        // 화살표
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                        ),

                        const SizedBox(
                          width: 16.0,
                        ),

                        // 도착 설정 버튼
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            selectPlaceDialog(context: context, type: 1);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(48, 8, 48, 8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                color: Colors.grey,
                                // color: colorScheme.tertiary,
                                width: 0.3,
                              ),
                            ),
                            child: GetBuilder<PlaceController>(
                              builder: (_) {
                                return _placeController.dst == null
                                    ? Text(
                                        '도착',
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      )
                                    : Text(
                                        '${_placeController.dst?.name}',
                                        style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.tertiary),
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '오늘',
                      style: textTheme.bodyText1
                          ?.copyWith(color: colorScheme.secondary),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              color: colorScheme.shadow,
                              size: 16.0,
                            ),
                            GetBuilder<DateController>(
                              builder: (_) {
                                return Text(
                                  DateFormat('d E')
                                      .format(_dateController.pickedDate!),
                                  style: textTheme.headline2
                                      ?.copyWith(color: colorScheme.secondary),
                                );
                              },
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: colorScheme.shadow,
                              size: 16.0,
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
                              padding: const EdgeInsets.only(right: 52.0),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: colorScheme.secondary,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Divider(
                      thickness: 0.3,
                    ),
                  ],
                ),

                // postIsEmpty(context),

                // post list
                FutureBuilder<List<Post>>(
                  future: _postsController.posts,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      // post가 있을 떼
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return postListTile(
                              colorScheme: colorScheme,
                              textTheme: textTheme,
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
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            '검색 결과가 없습니다',
            style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
          ),
        ),
        InkWell(
          onTap: () {
            addPostDialog(context: context);
          },
          child: Container(
            width: 352.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Icon(
                  Icons.add,
                  color: colorScheme.secondary,
                  size: 20.0,
                ),
                SizedBox(
                  height: 12.0,
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
