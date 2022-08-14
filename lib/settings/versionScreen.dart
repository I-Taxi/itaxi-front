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
        centerTitle: true,
        backgroundColor: colorScheme.secondary,
        title: Text(
          '버전정보/개발자',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: colorScheme.secondary,
      body: ColorfulSafeArea(
        color: colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 168.h,
              ),
              Image.asset(
                width: 82.w,
                height: 56.h,
                'assets/logo_2.png',
              ),
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '최신 버전을 사용 중입니다.',
                  style: textTheme.headline2?.copyWith(
                    color: colorScheme.primary,
                    fontFamily: 'Noto Sans',
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '현재 버전 3.0',
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 320.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'iTaxi',
                    style: textTheme.headline1?.copyWith(
                      color: colorScheme.primary,
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
              comentListTile(
                context: context,
                name: '유소은',
                coment: '제발 버그 없어라',
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget comentListTile({
  required BuildContext context,
  required String name,
  required String coment,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 12.0.w,
      vertical: 16.0.h,
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
            coment,
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.tertiary,
            ),
          ),
        ),
      ],
    ),
  );
}
