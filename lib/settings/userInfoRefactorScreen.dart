import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/src/theme.dart';

class UserInfoRefactorScreen extends StatefulWidget {
  const UserInfoRefactorScreen({Key? key}) : super(key: key);

  @override
  _UserInfoRefactorScreenState createState() => _UserInfoRefactorScreenState();
}

class _UserInfoRefactorScreenState extends State<UserInfoRefactorScreen> {
  final UserController _userController = Get.find();

  var data = Get.arguments;

  final _phoneController = TextEditingController();
  final _bankController = TextEditingController();
  final _bankAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.text = _userController.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '내정보 수정',
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0.h,
                  horizontal: 48.0.w,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '새 전화번호',
                        style: textTheme.subtitle1?.copyWith(
                          fontSize: Platform.isIOS ? 14 : 12,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ),
                    // 휴대폰 번호 입력
                    TextFormField(
                        controller: _phoneController,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // initialValue: _userController.phone.toString(),
                        cursorColor: colorScheme.tertiary,
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
                        validator: (value) {
                          if (value!.isEmpty) return '전화번호를 입력해주세요';
                          return null;
                        }),
                    SizedBox(
                      height: 12.0.h,
                    ),

                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     '새 은행명',
                    //     style: textTheme.subtitle1?.copyWith(
                    //       fontSize: Platform.isIOS ? 14 : 12,
                    //       color: colorScheme.tertiary,
                    //     ),
                    //   ),
                    // ),
                    // // 은행 다시 입력
                    // TextFormField(
                    //     controller: _bankController,
                    //     autocorrect: false,
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     // initialValue: _userController.bank,
                    //     cursorColor: colorScheme.tertiary,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: colorScheme.tertiary,
                    //           width: 0.3,
                    //         ),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: colorScheme.secondary,
                    //           width: 1.0,
                    //         ),
                    //       ),
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) return '은행명을 입력해주세요';
                    //       return null;
                    //     }),
                    // SizedBox(
                    //   height: 12.0.h,
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     '새 계좌번호',
                    //     style: textTheme.subtitle1?.copyWith(
                    //       fontSize: Platform.isIOS ? 14 : 12,
                    //       color: colorScheme.tertiary,
                    //     ),
                    //   ),
                    // ),
                    // // 은행 계좌 입력
                    // TextFormField(
                    //     controller: _bankAddressController,
                    //     autocorrect: false,
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     // initialValue: _userController.bankAddress,
                    //     cursorColor: colorScheme.tertiary,
                    //     decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: colorScheme.tertiary,
                    //           width: 0.3,
                    //         ),
                    //       ),
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: colorScheme.secondary,
                    //           width: 1.0,
                    //         ),
                    //       ),
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) return '계좌번호를 입력해주세요';
                    //       return null;
                    //     }),
                    // SizedBox(
                    //   height: 52.0.h,
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _userController.phone = _phoneController.text;
                          // _userController.bank = _bankController.text;
                          // _userController.bankAddress = _bankAddressController.text;
                          await _userController.fetchNewUsers();
                          await _userController.getUsers();
                          Get.back();
                        }
                      },
                      child: Text(
                        '수정완료',
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
      ),
    );
  }
}


