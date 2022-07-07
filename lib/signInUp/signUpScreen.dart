import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:itaxi/controller/signInController.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: textTheme.subtitle1,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          // Student ID 입력
          TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Student ID',
                  labelStyle: textTheme.bodyText1
                      ?.copyWith(color: colorScheme.tertiary)),
              onChanged: (value) {
                _signInController.studentId = value;
              },
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Student ID';
                // pattern 변경하면 됨.
                // regExp = RegExp(pattern.toString());
                // if (!regExp.hasMatch(value)) return 'Username is invalid'
                return null;
              }),
          const SizedBox(height: 12.0),

          // Student ID 확인 입력
          TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Student ID Check',
              ),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Student ID one more';
                if (_signInController.studentId != value)
                  return 'Confirm Student ID';
                return null;
              }),
          const SizedBox(height: 12.0),

          // Password 입력
          TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                  labelStyle: textTheme.bodyText1
                      ?.copyWith(color: colorScheme.tertiary)),
              onChanged: (value) {
                _signInController.customPw = value;
              },
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Password';
                // pattern 변경하면 됨.
                // regExp = RegExp(pattern.toString());
                // if (!regExp.hasMatch(value)) return 'Username is invalid'
                return null;
              }),
          const SizedBox(height: 12.0),

          // Password 확인 입력
          TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password Check',
              ),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter Password one more';
                if (_signInController.customPw != value) {
                  return 'Confirm Password';
                }
                return null;
              }),
          const SizedBox(
            height: 12.0,
          ),

          // 이용약관
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RawMaterialButton(
                  child: const Text('이용약관 보기',
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: () {
                    // Navigate
                  },
                ),
                Row(
                  children: [
                    const Text('약관에 동의합니다'),
                    Checkbox(
                        value: _signInController.agree1,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          _signInController.agree1 = !_signInController.agree1;
                        })
                  ],
                ),
              ]),

          // 개인정보 처리 방침
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RawMaterialButton(
                  child: const Text('개인정보처리방침 보기',
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: () {
                    // Navigate
                  },
                ),
                Row(
                  children: [
                    const Text('약관에 동의합니다'),
                    Checkbox(
                        value: _signInController.agree2,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          _signInController.agree2 = !_signInController.agree2;
                        })
                  ],
                ),
              ]),
          const SizedBox(
            height: 20,
          ),

          // Sign Up 버튼
          TextButton(
            // color: Colors.blue,
            // elevation: 0,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(30),
            //     side: BorderSide(
            //       color: Colors.blue,
            //     )),

            // textTheme 적용 해야함
            child: const Text('Sign Up'),
            onPressed: () {
              // SignInController의 SignUp 함수 만들어서 적용.
              // pop
              // Main Screen 또는 SignInScreen으로.
            },
          ),
        ],
      ),
    ));
  }
}
