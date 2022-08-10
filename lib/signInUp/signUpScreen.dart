import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  bool _isObscure1 = true;
  bool _isObscure2 = true;

  // Pattern pattern = r'^(?=.*[a-zA-Z]{3,})(?=.*\d{3,})';
  Pattern pattern = r'^(?=.*[a-zA-Z]{3,})';
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
  void dispose() {
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
          shadowColor: colorScheme.shadow,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            'Sign Up',
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
        backgroundColor: colorScheme.primary,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0.w,
                vertical: 12.h,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '아이디',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // Custom ID 입력
                  TextFormField(
                    controller: _idController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      suffixText: '@handong.ac.kr',
                      suffixStyle: textTheme.subtitle1?.copyWith(
                        color: colorScheme.tertiary,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '비밀번호',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // Password 입력
                  TextFormField(
                    controller: _pwController,
                    autocorrect: false,
                    obscureText: _isObscure1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                      _signUpController.customPw = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '비밀번호를 입력해주세요';
                      regExp = RegExp(pattern.toString());
                      if (!regExp.hasMatch(value)) return '3자 이상의 영어를 사용해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '비밀번호 확인',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // Password 확인 입력
                  TextFormField(
                    autocorrect: false,
                    obscureText: _isObscure2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                      } else if (_signUpController.customPw != value) {
                        return '비밀번호와 같지 않습니다';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '이름',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // 이름 입력
                  TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                      _signUpController.name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '이름을 입력해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '전화번호',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // 휴대폰 번호 입력
                  TextFormField(
                    controller: _phoneController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                      _signUpController.phone = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '전화번호를 입력해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '은행명',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // 은행 입력
                  TextFormField(
                      controller: _bankController,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.tertiary,
                            width: 0.3,
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
                        _signUpController.bank = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return '은행명을 적어주세요';
                        return null;
                      }),
                  SizedBox(
                    height: 12.0.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '계좌번호',
                      style: textTheme.subtitle1?.copyWith(
                        fontSize: 12,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ),
                  // 계좌 입력
                  TextFormField(
                    controller: _bankAddressController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
                          width: 0.3,
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
                      _signUpController.bankAddress = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return '계좌번호를 입력해주세요';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12.0.h,
                  ),

                  // 이용약관
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text(
                          '이용약관 보기',
                          style: textTheme.subtitle1?.copyWith(
                            fontSize: 12,
                            color: colorScheme.tertiary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            '약관에 동의합니다',
                            style: textTheme.subtitle1?.copyWith(
                              fontSize: 12,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text(
                          '개인정보처리방침 보기',
                          style: textTheme.subtitle1?.copyWith(
                            fontSize: 12,
                            color: colorScheme.tertiary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          // Navigate
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            '약관에 동의합니다',
                            style: textTheme.subtitle1?.copyWith(
                              fontSize: 12,
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
                    height: 20.h,
                  ),
                  // Sign Up 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: agree1 & agree2
                          ? colorScheme.secondary
                          : colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: agree1 & agree2
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              _signUpController.signUp();
                            }
                          }
                        : () {},
                    // textTheme 적용 해야함
                    child: Text(
                      '가입하기',
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
    );
  }
}
