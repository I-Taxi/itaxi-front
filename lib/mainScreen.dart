// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/postsController.dart';
import 'package:itaxi/controller/tabViewController.dart';
import 'package:itaxi/widget/tabView.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  TabViewController _tabViewController = Get.put(TabViewController());
  PostsController _postsController = Get.put(PostsController());

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
        body: GetBuilder<PostsController>(
          builder: (_) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _tabViewController.changeIndex(0);
                    },
                    child: (_tabViewController.currentIndex == 0)
                        ? selectedTabView(viewTitle: '택시', textTheme: textTheme)
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
                        ? selectedTabView(viewTitle: '전체', textTheme: textTheme)
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
                        ? selectedTabView(viewTitle: '카풀', textTheme: textTheme)
                        : unSelectedTabView(
                            viewTitle: '카풀', textTheme: textTheme),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
