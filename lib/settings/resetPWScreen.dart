import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signUpController.dart';

class ResetPWScreen extends StatefulWidget {
  ResetPWScreen({Key? key}) : super(key: key);

  @override
  State<ResetPWScreen> createState() => _ResetPWScreenState();
}

class _ResetPWScreenState extends State<ResetPWScreen> {
  SignUpController _signUpController = Get.find();


  final _pwController = TextEditingController();

  Pattern pattern = r'^(?=.*[a-zA-Z0-9]{6,})';
  late RegExp regExp;

  final _formKey = GlobalKey<FormState>();
  bool isValueEmpty = true; // 비밀번호 입력 여부 판별

  bool _isObscure1 = true;
  bool _isObscure2 = true;


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
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset("assets/arrow/arrow_back_1.png", color: colorScheme.tertiaryContainer, width: 11.62.w, height: 20.51.h,)
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.0.h,
                horizontal: 24.0.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('비밀번호 재설정', style: textTheme.headline2?.copyWith(
                      color: colorScheme.onTertiary,
                  ),),
                  SizedBox(
                    height: 52.0.h,
                  ),
                  // 이메일 입력
                  TextFormField(
                    controller: _pwController,
                    autocorrect: false,
                    obscureText: _isObscure1,
                    cursorColor: colorScheme.tertiary,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '비밀번호 입력',
                      hintStyle: textTheme.subtitle1?.copyWith(
                        fontSize: Platform.isIOS ? 14 : 12,
                        color: colorScheme.tertiary,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.secondary,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20.h,
                          color: colorScheme.tertiary,
                        ),
                        onPressed: () {
                          setState(
                                () {
                              _isObscure1 = !_isObscure1;
                            },
                          );
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _signUpController.customPw = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '비밀번호를 입력해주세요';
                      regExp = RegExp(pattern.toString());
                      if (!regExp.hasMatch(value))
                        return '문자와 숫자 6자리 이상 사용해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 32.0.h,
                  ),
                  // Password 확인 입력
                  TextFormField(
                    autocorrect: false,
                    obscureText: _isObscure2,
                    cursorColor: colorScheme.tertiary,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '비밀번호 확인',
                      hintStyle: textTheme.subtitle2?.copyWith(
                        color: colorScheme.tertiary,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.secondary,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20.h,
                          color: colorScheme.tertiary,
                        ),
                        onPressed: () {
                          setState(
                                () {
                              _isObscure2 = !_isObscure2;
                            },
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '비밀번호를 한 번 더 입력해주세요';
                      } else if (_signUpController.customPw != value) {
                        return '비밀번호와 같지 않습니다';
                      }
                      return null;
                    },
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     elevation: 0,
                  //     backgroundColor: isValueEmpty ? colorScheme.tertiary : colorScheme.secondary,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   ),
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       showConfirmDialog(context);
                  //     }
                  //   },
                  //   child: Text(
                  //     '완료',
                  //     style: textTheme.subtitle1!.copyWith(
                  //       color: colorScheme.primary,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: isValueEmpty ? colorScheme.tertiaryContainer : colorScheme.secondary,
        child: InkWell(
          onTap: () async{

            if (_formKey.currentState!.validate()) {
              showConfirmDialog(context);
            }
          },
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                "이메일로 재설정 링크 받기",
                style: textTheme.subtitle1!.copyWith(
                    color: colorScheme.onPrimary
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
              36.0.w,
              24.0.h,
              36.0.w,
              28.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "메일이 전송되었습니다",
                  style: textTheme.headline1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '입력한 이메일 주소로 비밀번호 재설정 링크를 보내드렸습니다.',
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                RichText(
                  text: TextSpan(
                      text: "메일이 보이지 않는다면, ",
                      style: textTheme.subtitle1?.copyWith(
                          color: colorScheme.onPrimary
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "스팸함을\n", style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.secondary
                        )),
                        TextSpan(
                            text: "확인해주세요", style: textTheme.subtitle1?.copyWith(
                            color: colorScheme.onPrimary
                        )
                        )
                      ]
                  ),
                ),

                const Spacer(),
                TextButton(
                  onPressed: () async {
                    // await _signInController.sendPasswordResetEmailByKorean();
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