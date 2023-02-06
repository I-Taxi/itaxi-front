import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.secondary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.clear_sharp, color: colorScheme.primary, size: 24,)
          )
        ],
      ),
      backgroundColor: colorScheme.secondary,
      body: ColorfulSafeArea(
        color: colorScheme.secondary,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  '버전정보/개발자',
                  style: textTheme.headline2?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 140.h,
                ),
                Image.asset(
                  width: 113.w,
                  height: 124.44.h,
                  'assets/logo_text.png',
                ),
                SizedBox(
                  height: 19.56.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ver.3.0',
                    style: textTheme.subtitle2?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '최신 버전을 사용하고 있습니다.',
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 336.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      'iTaxi',
                      style: textTheme.subtitle2?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 160.h,
                ),
                commentLeftListTile(
                  context: context,
                  name: '우리팀 면접관(팀장)',
                  comment: '데모는 편하게 해도 돼. 오류없이 ^^',
                ),
                commentLeftListTile(
                  context: context,
                  name: 'Legacy와 이별 중',
                  comment: 'Legacy 반가워요, 반가웠어요.',
                ),
                commentLeftListTile(
                  context: context,
                  name: '짜고보니 핵심 파트',
                  comment: '인생은 Greedy,,, 지금 이순간 최선을 다하자',
                ),
                commentLeftListTile(
                  context: context,
                  name: '센빠이들 너무 빨라요..',
                  comment: '이번 주말까지라고요…?',
                ),
                commentLeftListTile(
                  context: context,
                  name: '노예상인',
                  comment: 'throw Exception(’버그 등장’);',
                ),
                commentLeftListTile(
                  context: context,
                  name: '속아서 노예계약',
                  comment: '해 있을 땐 랩실에서 테스트 코드 작성… 해 없을 땐 집에서 UI 개발…',
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget commentLeftListTile({
  required BuildContext context,
  required String name,
  required String comment,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 12.0.w,
      vertical: 8.h,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            comment,
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.tertiary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget commentRightListTile({
  required BuildContext context,
  required String name,
  required String comment,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 12.0.w,
      vertical: 4.0.h,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          name,
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            comment,
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.tertiary,
            ),
          ),
        ),
      ],
    ),
  );
}
