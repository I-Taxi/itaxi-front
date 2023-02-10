import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signUpController.dart';
import 'package:itaxi/settings/privacyPolicyScreen.dart';

import '../settings/termOfServiceScreen.dart';
import '../widget/mainDialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController _signUpController = Get.put(SignUpController());

  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool agree1 = false;
  bool agree2 = false;

  bool emailVerified = false;

  bool _isObscure1 = true;
  bool _isObscure2 = true;

  // Pattern pattern = r'^(?=.*[a-zA-Z]{3,})(?=.*\d{3,})';

  // 문자 숫자 6자 이상
  Pattern pattern = r'^(?=.*[a-zA-Z0-9]{6,})';
  late RegExp regExp;
  final _formKey = GlobalKey<FormState>();

  bool _isValidPhone(String val) {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(val);
  }

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset("assets/arrow/arrow_back_1.png", color: colorScheme.tertiaryContainer, width: 11.62.w, height: 20.51.h)
          ),
        ),
      ),
      backgroundColor: colorScheme.primary,
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
                  vertical: 12.h,
                  horizontal: 24.0.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '회원가입',
                      style: textTheme.subtitle2?.copyWith(
                        color: colorScheme.onTertiary,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    // Custom ID 입력
                    TextFormField(
                      controller: _idController,
                      autocorrect: false,
                      cursorColor: colorScheme.tertiary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                      decoration: InputDecoration(
                        hintText: '아이디 입력',
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        suffixText: '@handong.ac.kr',
                        suffixStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiaryContainer,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        errorStyle: textTheme.bodyText2?.copyWith(
                          color: colorScheme.surfaceVariant,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                      ),
                      onChanged: (value) {
                        _signUpController.customId = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '아이디를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 32.0.h,
                    ),
                    // Password 입력
                    TextFormField(
                      controller: _pwController,
                      autocorrect: false,
                      obscureText: _isObscure1,
                      cursorColor: colorScheme.tertiary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                      decoration: InputDecoration(
                        hintText: '비밀번호 입력',
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiaryContainer,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        errorStyle: textTheme.bodyText2?.copyWith(
                          color: colorScheme.surfaceVariant,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
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
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                      decoration: InputDecoration(
                        hintText: '비밀번호 확인',
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiaryContainer,
                            width: 1.0,
                          ),
                        ),
                        errorStyle: textTheme.bodyText2?.copyWith(
                          color: colorScheme.surfaceVariant,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
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
                    SizedBox(
                      height: 32.0.h,
                    ),
                    // 이름 입력
                    TextFormField(
                      controller: _nameController,
                      autocorrect: false,
                      cursorColor: colorScheme.tertiary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                      decoration: InputDecoration(
                        hintText: '이름',
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiaryContainer,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        errorStyle: textTheme.bodyText2?.copyWith(
                          color: colorScheme.surfaceVariant,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                      ),
                      onChanged: (value) {
                        _signUpController.name = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return '이름을 입력해주세요';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 32.0.h,
                    ),
                    // 휴대폰 번호 입력
                    TextFormField(
                      controller: _phoneController,
                      autocorrect: false,
                      cursorColor: colorScheme.tertiary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onTertiary,
                      ),
                      decoration: InputDecoration(
                        hintText: '전화번호',
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiaryContainer,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.secondary,
                            width: 1.0,
                          ),
                        ),
                        errorStyle: textTheme.bodyText2?.copyWith(
                          color: colorScheme.surfaceVariant,
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.surfaceVariant,
                                width: 1.0
                            )
                        ),
                      ),
                      onChanged: (value) {
                        _signUpController.phone = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return '전화번호를 입력해주세요';
                        else if (!_isValidPhone(value))
                          return '전화번호 형식에 맞게 입력해주세요';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 34.0.h,
                    ),

                    // 이용약관
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 50.w,
                          height: 16.h,
                          child: RawMaterialButton(
                            child: Text(
                              '이용약관',
                              style: textTheme.bodyText2?.copyWith(
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                            onPressed: () {
                              Get.to(TermOfServiceScreen());
                              // Navigate
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '약관에 동의합니다',
                              style: textTheme.bodyText2?.copyWith(
                                color: colorScheme.tertiary,
                              ),
                            ),
                            Checkbox(
                              value: agree1,
                              activeColor: colorScheme.secondary,
                              checkColor: colorScheme.primary,
                              side: BorderSide(
                                color: colorScheme.tertiary,
                              ),
                              onChanged: (value) {
                                setState(
                                  () {
                                    agree1 = !agree1;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 개인정보 처리 방침
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RawMaterialButton(
                          child: Text(
                            '개인정보처리방침',
                            style: textTheme.bodyText2?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                            ),
                          ),
                          onPressed: () {
                            Get.to(PrivacyPolicyScreen());
                            // Navigate
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              '약관에 동의합니다',
                              style: textTheme.bodyText2?.copyWith(
                                color: colorScheme.tertiary,
                              ),
                            ),
                            Checkbox(
                              value: agree2,
                              activeColor: colorScheme.secondary,
                              checkColor: colorScheme.primary,
                              side: BorderSide(
                                color: colorScheme.tertiary,
                              ),
                              onChanged: (value) {
                                setState(
                                  () {
                                    agree2 = !agree2;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // Sign Up 버튼
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: agree1 && agree2 && _formKey.currentState!.validate()
            ? colorScheme.secondary
            : colorScheme.onSurfaceVariant,
        child: InkWell(
          onTap: () {
            if (agree1 && agree2 && _formKey.currentState!.validate()) {
              signUpDialog(context, '메일 인증');
            }
          },
          child: SizedBox(
            height: 94.h,
            width: double.infinity,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: Text(
                  "가입 완료",
                  style:
                      textTheme.bodyText1!.copyWith(color: colorScheme.onTertiaryContainer, fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpDialog(BuildContext context, String? title) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              height: 273.h,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                36.0.w,
                24.0.h,
                36.0.w,
                24.0.h,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    title as String,
                    style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  RichText(
                      text: TextSpan(
                    text:
                        '입력한 이메일 주소로 비밀번호 재설정\n링크를 보내드렸습니다.\n\n메일이 보이지 않는다면, ',
                    style: textTheme.bodyText1
                        ?.copyWith(color: colorScheme.onTertiary),
                    children: <TextSpan>[
                      TextSpan(
                        text: '스팸함',
                        style: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.secondary),
                      ),
                      TextSpan(
                        text: '을 확인해주세요.',
                        style: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.onPrimary),
                      )
                    ],
                  )),
                  // Text(
                  //   '회원가입 시 입력하신 handong.ac.kr 계정으로 인증메일이 보내집니다.\n메일이 오지 않은 경우,',
                  //   style: textTheme.subtitle1?.copyWith(
                  //     color: colorScheme.onPrimary,
                  //   ),
                  // ),
                  const Spacer(),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () async {
                      _signUpController.signUp();
                      Get.back();
                      Get.back();
                    },
                    child: Text(
                      "확인",
                      style: textTheme.subtitle2
                          ?.copyWith(color: colorScheme.tertiaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
