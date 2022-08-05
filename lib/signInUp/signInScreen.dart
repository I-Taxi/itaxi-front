// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/signInUp/signUpScreen.dart';
import 'package:itaxi/src/theme.dart';

import 'forgotPwScreen.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _signInController.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 169.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 로고 이미지
                      Image.asset(
                        width: 88.0,
                        'assets/logo_1.png',
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),

                      // 로고 글씨
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'iTaxi',
                            style: TextStyle(
                              fontSize: 36.0,
                              color: colorScheme.secondary,
                            ),
                          ),
                          Text('Powered by CRA', style: textTheme.headline1!.copyWith(color: colorScheme.secondary)
                            // ?.copyWith(color: colorScheme.secondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.0.h,
                  ),

                  // Custom ID 입력
                  TextFormField(
                      controller: _idController,
                      autocorrect: false,
                      decoration: InputDecoration(
                          hintText: 'Your custom ID',
                          labelText: 'Custom ID',
                          labelStyle: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.secondary, width: 1.0),
                          )),
                      onChanged: (value) {
                        _signInController.id = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter Custom ID';
                        // pattern 변경하면 됨.
                        // regExp = RegExp(pattern.toString());
                        // if (!regExp.hasMatch(value)) return 'Username is invalid'
                        return null;
                      }),
                  const SizedBox(height: 12.0),

                  // Custom PW 입력
                  TextFormField(
                      controller: _pwController,
                      autocorrect: false,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          hintText: 'Your custom PW',
                          labelText: 'Custom PW',
                          labelStyle: textTheme.subtitle1?.copyWith(color: colorScheme.tertiary),
                          suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure ? Icons.visibility : Icons.visibility_off,
                                color: colorScheme.tertiary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })
                      ),
                      onChanged: (value) {
                        _signInController.pw = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter Custom PW';
                        return null;
                      }),

                  Row(
                    children: [
                      Text(
                        'Remember ID',
                        style: textTheme.subtitle1!.copyWith(color: colorScheme.tertiary),
                      ),
                      Checkbox(
                          value: _rememberId,
                          activeColor: colorScheme.secondary,
                          onChanged: (value) {
                        setState(() {
                          _rememberId = !_rememberId;
                        });
                      }),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.to(ForgotPwScreen());
                          },
                          child: Text(
                            'Forgot PW?',
                            style: textTheme.subtitle1!.copyWith(color: colorScheme.tertiary),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 60.0.h,
                  ),

                  // Sign In 버튼
                  Container(
                    width: 128.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    // color: colorScheme.secondary,
                    child: TextButton(
                        onPressed: () async {
                          print("hi");
                          _rememberId ? await storage.write(
                              key: "login",
                              value: "id " +
                                  _idController.text.toString() +
                                  " " +
                                  "password " +
                                  _pwController.text.toString())
                          : () {};
                          print("hello");
                          await _signInController.signIn();
                        },
                        child: Text(
                          'Sign In',
                          style: textTheme.headline2!.copyWith(color: colorScheme.primary),
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                        // _signInController.signIn();
                      },
                      child: Text(
                        'Sign Up',
                        style: textTheme.headline2,
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

