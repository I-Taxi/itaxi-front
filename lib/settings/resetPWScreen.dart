import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signUpController.dart';
import 'package:itaxi/controller/userController.dart';

class ResetPWScreen extends StatefulWidget {
  ResetPWScreen({Key? key}) : super(key: key);

  @override
  State<ResetPWScreen> createState() => _ResetPWScreenState();
}

class _ResetPWScreenState extends State<ResetPWScreen> {
  UserController _userController = Get.put(UserController());

  final _pwController = TextEditingController();

  Pattern pattern = r'^(?=.*[a-zA-Z0-9]{6,})';
  late RegExp regExp;
  String pw = "";

  final _formKey = GlobalKey<FormState>();
  bool isValueEmpty = true; // 비밀번호 입력 여부 판별

  bool _isObscure1 = true;
  bool _isObscure2 = true;

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              "assets/arrow/arrow_back_1.png",
              color: colorScheme.tertiaryContainer,
              width: 11.62.w,
              height: 20.51.h,
            )),
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
                  Text(
                    '비밀번호 변경',
                    style: textTheme.headline2?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
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
                      hintText: '새로운 비밀번호를 입력해주세요',
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiary,
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
                      errorBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.surfaceVariant, width: 1.0)),
                      focusedErrorBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.surfaceVariant, width: 1.0)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure1 ? Icons.visibility_off : Icons.visibility,
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
                      pw = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value == null) return '비밀번호를 입력해주세요';
                      regExp = RegExp(pattern.toString());
                      if (!regExp.hasMatch(value)) return '문자와 숫자 6자리 이상 사용해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 33.0.h,
                  ),
                  // Password 확인 입력
                  TextFormField(
                    autocorrect: false,
                    obscureText: _isObscure2,
                    cursorColor: colorScheme.tertiary,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '다시 한 번 입력해주세요',
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiary,
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
                      errorBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.surfaceVariant, width: 1.0)),
                      focusedErrorBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.surfaceVariant, width: 1.0)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure2 ? Icons.visibility_off : Icons.visibility,
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
                      } else if (pw != value) {
                        return '비밀번호와 같지 않습니다';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: _formKey.currentState != null && _formKey.currentState!.validate()
            ? colorScheme.secondary
            : colorScheme.onSurfaceVariant,
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
              print(pw);
              FirebaseAuthException? exception = await _userController.changePassword(pw);
              showConfirmDialog(context, exception);
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
                  '추가 완료',
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: Platform.isIOS ? 19 : 17,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showConfirmDialog(context, FirebaseAuthException? exception) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
          Get.back();
          Get.back();
        });
        if (exception == null) {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              width: 312.w,
              height: 172.h,
              child: Center(
                child: Text(
                  "변경이 완료되었습니다.",
                  style: textTheme.headline3?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              width: 312.w,
              height: 172.h,
              child: Center(
                child: Text(
                  "비밀번호 변경에 실패했습니다. 비밀번호를 다시\n확인해 주세요.",
                  style: textTheme.headline3?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
