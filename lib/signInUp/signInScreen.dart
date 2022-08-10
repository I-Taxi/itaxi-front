import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/signInUp/signUpScreen.dart';

import 'package:itaxi/signInUp/forgotPwScreen.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _signInController.onInit();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.secondary,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 140.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 로고 이미지
                      Image.asset(
                        width: 88.0.w,
                        height: 60.h,
                        'assets/logo_2.png',
                      ),
                      SizedBox(
                        width: 12.0.w,
                      ),

                      // 로고 글씨
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'iTaxi',
                            style: textTheme.headline2?.copyWith(
                              fontSize: 36.sp,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Powered by CRA',
                            style: textTheme.headline1!.copyWith(
                              fontSize: 16.sp,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 66.0.h,
                  ),

                  // Custom ID 입력
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '아이디',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _idController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      suffixText: '@handong.ac.kr',
                      suffixStyle: textTheme.subtitle1?.copyWith(
                        color: colorScheme.primary,
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 36.h,
                        maxWidth: 280.w,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 0.3,
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
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '아이디를 입력해주세요';
                      return null;
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
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _pwController,
                    autocorrect: false,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      suffixText: '',
                      constraints: BoxConstraints(
                        maxHeight: 36.h,
                        maxWidth: 280.w,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 0.3,
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
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '비밀번호를 입력해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '자동 로그인',
                        style: textTheme.subtitle1!.copyWith(
                          fontSize: 12,
                          color: colorScheme.primary,
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
                          Get.to(const ForgotPwScreen());
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: textTheme.subtitle1!.copyWith(
                            fontSize: 12,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 64.0.h,
                  ),

                  // Sign In 버튼
                  Container(
                    width: 128.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        _rememberId
                            ? await storage.write(
                                key: "login",
                                value:
                                    "id ${_idController.text}@handong.ac.kr password ${_pwController.text}")
                            : () {};
                        await _signInController.signIn();
                      },
                      child: Text(
                        '로그인',
                        style: textTheme.headline1!.copyWith(
                          fontSize: 14,
                          color: colorScheme.secondary,
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
                      style: textTheme.headline1?.copyWith(
                        fontSize: 14,
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
    );
  }
}
