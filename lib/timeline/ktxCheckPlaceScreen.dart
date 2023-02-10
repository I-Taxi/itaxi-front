import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/addKtxPostController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/ktxPlaceController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/widget/ktxPostListTile.dart';
import 'package:itaxi/widget/abbreviatePlaceName.dart';

import 'package:itaxi/controller/userController.dart';

class KtxCheckPlaceScreen extends StatefulWidget {
  const KtxCheckPlaceScreen({Key? key}) : super(key: key);

  @override
  State<KtxCheckPlaceScreen> createState() => _KtxCheckPlaceScreenState();
}

class _KtxCheckPlaceScreenState extends State<KtxCheckPlaceScreen> {
  ScreenController _screenController = Get.put(ScreenController());
  AddKtxPostController _addKtxPostController = Get.put(AddKtxPostController());
  KtxPostController _ktxPostController = Get.put(KtxPostController());
  KtxPlaceController _ktxPlaceController = Get.put(KtxPlaceController());
  DateController _dateController = Get.put(DateController());
  UserController _userController = Get.put(UserController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _userController.getUsers();
    _ktxPostController.getPosts(
      depId: _ktxPlaceController.dep?.id,
      dstId: _ktxPlaceController.dst?.id,
      time: _dateController.formattingDateTime(
        _dateController.mergeDateAndTime(),
      ),
    );
    _ktxPlaceController.getPlaces();
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
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff8fc0f1),
                      Color(0Xff62a6ea),
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r))),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  _screenController.setKtxCheckScreen(false);
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
                            child: Text(
                                abbreviatePlaceName(
                                    _ktxPlaceController.dep!.name!),
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.primary)),
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
                            child: Text(
                                abbreviatePlaceName(
                                    _ktxPlaceController.dst!.name!),
                                style: textTheme.subtitle1
                                    ?.copyWith(color: colorScheme.primary)),
                          ),
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
                SizedBox(
                  height: 8.h,
                ),
                Expanded(
                  child: Container(
                    color: colorScheme.onBackground,
                    child: GetBuilder<KtxPostController>(builder: (_) {
                      return FutureBuilder<List<KtxPost>>(
                          future: _ktxPostController.posts,
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data!.length == 0)
                              return postIsEmpty(context);
                            return RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView(
                                children: [
                                  for (int index = 0;
                                      index < snapshot.data!.length;
                                      index++)
                                    ktxPostListTile(
                                        context: context,
                                        post: snapshot.data![index])
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
    // Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(206.h),
    //     child: Column(
    //       children: [
    //         // AppBar(
    //         //   backgroundColor: colorScheme.secondary,
    //         //   elevation: 0.0,
    //         //   leading: IconButton(
    //         //       onPressed: () {
    //         //         Get.back();
    //         //       },
    //         //       icon: Image.asset("assets/arrow/arrow_back_1.png",
    //         //           color: colorScheme.primary,
    //         //           width: 11.62.w,
    //         //           height: 20.51.h)),
    //         //   actions: [
    //         //     IconButton(
    //         //       onPressed: () {},
    //         //       icon: const Icon(Icons.menu),
    //         //       color: colorScheme.background,
    //         //     ),
    //         //   ],
    //         // ),
    //         Container(
    //           decoration: BoxDecoration(
    //             color: colorScheme.secondary,
    //           ),
    //           height: 100.h,
    //           child: Column(children: [
    //             IconButton(
    //                 onPressed: () {
    //                   Get.back();
    //                 },
    //                 icon: Image.asset("assets/arrow/arrow_back_1.png",
    //                     color: colorScheme.primary,
    //                     width: 11.62.w,
    //                     height: 20.51.h)),
    //             IconButton(
    //               onPressed: () {},
    //               icon: const Icon(Icons.menu),
    //               color: colorScheme.background,
    //             ),
    //           ]),
    //         ),
    //         Container(
    //           height: 106.h,
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //               color: colorScheme.secondary,
    //               borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(18.0),
    //                   bottomRight: Radius.circular(18.0))),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(abbreviatePlaceName(_ktxPlaceController.dep!.name!),
    //                       style: textTheme.subtitle1
    //                           ?.copyWith(color: colorScheme.primary)),
    //                   SizedBox(
    //                     width: 37.0.w,
    //                   ),
    //                   Image.asset(
    //                     width: 102.5.w,
    //                     height: 16.52.h,
    //                     'assets/DeptoDes.png',
    //                   ),
    //                   SizedBox(
    //                     width: 35.5.w,
    //                   ),
    //                   Text(abbreviatePlaceName(_ktxPlaceController.dst!.name!),
    //                       style: textTheme.subtitle1
    //                           ?.copyWith(color: colorScheme.primary)),
    //                 ],
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     checkPlaceScreenBeforeDateWidget(
    //                         textTheme, colorScheme, -2),
    //                     SizedBox(
    //                       width: 25.w,
    //                     ),
    //                     checkPlaceScreenBeforeDateWidget(
    //                         textTheme, colorScheme, -1),
    //                     SizedBox(
    //                       width: 25.w,
    //                     ),
    //                     GetBuilder<DateController>(
    //                       builder: (_) {
    //                         return Container(
    //                           height: 24.h,
    //                           width: 72.w,
    //                           alignment: Alignment.topCenter,
    //                           child: Text(
    //                             DateFormat('MM월 dd일')
    //                                 .format(_dateController.pickedDate!),
    //                             style: textTheme.subtitle2?.copyWith(
    //                               color: colorScheme.primary,
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                     SizedBox(
    //                       width: 25.w,
    //                     ),
    //                     checkPlaceScreenAfterDateWidget(
    //                         textTheme, colorScheme, 1),
    //                     SizedBox(
    //                       width: 26.w,
    //                     ),
    //                     checkPlaceScreenAfterDateWidget(
    //                         textTheme, colorScheme, 2),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   backgroundColor: colorScheme.onBackground,
    //   body: ColorfulSafeArea(
    //     child: GetBuilder<ScreenController>(
    //       builder: (_) {
    //         return Column(
    //           children: [
    //             // post list
    //             Expanded(
    //               child: RefreshIndicator(
    //                 key: _refreshIndicatorKey,
    //                 color: colorScheme.tertiary,
    //                 backgroundColor: colorScheme.background,
    //                 strokeWidth: 2.0,
    //                 onRefresh: () async {
    //                   _ktxPostController.getPosts(
    //                     depId: _ktxPlaceController.dep?.id,
    //                     dstId: _ktxPlaceController.dst?.id,
    //                     time: _dateController.formattingDateTime(
    //                       _dateController.mergeDateAndTime(),
    //                     ),
    //                   );
    //                 },
    //                 child: GetBuilder<KtxPostController>(
    //                   builder: (_) {
    //                     return FutureBuilder<List<KtxPost>>(
    //                       future: _ktxPostController.posts,
    //                       builder: (BuildContext context, snapshot) {
    //                         if (snapshot.hasData) {
    //                           // post가 있을 떼
    //                           if (snapshot.data!.isNotEmpty) {
    //                             return ListView.builder(
    //                               itemCount: snapshot.data!.length,
    //                               itemBuilder:
    //                                   (BuildContext context, int index) {
    //                                 return ktxPostListTile(
    //                                   context: context,
    //                                   post: snapshot.data![index],
    //                                 );
    //                               },
    //                             );
    //                           }
    //                           // post가 없을 때
    //                           else {
    //                             return postIsEmpty(context);
    //                           }
    //                         }
    //                         // post load 중에 오류 발생
    //                         else if (snapshot.hasError) {
    //                           return ListView(
    //                             children: [
    //                               SizedBox(
    //                                 height: 40.h,
    //                               ),
    //                               Align(
    //                                 child: Text(
    //                                   '${snapshot.error}',
    //                                   style: textTheme.subtitle2?.copyWith(
    //                                     color: colorScheme.tertiary,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           );
    //                         }

    //                         // post data loading bar
    //                         return LinearProgressIndicator(
    //                           color: colorScheme.secondary,
    //                         );
    //                       },
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
  }

  GetBuilder<DateController> checkPlaceScreenAfterDateWidget(
      TextTheme textTheme, ColorScheme colorScheme, int difference) {
    return GetBuilder<DateController>(
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _dateController.afterKtxDate();
          },
          child: Container(
            height: 24.h,
            width: 42.w,
            alignment: Alignment.center,
            child: Text(
              DateFormat('MM.d').format(
                  _dateController.pickedDate!.add(Duration(days: difference))),
              style: textTheme.bodyText1?.copyWith(
                color: Color(0xFFC5E1FD),
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
              _dateController.beforeKtxDate();
            },
            child: Container(
              height: 24.h,
              width: 42.w,
              alignment: Alignment.center,
              child: Text(
                DateFormat('MM.dd').format(_dateController.pickedDate!
                    .add(Duration(days: difference))),
                style: textTheme.bodyText1?.copyWith(
                  color: Color(0xFFC5E1FD),
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
              height: 192.h,
            ),
            Text(
              '검색된 내용이 없습니다\n직접 방을 만들어 사람들을 모아보세요!',
              textAlign: TextAlign.center,
              style: textTheme.bodyText1?.copyWith(
                color: colorScheme.tertiary,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(width: 0.01, color: colorScheme.onBackground)),
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
