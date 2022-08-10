import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/src/theme.dart';

class ForgotPwScreen extends StatelessWidget {
  ForgotPwScreen({Key? key}) : super(key: key);

  SignInController _signInController = Get.find();

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            '비밀번호 재설정',
            style: ITaxiTheme.textTheme.subtitle1?.copyWith(
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
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0.h,
                  horizontal: 48.0.w,
                ),
                child: Column(
                  children: [
                    Text(
                      '회원가입 시 입력한 본인의 이메일을 입력해주세요.\n해당 이메일을 통해 비밀번호 재설정 링크를 받으실 수 있습니다.',
                      style: textTheme.subtitle1?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '이메일',
                        style: textTheme.subtitle1?.copyWith(
                          fontSize: 12,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                    // 이메일 입력
                    TextFormField(
                        controller: _emailController,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          suffixText: '@handong.ac.kr',
                          suffixStyle: textTheme.subtitle1?.copyWith(
                            color: colorScheme.tertiary,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.tertiary,
                              width: 0.3,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.secondary,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _signInController.email = '$value@handong.ac.kr';
                        },
                        validator: (value) {
                          if (value!.isEmpty) return '이메일을 입력해주세요';
                          return null;
                        }),
                    SizedBox(
                      height: 52.0.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showConfirmDialog(context);
                        }
                      },
                      child: Text(
                        '완료',
                        style: textTheme.subtitle1!.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmDialog(context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Container(
            width: 360.w,
            height: 200.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              28.0.w,
              32.0.h,
              28.0.w,
              12.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "메일이 오지 않았다면?",
                  style: textTheme.headline1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  '기입한 메일 확인 후, 스팸함을 확인해주세요',
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await _signInController.sendPasswordResetEmailByKorean();
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    "확인",
                    style: textTheme.headline1
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
