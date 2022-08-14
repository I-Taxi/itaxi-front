import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/noticeController.dart';
import 'package:itaxi/widget/noticeListTile.dart';

import 'package:itaxi/model/notice.dart';

class NoticeScreen extends StatelessWidget {
  NoticeScreen({Key? key}) : super(key: key);

  NoticeController _noticeController = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '공지사항',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colorScheme.tertiary,
          ),
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 32.0.w,
            ),
            child: FutureBuilder<List<Notice>>(
              future: _noticeController.notices,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return noticeListTile(
                          context: context,
                          notice: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return noticeIsEmpty(context);
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: textTheme.headline2?.copyWith(
                        color: colorScheme.tertiary,
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  );
                }
                return LinearProgressIndicator(
                  color: colorScheme.secondary,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget noticeIsEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        '공지사항이 없습니다',
        style: textTheme.headline2?.copyWith(
          color: colorScheme.tertiary,
          fontFamily: 'NotoSans',
        ),
      ),
    );
  }
}
