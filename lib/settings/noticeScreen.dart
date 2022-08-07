import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/noticeController.dart';
import 'package:itaxi/widget/noticeListTile.dart';

import '../model/notice.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  NoticeController _noticeController = Get.put(NoticeController());
  // Future<List<Notice>> notices = _noticeController.notices;

  @override
  void initState() {
    _noticeController.getNotices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              leading: BackButton(
                color: colorScheme.shadow,
              ),
              shadowColor: colorScheme.shadow,
              elevation: 1.0,
              centerTitle: true,
              title: Text(
                '공지사항',
                style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary
                ),
              )
          ),
          body: SingleChildScrollView(
            child: FutureBuilder<List<Notice>>(
              future: _noticeController.notices,
              builder: (BuildContext context, snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data!.isNotEmpty) {
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
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                    )
                  );
                }
                return LinearProgressIndicator(
                  color: colorScheme.secondary,
                );
              },
            )
          ),
        )
    );
  }
  Widget noticeIsEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        '공지사항이 없습니다.',
        style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
      ),
    );
  }
}

