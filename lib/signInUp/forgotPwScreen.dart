import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/src/theme.dart';

class ForgotPwScreen extends StatefulWidget {
  ForgotPwScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  SignInController _signInController = Get.find();


  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isValueEmpty = true; //입력값이 있는 판별


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final colorScheme = Theme
        .of(context)
        .colorScheme;


    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '비밀번호 재설정',
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
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 39.0.h,
                  horizontal: 63.0.w,
                ),
                child: Column(
                  children: [
                  Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '회원가입 시 입력한 본인의 이메일을\n입력해주세요.\n\n해당 이메일을 통해 비밀번호\n재설정 링크를 받으실 수 있습니다.',
                    style: textTheme.subtitle1?.copyWith(
                      fontSize: 16,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 72.0.h,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '이메일',
                    style: textTheme.subtitle1?.copyWith(
                      fontSize: Platform.isIOS ? 14 : 12,
                      color: colorScheme.onPrimary,
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
                        color: colorScheme.onPrimary,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.onPrimary,
                          width: 1.0,
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
                      if(value.length > 0){
                        setState(() {
                          isValueEmpty = false;
                        });
                      }
                      else{
                        setState(() {
                          isValueEmpty = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 59.0.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: isValueEmpty ? colorScheme.tertiary : colorScheme.secondary,
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
    ),);
  }

  void showConfirmDialog(context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Container(
            width: 312.w,
            height: 262.h,
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
                  height: 32.h,
                ),
                Text(
                  '가입한 메일 확인 후,\n스팸함을 확인해주세요',
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
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
