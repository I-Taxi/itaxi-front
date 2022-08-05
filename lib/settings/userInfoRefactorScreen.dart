import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/src/theme.dart';

import 'myInfoScreen.dart';


class UserInfoRefactorScreen extends StatefulWidget {
  const UserInfoRefactorScreen({Key? key}) : super(key: key);

  @override
  _UserInfoRefactorScreenState createState() => _UserInfoRefactorScreenState();
}

class _UserInfoRefactorScreenState extends State<UserInfoRefactorScreen> {
  final _phoneController = TextEditingController();
  final _bankController = TextEditingController();
  final _bankAddressController = TextEditingController();
  
  UserController _userController = Get.put(UserController());

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '내정보 수정',
            style: ITaxiTheme.textTheme.subtitle1,
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            children: [
              // 휴대폰 번호 입력
              TextFormField(
                  controller: _phoneController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '휴대폰 번호',
                      labelStyle: textTheme.bodyText1
                          ?.copyWith(color: colorScheme.tertiary)),
                  onChanged: (value) {
                    _userController.phone = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Phone-number';
                    // pattern 변경하면 됨.
                    // regExp = RegExp(pattern.toString());
                    // if (!regExp.hasMatch(value)) return 'Username is invalid'
                    return null;
                  }),
              const SizedBox(height: 12.0),

              // 은행 다시 입력
              TextFormField(
                  controller: _bankController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '계좌',
                      labelStyle: textTheme.bodyText1
                          ?.copyWith(color: colorScheme.tertiary)),
                  onChanged: (value) {
                    _userController.bank = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Bank';
                    // pattern 변경하면 됨.
                    // regExp = RegExp(pattern.toString());
                    // if (!regExp.hasMatch(value)) return 'Username is invalid'
                    return null;
                  }),
              const SizedBox(height: 12.0),

              // 은행 계좌 입력
              TextFormField(
                  controller: _bankAddressController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '계좌 번호',
                      labelStyle: textTheme.bodyText1
                          ?.copyWith(color: colorScheme.tertiary)),
                  onChanged: (value) {
                    _userController.bankAddress = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Bank Address';
                    // pattern 변경하면 됨.
                    // regExp = RegExp(pattern.toString());
                    // if (!regExp.hasMatch(value)) return 'Username is invalid'
                    return null;
                  }),
              SizedBox(height: 50.0.h),
              SizedBox(
                width: 104.w,
                height: 40.h,
                child: TextButton(
                  child: Text("완료", style: textTheme.headline2!.copyWith(color: colorScheme.secondary),),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await _userController.fetchNewUsers();
                      await _userController.getUsers();
                      Get.back();
                    }
                    // Get.to(UserInfoRefactorScreen());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
