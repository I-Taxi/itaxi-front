import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/signInUp/signUpScreen.dart';
import 'package:itaxi/signInUp/forgotPwScreen.dart';
import 'package:itaxi/timeline/checkPlaceScreen.dart';

import '../widget/mainDialog.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController _signInController = Get.put(SignInController());

  static final storage = new FlutterSecureStorage();

  // 자동로그인 on/off
  bool _rememberId = false;

  // 텍스트필드 숨김 on/off
  bool _isObscure = true;

  //로그인 버튼 색깔 id, pw 입력시 변경
  bool idEmpty = true;
  bool pwEmpty = true;

  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  Pattern pattern = r'^(?=.*[a-zA-Z]{3,})(?=.*\d{3,})';
  late RegExp regExp;
  final _formKey = GlobalKey<FormState>();

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   FlutterNativeSplash.remove();
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.secondary,
      body: ColorfulSafeArea(
        color: colorScheme.secondary,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 130.5.h, horizontal: 63.w),
                child: Column(
                  children: [
                    // 로고 이미지
                    Image.asset(
                      width: 110.w,
                      height: 122.h,
                      'assets/logo_text.png',
                    ),
                    // 로고 글씨
                    SizedBox(
                      height: 71.0.h,
                    ),

                    // Custom ID 입력
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '아이디',
                        style: textTheme.bodyText2?.copyWith(color: colorScheme.primary)
                      ),
                    ),
                    TextFormField(
                      controller: _idController,
                      autocorrect: false,
                      style: textTheme.bodyText2?.copyWith(
                        color: colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        suffixText: '@handong.ac.kr',
                        suffixStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.primary,
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 36.h,
                          maxWidth: 280.w,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        _signInController.id = '$value@handong.ac.kr';
                        if (value.isNotEmpty) {
                          setState(() {
                            idEmpty = false;
                          });
                        } else {
                          setState(() {
                            idEmpty = true;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 14.0.h,
                    ),

                    // Custom PW 입력
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '비밀번호',
                        style: textTheme.bodyText2?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _pwController,
                      autocorrect: false,
                      obscureText: _isObscure,
                        style: textTheme.bodyText2?.copyWith(
                        color: colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          suffixText: '',
                          constraints: BoxConstraints(
                            maxHeight: 36.h,
                            maxWidth: 280.w,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.primary,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: colorScheme.primary,
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                              size: 20.h,
                              color: colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _isObscure = !_isObscure;
                                },
                              );
                            },
                          ),
                        ),
                        onChanged: (value) {
                          _signInController.pw = value;
                          if (value.isNotEmpty) {
                            setState(() {
                              pwEmpty = false;
                            });
                          } else {
                            setState(() {
                              pwEmpty = true;
                            });
                          }
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '자동 로그인',
                          style: textTheme.bodyText2!.copyWith(
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ),
                        Checkbox(
                          value: _rememberId,
                          activeColor: colorScheme.primary,
                          checkColor: colorScheme.secondary,
                          side: BorderSide(
                            color: colorScheme.primary,
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _rememberId = !_rememberId;
                              },
                            );
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(ForgotPwScreen()); //ForgotPwScreen가 ()안에 있었음
                          },
                          child: Text(
                            '비밀번호 찾기',
                            style: textTheme.bodyText2!.copyWith(
                              color: colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 63.0.h,
                    ),

                    // Sign In 버튼
                    Container(
                      width: 109.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await _signInController.signIn();
                          setState(() {
                            if (_signInController.num == 0) {
                              return mainDialog(context, '이메일 인증 오류',
                                  '인증 이메일을 확인해주시기 바랍니다.\n받은편지함에 없는 경우, 스팸함을 확인해주세요.');
                            } else if (_signInController.num == 1) {
                              return mainDialog(context, '등록되지 않은 이메일',
                                  '등록되지 않은 이메일입니다.\n혹시 인증 이메일이 만료되었다면 itaxi.cra.handong@gmail.com로 메일 보내주세요.');
                            } else if (_signInController.num == 2) {
                              return mainDialog(context, '비밀번호 오류',
                                  '비밀번호가 틀립니다.\n비밀번호를 다시 확인해주세요.');
                            } else if (_signInController.num == 3) {
                              return mainDialog(context, '아이디와 비밀번호 입력',
                                  '아이디와 비밀번호를 입력해주세요.');
                            } else if (_signInController.num == 4) {
                              return mainDialog(
                                  context, '네트워크 오류', '네트워크 연결을 확인해주세요');
                            }
                          });

                          _rememberId
                              ? await storage.write(
                                  key: "login",
                                  value:
                                      "id ${_idController.text}@handong.ac.kr password ${_pwController.text}")
                              : () {};
                        },
                        child: Text(
                          '로그인',
                          style: textTheme.bodyText1!.copyWith(
                            color: (pwEmpty || idEmpty) ? colorScheme.tertiary : colorScheme.secondary, //수정해야 됨.
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignUpScreen());
                      },
                      child: Text(
                        '회원가입',
                        style: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onTertiaryContainer,
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
}
