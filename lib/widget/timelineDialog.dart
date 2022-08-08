import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/model/post.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> timelineDiaog(
    {required BuildContext context, required Post post}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  late PostController _postController = Get.find();
  late HistoryController _historyController = Get.find();

  return showDialog(
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
                        DateFormat('yyyy년 MM월 dd일 E')
                            .format(DateTime.parse(snapshot.data!.deptTime!)),
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
                                DateFormat('HH:mm').format(
                                    DateTime.parse(snapshot.data!.deptTime!)),
                                style: textTheme.headline2
                                    ?.copyWith(color: colorScheme.onPrimary),
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
                      SizedBox(
                        height: 16.h,
                      ),
                      if (snapshot.data!.joiners != null)
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 1,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 20.0,
                          ),
                          children: [
                            for (int i = 0;
                                i < snapshot.data!.joiners!.length;
                                i++)
                              Container(
                                width: 130.w,
                                height: 32.h,
                                alignment: Alignment.centerLeft,
                                padding:
                                    EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  border: Border.all(
                                    color: colorScheme.tertiary,
                                    width: 0.3,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Text(
                                      snapshot.data!.joiners!
                                          .elementAt(i)
                                          .memberName
                                          .toString(),
                                      style: textTheme.subtitle1?.copyWith(
                                          color: colorScheme.onPrimary),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            final Uri launchUri = Uri.parse(
                                                'tel:${snapshot.data!.joiners![i].memberPhone}');
                                            if (await canLaunchUrl(launchUri)) {
                                              await launchUrl(launchUri);
                                            } else {
                                              throw Exception('Failed call');
                                            }
                                          },
                                          child: Image.asset(
                                            width: 24.w,
                                            height: 24.w,
                                            'assets/button/phone.png',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            final Uri launchUri = Uri.parse(
                                                'sms:${snapshot.data!.joiners![i].memberPhone}');
                                            if (await canLaunchUrl(launchUri)) {
                                              await launchUrl(launchUri);
                                            } else {
                                              throw Exception('Failed sms');
                                            }
                                          },
                                          child: Image.asset(
                                            width: 24.w,
                                            height: 24.w,
                                            'assets/button/mail.png',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
}
