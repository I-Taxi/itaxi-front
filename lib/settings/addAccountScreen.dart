import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/main/screen/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddAccountScreen extends StatefulWidget {
  AddAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {

  var data = Get.arguments;
  final _bankController = TextEditingController();
  final _bankAddressController = TextEditingController();
  final _bankOwnerNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isBankEmpty = true;
  bool isBankAddressEmpty = true;
  bool isBankOwnerNameEmpty = true;

  static final storage = new FlutterSecureStorage(); //flutter_secure_storage

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
          icon: Image.asset("assets/arrow/back_short.png", color: colorScheme.tertiary, width: 11.62.w, height: 20.51.h,)
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
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('계좌번호 추가', style: textTheme.headline2?.copyWith(
                    color: colorScheme.onTertiary,
                  ),),
                  SizedBox(
                    height: 52.0.h,
                  ),
                  //계좌 번호 입력
                  TextFormField(
                    controller: _bankAddressController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.tertiaryContainer,
                    ),
                    decoration: InputDecoration(
                      hintText: '추가할 계좌번호를 입력해주세요',
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
                        return '계좌번호를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  //계좌 은행 입력
                  TextFormField(
                    controller: _bankController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.tertiaryContainer,
                    ),
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
                        return '계좌 은행을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  //예금주 입력
                  TextFormField(
                    controller: _bankOwnerNameController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: textTheme.bodyText1?.copyWith(
                      color: colorScheme.tertiaryContainer,
                    ),
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
              storage.write(
                key: "bank",
                value: _bankController.text,
              );
              storage.write(
                key: "bankAddress",
                value: _bankAddressController.text,
              );
              storage.write(
                key: "bankOwnerName",
                value: _bankOwnerNameController.text,
              );
              showConfirmDialog(context);
              Get.offAll(Home());
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

  //위젯화 하고 싶지만, bool값이 widget 안에서 변하면 버튼 색깔을 바꾸게 하지 못해 보류함.

  // Widget _accountInfo({
  //   required String hintTitle,
  //   required String errorTitle,
  //   required controller,
  //   required BuildContext context,
  //   required bool boolVar
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
  //           if(value.length > 0){
  //             setState(() {
  //               boolVar = false;
  //             });
  //           }
  //           else {
  //             setState(() {
  //               boolVar = true;
  //             });
  //           }
  //           print(boolVar);
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
                  "계좌가 추가되었습니다.",
                  style: textTheme.headline3?.copyWith(
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