import 'dart:io';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/postListTile.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';
import 'package:itaxi/widget/tabView.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(206.h),
        child: Column(
          children: [
            AppBar(
              backgroundColor: colorScheme.secondary,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: colorScheme.primary,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                  color: colorScheme.background,
                ),
              ],
            ),
            Container(
              height: 123.74.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18.0),
                      bottomRight: Radius.circular(18.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(abbreviatePlaceName(_placeController.dep!.name!),
                          style: textTheme.subtitle1
                              ?.copyWith(color: colorScheme.primary)),
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
                      Text(abbreviatePlaceName(_placeController.dst!.name!),
                          style: textTheme.subtitle1
                              ?.copyWith(color: colorScheme.primary)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        checkPlaceScreenBeforeDateWidget(
                            textTheme, colorScheme, -2),
                        SizedBox(
                          width: 25.w,
                        ),
                        checkPlaceScreenBeforeDateWidget(
                            textTheme, colorScheme, -1),
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
                                DateFormat('MM월 dd일')
                                    .format(_dateController.pickedDate!),
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
                        checkPlaceScreenAfterDateWidget(
                            textTheme, colorScheme, 1),
                        SizedBox(
                          width: 26.w,
                        ),
                        checkPlaceScreenAfterDateWidget(
                            textTheme, colorScheme, 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: GetBuilder<ScreenController>(
          builder: (_) {
            return Column(
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       behavior: HitTestBehavior.opaque,
                //       onTap: () {
                //         _tabViewController.changeIndex(1);
                //         _postController.getPosts(
                //           depId: _placeController.dep?.id,
                //           dstId: _placeController.dst?.id,
                //           time: _dateController.formattingDateTime(
                //             _dateController.mergeDateAndTime(),
                //           ),
                //           postType: _tabViewController.currentIndex,
                //         );
                //       },
                //       child: (_tabViewController.currentIndex == 1)
                //           ? selectedTabView(
                //         viewTitle: '택시',
                //         context: context,
                //       )
                //           : unSelectedTabView(
                //         viewTitle: '택시',
                //         context: context,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20.0.w,
                //     ),
                //     GestureDetector(
                //       behavior: HitTestBehavior.opaque,
                //       onTap: () {
                //         _tabViewController.changeIndex(0);
                //         _postController.getPosts(
                //           depId: _placeController.dep?.id,
                //           dstId: _placeController.dst?.id,
                //           time: _dateController.formattingDateTime(
                //             _dateController.mergeDateAndTime(),
                //           ),
                //           postType: _tabViewController.currentIndex,
                //         );
                //       },
                //       child: (_tabViewController.currentIndex == 0)
                //           ? selectedTabView(
                //         viewTitle: '전체',
                //         context: context,
                //       )
                //           : unSelectedTabView(
                //         viewTitle: '전체',
                //         context: context,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20.0.w,
                //     ),
                //     GestureDetector(
                //       behavior: HitTestBehavior.opaque,
                //       onTap: () {
                //         _tabViewController.changeIndex(2);
                //         _postController.getPosts(
                //           depId: _placeController.dep?.id,
                //           dstId: _placeController.dst?.id,
                //           time: _dateController.formattingDateTime(
                //             _dateController.mergeDateAndTime(),
                //           ),
                //           postType: _tabViewController.currentIndex,
                //         );
                //       },
                //       child: (_tabViewController.currentIndex == 2)
                //           ? selectedTabView(
                //         viewTitle: '카풀',
                //         context: context,
                //       )
                //           : unSelectedTabView(
                //         viewTitle: '카풀',
                //         context: context,
                //       ),
                //     ),
                //   ],
                // ),
                // // 출발 도착 날짜 선택
                // Column(
                //   children: [
                //     SizedBox(
                //       height: 22.0.h,
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         // 출발 설정 버튼
                //         GestureDetector(
                //           behavior: HitTestBehavior.opaque,
                //           onTap: () {
                //             selectPlaceDialog(context: context, type: 0);
                //           },
                //           child: Container(
                //             width: 122.w,
                //             height: 32.h,
                //             alignment: Alignment.center,
                //             padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                //             decoration: BoxDecoration(
                //               borderRadius:
                //               const BorderRadius.all(Radius.circular(16.0)),
                //               border: Border.all(
                //                 color: colorScheme.tertiary,
                //                 width: 0.3,
                //               ),
                //             ),
                //             child: GetBuilder<PlaceController>(
                //               builder: (_) {
                //                 return _placeController.dep == null
                //                     ? Text(
                //                   '출발',
                //                   overflow: TextOverflow.ellipsis,
                //                   style: textTheme.subtitle1?.copyWith(
                //                       color: colorScheme.tertiary),
                //                 )
                //                     : Text(
                //                   '${_placeController.dep?.name}',
                //                   overflow: TextOverflow.ellipsis,
                //                   style: textTheme.subtitle1?.copyWith(
                //                       color: colorScheme.tertiary),
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //
                //         SizedBox(
                //           width: 16.0.w,
                //         ),
                //         // 화살표
                //         Image.asset(
                //           width: 20.w,
                //           height: 12.h,
                //           'assets/arrow/arrow.png',
                //         ),
                //         SizedBox(
                //           width: 16.0.w,
                //         ),
                //
                //         // 도착 설정 버튼
                //         GestureDetector(
                //           behavior: HitTestBehavior.opaque,
                //           onTap: () {
                //             selectPlaceDialog(context: context, type: 1);
                //           },
                //           child: Container(
                //             width: 122.w,
                //             height: 32.h,
                //             alignment: Alignment.center,
                //             padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 5.h),
                //             decoration: BoxDecoration(
                //               borderRadius:
                //               const BorderRadius.all(Radius.circular(16.0)),
                //               border: Border.all(
                //                 color: colorScheme.tertiary,
                //                 width: 0.3,
                //               ),
                //             ),
                //             child: GetBuilder<PlaceController>(
                //               builder: (_) {
                //                 return _placeController.dst == null
                //                     ? Text(
                //                   '도착',
                //                   overflow: TextOverflow.ellipsis,
                //                   style: textTheme.subtitle1?.copyWith(
                //                       color: colorScheme.tertiary),
                //                 )
                //                     : Text(
                //                   '${_placeController.dst?.name}',
                //                   overflow: TextOverflow.ellipsis,
                //                   style: textTheme.subtitle1?.copyWith(
                //                       color: colorScheme.tertiary),
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 8.0.h,
                //     ),
                //     GetBuilder<DateController>(
                //       builder: (_) {
                //         return (DateFormat.yMd().format(DateTime.now()) ==
                //             DateFormat.yMd()
                //                 .format(_dateController.pickedDate!))
                //             ? Text(
                //           '오늘',
                //           style: textTheme.bodyText1
                //               ?.copyWith(color: colorScheme.secondary),
                //         )
                //             : Text(
                //           ' ',
                //           style: textTheme.bodyText1
                //               ?.copyWith(color: colorScheme.secondary),
                //         );
                //       },
                //     ),
                //     SizedBox(
                //       height: 2.0.h,
                //     ),
                //     Stack(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             GetBuilder<DateController>(
                //               builder: (_) {
                //                 if (DateFormat.yMEd().format(DateTime.now()) !=
                //                     DateFormat.yMEd()
                //                         .format(_dateController.pickedDate!)) {
                //                   return GestureDetector(
                //                     behavior: HitTestBehavior.opaque,
                //                     onTap: () {
                //                       _dateController.beforDate();
                //                     },
                //                     child: Container(
                //                       height: 24.h,
                //                       width: 60.w,
                //                       alignment: Alignment.center,
                //                       child: Text(
                //                         DateFormat(' d E ').format(
                //                             _dateController.pickedDate!
                //                                 .add(const Duration(days: -1))),
                //                         style: textTheme.subtitle1?.copyWith(
                //                           color: colorScheme.tertiary,
                //                           fontFamily: 'NotoSans',
                //                         ),
                //                       ),
                //                     ),
                //                   );
                //                 }
                //                 return GestureDetector(
                //                   behavior: HitTestBehavior.opaque,
                //                   onTap: () {},
                //                   child: Container(
                //                     height: 24.h,
                //                     width: 60.w,
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       DateFormat(' - ').format(_dateController
                //                           .pickedDate!
                //                           .add(const Duration(days: -1))),
                //                       style: textTheme.subtitle1?.copyWith(
                //                         color: colorScheme.tertiary,
                //                         fontFamily: 'NotoSans',
                //                       ),
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //             Icon(
                //               Icons.arrow_back_ios_rounded,
                //               color: colorScheme.shadow,
                //               size: 16.0.w,
                //             ),
                //             GetBuilder<DateController>(
                //               builder: (_) {
                //                 return Container(
                //                   height: 24.h,
                //                   width: 68.w,
                //                   alignment: Alignment.center,
                //                   child: Text(
                //                     DateFormat(' d E ')
                //                         .format(_dateController.pickedDate!),
                //                     style: textTheme.headline2?.copyWith(
                //                       color: colorScheme.secondary,
                //                       fontFamily: 'NotoSans',
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //             Icon(
                //               Icons.arrow_forward_ios_rounded,
                //               color: colorScheme.shadow,
                //               size: 16.0.w,
                //             ),
                //             GetBuilder<DateController>(
                //               builder: (_) {
                //                 return GestureDetector(
                //                   behavior: HitTestBehavior.opaque,
                //                   onTap: () {
                //                     _dateController.afterDate();
                //                   },
                //                   child: Container(
                //                     height: 24.h,
                //                     width: 60.w,
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       DateFormat(' d E ').format(_dateController
                //                           .pickedDate!
                //                           .add(const Duration(days: 1))),
                //                       style: textTheme.subtitle1?.copyWith(
                //                         color: colorScheme.tertiary,
                //                         fontFamily: 'NotoSans',
                //                       ),
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ],
                //         ),
                //         Align(
                //           alignment: Alignment.centerRight,
                //           child: GestureDetector(
                //             behavior: HitTestBehavior.opaque,
                //             onTap: () {
                //               _dateController.selectDate(context);
                //             },
                //             child: Padding(
                //               padding: EdgeInsets.only(right: 59.0.w),
                //               child: Image.asset(
                //                 width: 24.w,
                //                 height: 24.w,
                //                 'assets/button/calendar.png',
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 8.0.h,
                //     ),
                //     Divider(
                //       thickness: 0.3,
                //       color: colorScheme.tertiary,
                //     ),
                //   ],
                // ),

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
                        postType: _screenController.mainScreenCurrentTabIndex,
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
                              return ListView(
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Align(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: textTheme.subtitle2?.copyWith(
                                        color: colorScheme.tertiary,
                                      ),
                                    ),
                                  ),
                                ],
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
              DateFormat('MM.d').format(
                  _dateController.pickedDate!.add(Duration(days: difference))),
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.outline,
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
        if (DateTime.now().day <=
            _dateController.pickedDate!.add(Duration(days: difference)).day) {
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
                DateFormat('MM.dd').format(_dateController.pickedDate!
                    .add(Duration(days: difference))),
                style: textTheme.bodyText1?.copyWith(
                  color: colorScheme.outline,
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
              DateFormat(' - ').format(
                  _dateController.pickedDate!.add(const Duration(days: -2))),
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.tertiary,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
              width: 282.w,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '아직 I-TAXI를 이용한 이력이 없어요\n어서 새로운 동료를 만나보세요',
                textAlign: TextAlign.center,
                style: textTheme.headline1?.copyWith(
                    color: colorScheme.tertiaryContainer,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 0, color: colorScheme.onBackground)),
              child: Image.asset(
                width: 198,
                'assets/button/add_timeline.png',
              ),
            )
          ],
        )
      ],
    );
  }
}
