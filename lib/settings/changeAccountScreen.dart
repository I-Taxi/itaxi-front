import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/userController.dart';

class ChangeAccountScreen extends StatefulWidget {
  ChangeAccountScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAccountScreen> createState() => _ChangeAccountScreenState();
}

class _ChangeAccountScreenState extends State<ChangeAccountScreen> {
  final UserController _userController = Get.find();

  var data = Get.arguments;
  final _bankController = TextEditingController();
  final _bankAddressController = TextEditingController();
  final _bankOwnerNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isBankEmpty = true;
  bool isBankAddressEmpty = true;
  bool isBankOwnerNameEmpty = true;

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
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.0.h,
                horizontal: 24.0.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('계좌번호 변경', style: textTheme.headline2?.copyWith(
                      color: colorScheme.onTertiary,
                  ),),
                  SizedBox(
                    height: 52.0.h,
                  ),
                  // 이메일 입력
                  TextFormField(
                    controller: _bankController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '변경할 계좌번호를 입력해주세요',
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
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
                      _userController.bank = _bankController.text;
                      if(value.length > 0){
                        setState(() {
                          isBankEmpty = false;
                        });
                      }
                      else{
                        setState(() {
                          isBankEmpty = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '계좌번호를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  TextFormField(
                    controller: _bankAddressController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '해당 계좌 은행을 입력해주세요',
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
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
                      _userController.bankAddress = _bankAddressController.text;
                      if(value.length > 0){
                        setState(() {
                          isBankAddressEmpty = false;
                        });
                      }
                      else{
                        setState(() {
                          isBankAddressEmpty = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '계좌 은행을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  TextFormField(
                    controller: _bankOwnerNameController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '예금주를 입력해주세요',
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiaryContainer,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.tertiary,
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
                      if(value.length > 0){
                        setState(() {
                          isBankOwnerNameEmpty = false;
                        });
                      }
                      else{
                        setState(() {
                          isBankOwnerNameEmpty = true;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '예금주를 다시 입력해주세요';
                      }
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
        color: isBankEmpty || isBankAddressEmpty || isBankOwnerNameEmpty ? colorScheme.tertiaryContainer : colorScheme.secondary,
        child: InkWell(
          onTap: () async{
            if (!isBankEmpty && !isBankAddressEmpty && !isBankOwnerNameEmpty) {
              _userController.bank = _bankController.text;
              _userController.bankAddress = _bankAddressController.text;
              await _userController.fetchNewUsers();
              await _userController.getUsers();
              showConfirmDialog(context);
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

  // Widget _accountInfo({
  //   required String hintTitle,
  //   required String errorTitle,
  //   required controller,
  //   required BuildContext context,
  // }) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final textTheme = Theme.of(context).textTheme;
  //   return Column(
  //     children: [
  //       TextFormField(
  //         controller: controller,
  //         autocorrect: false,
  //         autovalidateMode: AutovalidateMode.onUserInteraction,
  //         decoration: InputDecoration(
  //           hintText: hintTitle,
  //           hintStyle: textTheme.bodyText1?.copyWith(
  //               color: colorScheme.tertiaryContainer,
  //           ),
  //           enabledBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(
  //               color: colorScheme.onTertiary,
  //               width: 1.0,
  //             ),
  //           ),
  //           focusedBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(
  //               color: colorScheme.secondary,
  //               width: 1.0,
  //             ),
  //           ),
  //         ),
  //         onChanged: (value) {
  //
  //         },
  //         validator: (value) {
  //           if (value!.isEmpty)
  //             return errorTitle;
  //           return null;
  //         },
  //       ),
  //       SizedBox(
  //         height: 18.5.h,
  //       ),
  //     ],
  //   );
  // }

  void showConfirmDialog(context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            width: 312.w,
            height: 262.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              46.0.w,
              68.0.h,
              46.0.w,
              68.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "변경이 완료되었습니다.",
                  style: textTheme.headline1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}