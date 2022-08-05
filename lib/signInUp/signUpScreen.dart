import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:itaxi/controller/signUpController.dart';

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
  final _bankController = TextEditingController();
  final _bankAddressController = TextEditingController();

  bool agree1 = false;
  bool agree2 = false;

  bool emailVerified = false;


  Pattern pattern = r'^(?=.*[a-zA-Z]{3,})(?=.*\d{3,})';
  late RegExp regExp;
  final _formKey = GlobalKey<FormState>();

  bool _isValidPhone(String val) {
    return RegExp(r'^010\d{7,8}$').hasMatch(val);
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
  void dispose(){
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Sign Up',
              style: textTheme.subtitle1,
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                // Student ID 입력
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200.0.w,
                        child: TextFormField(
                            controller: _idController,
                            autocorrect: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                filled: true,
                                labelText: 'Student ID',
                                labelStyle: textTheme.bodyText1
                                    ?.copyWith(color: colorScheme.tertiary)),
                            onChanged: (value) {
                              _signUpController.customId = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) return 'Please enter Student ID';
                              // pattern 변경하면 됨.
                              // regExp = RegExp(pattern.toString());
                              // if (!regExp.hasMatch(value)) return 'Username is invalid'
                              return null;
                            }),
                      ),
                      SizedBox(width: 10.0,),
                      Container(
                        child: Text("@ handong.ac.kr", style: textTheme.subtitle1,),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                // Student ID 확인 입력
                // TextFormField(
                //     autocorrect: false,
                //     obscureText: true,
                //     decoration: const InputDecoration(
                //       filled: true,
                //       labelText: 'Student ID Check',
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) return 'Please enter Student ID one more';
                //       if (_signInController.studentId != value)
                //         return 'Confirm Student ID';
                //       return null;
                //     }),
                // const SizedBox(height: 12.0),

                // Password 입력
                TextFormField(
                  controller: _pwController,
                    autocorrect: false,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Password',
                        labelStyle: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary)),
                    onChanged: (value) {
                    print(value);
                      _signUpController.customPw = value;
                      print(_signUpController.customPw);
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Password Check',
                      labelStyle: textTheme.bodyText1?.copyWith(color: colorScheme.tertiary)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter Password one more';
                      if (_signUpController.customPw != value) {
                        return 'Confirm Password';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 12.0,
                ),

                // 이름 입력
                TextFormField(
                    controller: _nameController,
                    autocorrect: false,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Name',
                        labelStyle: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary)),
                    onChanged: (value) {
                      print(value);
                      _signUpController.name = value;
                      // print(_signUpController.customPw);
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter Name';
                      // pattern 변경하면 됨.
                      // regExp = RegExp(pattern.toString());
                      // if (!regExp.hasMatch(value)) return 'Username is invalid'
                      return null;
                    }),
                const SizedBox(height: 12.0),

                // 휴대폰 번호 입력
                TextFormField(
                    controller: _phoneController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Phone Number',
                        labelStyle: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary)),
                    onChanged: (value) {
                      _signUpController.phone = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter Phone Number';
                      // pattern 변경하면 됨.
                      // regExp = RegExp(pattern.toString());
                      // if (!regExp.hasMatch(value)) return 'Username is invalid'
                      return null;
                    }),
                const SizedBox(height: 12.0),

                // 은행 입력
                TextFormField(
                    controller: _bankController,
                    autocorrect: false,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Student Bank',
                        labelStyle: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary)),
                    onChanged: (value) {
                      _signUpController.bank = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter Student Bank';
                      // pattern 변경하면 됨.
                      // regExp = RegExp(pattern.toString());
                      // if (!regExp.hasMatch(value)) return 'Username is invalid'
                      return null;
                    }),
                const SizedBox(height: 12.0),

                // 계좌 입력
                TextFormField(
                    controller: _bankAddressController,
                    autocorrect: false,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Student BankAddress',
                        labelStyle: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary)),
                    onChanged: (value) {
                      _signUpController.bankAddress = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter Student Bank Address';
                      // pattern 변경하면 됨.
                      // regExp = RegExp(pattern.toString());
                      // if (!regExp.hasMatch(value)) return 'Username is invalid'
                      return null;
                    }),
                const SizedBox(height: 12.0),

                // 이용약관
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text('이용약관 보기', style: textTheme.bodyText1!.copyWith(fontSize: 15.0.sp, decoration: TextDecoration.underline),
                            ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text('약관에 동의합니다', style: textTheme.bodyText1!.copyWith(fontSize: 14.0.sp),),
                          Checkbox(
                              value: agree1,
                              activeColor: colorScheme.secondary,
                              onChanged: (value) {
                                setState(() {
                                  agree1 = !agree1;
                                });
                              })
                        ],
                      ),
                    ]),

                // 개인정보 처리 방침
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text('개인정보처리방침 보기',
                            style: textTheme.bodyText1!.copyWith(fontSize: 15.0.sp, decoration: TextDecoration.underline),
                            ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text('약관에 동의합니다', style: textTheme.bodyText1!.copyWith(fontSize: 14.0.sp)),
                          Checkbox(
                              value: agree2,
                              activeColor: colorScheme.secondary,
                              onChanged: (value) {
                                setState((){
                                  agree2 = !agree2;
                                });
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
                  style: TextButton.styleFrom(
                    backgroundColor: agree1 & agree2 ? colorScheme.tertiary : colorScheme.shadow,
                  ),
                  // textTheme 적용 해야함
                  child: Text(
                    'Sign Up',
                    style: textTheme.subtitle1!.copyWith(color: agree1 & agree2 ? colorScheme.onPrimary : colorScheme.tertiary),
                  ),
                  onPressed: agree1 & agree2 ? () {
                    if(_formKey.currentState!.validate()){
                      _signUpController.signUp();
                    }
                  } : () {},
                ),
              ],
            ),
          ),
        ));
  }
}


