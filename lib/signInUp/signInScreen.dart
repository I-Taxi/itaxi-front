// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/signInUp/signUpScreen.dart';
import 'package:itaxi/src/theme.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  SignInController _signInController = Get.put(SignInController());

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
              const SizedBox(
                height: 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로고 이미지
                  Image.asset(
                    width: 88.0,
                    'assets/logo_blue.png',
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
                          // color: colorScheme.secondary,
                        ),
                      ),
                      Text('Powered by CRA', style: textTheme.headline1
                          // ?.copyWith(color: colorScheme.secondary),
                          ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 60.0,
              ),

              // Custom ID 입력
              TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: 'Your custom ID',
                      labelText: 'Custom ID',
                      labelStyle: textTheme.subtitle1,
                      // ?.copyWith(color: colorScheme.tertiary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: colorScheme.secondary, width: 1.0),
                      )),
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
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Your custom PW',
                      labelText: 'Custom PW',
                      labelStyle: textTheme.subtitle1
                      // ?.copyWith(color: colorScheme.tertiary)
                      ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Custom PW';
                    return null;
                  }),

              Row(
                children: [
                  Text(
                    'Remember ID',
                    style: textTheme.subtitle1,
                  ),
                  Checkbox(value: false, onChanged: (value) {}),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot PW?',
                        style: textTheme.subtitle1,
                      ))
                ],
              ),
              const SizedBox(
                height: 60.0,
              ),

              // Sign In 버튼
              TextButton(
                  onPressed: () {
                    _signInController.signIn();
                  },
                  child: Text(
                    'Sign In',
                    style: textTheme.headline2,
                  )),
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
