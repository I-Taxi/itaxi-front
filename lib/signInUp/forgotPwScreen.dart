import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';

class ForgotPwScreen extends StatefulWidget {
  ForgotPwScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  SignInController _signInController = Get.find();


  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isValueEmpty = true; // 메일 입력 여부 판별


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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 39.0.h,
                  horizontal: 24.0.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('비밀번호 찾기', style: textTheme.headline2?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold
                    ),),
                SizedBox(
                  height: 52.0.h,
                ),
                // 이메일 입력
                TextFormField(
                    controller: _emailController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "가입한 이메일을 입력해주세요",
                      hintStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.tertiary,
                      ),
                      suffixText: '@handong.ac.kr',
                      suffixStyle: textTheme.bodyText1?.copyWith(
                        color: colorScheme.onPrimary,
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
                      _signInController.email = '$value@handong.ac.kr';
                      if(value.length > 0){
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
                      if (value!.isEmpty) {
                        return '이메일을 입력해주세요';
                      }
                      else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 59.0.h,
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
      bottomNavigationBar: Material(
        color: isValueEmpty ? colorScheme.tertiaryContainer : colorScheme.secondary,
        child: InkWell(
          onTap: () async{
            await _signInController.sendPasswordResetEmailByKorean();
          },
          child: SizedBox(
            height: 94.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "이메일로 재설정 링크 받기",
                  style: textTheme.subtitle1!.copyWith(
                    color: colorScheme.onPrimary
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Container(
            width: 312.w,
            height: 262.h,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              36.0.w,
              24.0.h,
              36.0.w,
              28.0.h,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "메일이 전송되었습니다",
                  style: textTheme.headline1?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '입력한 이메일 주소로 비밀번호 재설정 링크를 보내드렸습니다.',
                  style: textTheme.subtitle1?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                RichText(
                    text: TextSpan(
                      text: "메일이 보이지 않는다면, ",
                      style: textTheme.subtitle1?.copyWith(
                        color: colorScheme.onPrimary
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "스팸함을\n", style: textTheme.subtitle1?.copyWith(
                          color: colorScheme.secondary
                        )),
                        TextSpan(
                          text: "확인해주세요", style: textTheme.subtitle1?.copyWith(
                          color: colorScheme.onPrimary
                        )
                        )
                      ]
                    ),
                ),

                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await _signInController.sendPasswordResetEmailByKorean();
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    "확인",
                    style: textTheme.headline1
                        ?.copyWith(color: colorScheme.tertiary),
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
