import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:itaxi/widget/mainDialog.dart';

class BugScreen extends StatelessWidget {
  BugScreen({Key? key}) : super(key: key);

  // 버그제보 상단의 버그제보방법 글
  String mainBody = "[버그 제보 방법]\n";

  // 이메일 보내기
  void _sendEmail(BuildContext context) async {
    // 이메일 보낼때 보여지는 상단 글
    String body = "";

    body += "==============\n";
    body += "1. 해당 버그가 나타난 페이지를 캡쳐해서 보내주세요.\n";
    body += "2. 보이지 않는 버그라면, 페이지/어떠한 동작을 할 때 발생했는 지 자세히 적어주세요.\n";
    body += "여러분의 버그 제보는 앱의 퀄리티를 높이는 데 사용됩니다.\n";
    body += "감사합니다.\n";
    body += "==============\n";

    final Email email = Email(
      body: body,
      subject: '[아이택시 버그 제보]',
      recipients: ['22000019@handong.ac.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = "이메일 앱이 없어요";
      String content =
          "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\n22000019@handong.ac.kr";
      mainDialog(context, title, content);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '버그제보',
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
        backgroundColor: colorScheme.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0.h,
            horizontal: 48.0.w,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  mainBody,
                  style: textTheme.headline1!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 10.0.h,
              //     horizontal: 10.0.w,
              //   ),
              //   height: 150.h,
              //   decoration: BoxDecoration(
              //     color: colorScheme.primary,
              //     borderRadius: const BorderRadius.all(
              //       Radius.circular(10),
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: colorScheme.shadow,
              //         offset: const Offset(4.0, 4.0),
              //         blurRadius: 15.0,
              //         spreadRadius: 1.0,
              //       )
              //     ],
              //   ),
              //   child: Text(
              //     mainBody,
              //     style: textTheme.headline1!
              //         .copyWith(color: colorScheme.onPrimary),
              //   ),
              // ),
              SizedBox(
                height: 40.h,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    _sendEmail(context);
                  },
                  // textTheme 적용 해야함
                  child: Text(
                    '문의하기',
                    style: textTheme.subtitle1!.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
