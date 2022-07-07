// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/postsController.dart';
import 'package:itaxi/controller/tabViewController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/tabView.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TabViewController _tabViewController = Get.put(TabViewController());
  PostsController _postsController = Get.put(PostsController());

  @override
  void initState() {
    super.initState();
    // _postsController.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '조회 / 모집',
            style: textTheme.subtitle1,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Add Post',
              icon: Icon(
                Icons.add_circle_outline,
                // color: colorScheme.secondary,
              ),
            ),
          ],
        ),
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
                        Container(
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
                          child: Text(
                            '출발',
                            style: textTheme.subtitle1,
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
                        Container(
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
                          child: Text(
                            '도착',
                            style: textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '오늘',
                      style: textTheme.bodyText1,
                      // ?.copyWith(color: colorScheme.secondary),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '날짜',
                      style: textTheme.headline2,
                      // ?.copyWith(color: colorScheme.secondary),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                      // color: colorScheme.tertiary,
                      thickness: 0.3,
                    ),
                  ],
                ),

                // post list
                // Expanded(
                //   child: FutureBuilder<List<Post>>(
                //     future: _postsController.posts,
                //     builder: (BuildContext context, snapshot) {
                //       if (snapshot.hasData) {
                //         // post가 있을 떼
                //         if (snapshot.data!.isNotEmpty) {
                //           return Center(
                //             child: Text('list'),
                //           );
                //         }
                //         // post가 없을 때
                //         else {
                //           return Center(
                //             child: Text('존재하지 않음'),
                //           );
                //         }
                //       }
                //       // post load 중에 오류 발생
                //       else if (snapshot.hasError) {
                //         return Center(
                //           child: Text('${snapshot.error}'),
                //         );
                //       }

                //       // post data loading bar
                //       return LinearProgressIndicator(
                //         color: Colors.blue,
                //         // color: colorScheme.secondary,
                //       );
                //     },
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
