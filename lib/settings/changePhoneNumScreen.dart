import 'dart:async';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';


class FindPhoneNumScreen extends StatefulWidget {
  FindPhoneNumScreen({Key? key}) : super(key: key);

  @override
  State<FindPhoneNumScreen> createState() => _FindPhoneNumScreenState();
}

class _FindPhoneNumScreenState extends State<FindPhoneNumScreen> {
  final UserController _userController = Get.find();


  var data = Get.arguments;
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isValueEmpty = true; // 핸드폰 번호 입력 여부 판별
  late RegExp regExp;

  bool _isValidPhone(String val) {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(val);
  }

  // void initState() {
  //   super.initState();
  //   _phoneController.text = _userController.phone.toString();
  //   _bankController.text = _userController.bank.toString();
  //   _bankAddressController.text = _userController.bankAddress.toString();
  // }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final colorScheme = Theme
        .of(context)
        .colorScheme;


    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset("assets/arrow/arrow_back_1.png", color: colorScheme.tertiaryContainer, width: 11.62.w, height: 20.51.h,)
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.0.h,
                horizontal: 24.0.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('전화번호 변경', style: textTheme.headline2?.copyWith(
                      color: colorScheme.onTertiary,
                  ),),
                  SizedBox(
                    height: 52.0.h,
                  ),
                  // 이메일 입력
                  TextFormField(
                      controller: _phoneController,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                      ),
                      decoration: InputDecoration(
                        hintText: "변경할 전화번호를 입력해주세요",
                        hintStyle: textTheme.bodyText1?.copyWith(
                          color: colorScheme.tertiaryContainer,
                      ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.onPrimary,
                            width: 1.0,
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
                        _userController.phone = '$value';
                        if(value.length > 0 && _isValidPhone(value)){
                          setState(() {
                            isValueEmpty = false;
                          });
                        }
                        else{
                          setState(() {
                            isValueEmpty = true;
                          });
                        }
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
                    height: 59.0.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: isValueEmpty || !_isValidPhone(_phoneController.text) ? colorScheme.tertiaryContainer : colorScheme.secondary,
        child: InkWell(
          onTap: () async{
            if (_formKey.currentState!.validate()) {
              _userController.phone = _phoneController.text;
              showConfirmDialog(context);
              await _userController.fetchNewUsers();
              await _userController.getUsers();
              Get.back();
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
                  '변경 완료',
                  style: textTheme.subtitle1!.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmDialog(context)  {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context)  {
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
      },
    );
  }
}