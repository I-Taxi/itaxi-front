import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/noticeController.dart';
import 'package:itaxi/widget/noticeListTile.dart';

import 'package:itaxi/model/notice.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  NoticeController _noticeController = Get.put(NoticeController());


  @override
  initState() {
    _noticeController.getNotices();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
          automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.clear_sharp,
                    color: colorScheme.tertiary,
                  ),
                ),
              ),
              Text(
                '공지사항',
                style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0.w,
              right: 16.0.w,
            ),
            child: FutureBuilder<List<Notice>>(
              future: _noticeController.notices,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      physics: ScrollPhysics(),
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
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
          ),
          Text(
            '공지사항이 없습니다',
            style: textTheme.headline2?.copyWith(
              color: colorScheme.tertiary,
              fontFamily: 'NotoSans',
            ),
          ),
        ],
      ),
    );
  }
}


