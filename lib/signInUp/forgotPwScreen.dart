import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/signInController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/src/theme.dart';



class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({Key? key}) : super(key: key);

  @override
  _ForgotPwScreenState createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  SignInController _signInController = SignInController();

  final _emailController = TextEditingController();

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
            '비밀번호 재설정',
            style: ITaxiTheme.textTheme.subtitle1,
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: colorScheme.secondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Text('회원가입 시 입력한 본인의 @handong.ac.kr 이메일을 입력해주세요.\n해당 이메일을 통해 비밀번호 재설정 링크를 받으실 수 있습니다.', style: textTheme.bodyText1,),
              ),
              SizedBox(height: 30.0.h,),
              // 이메일 입력
              TextFormField(
                  controller: _emailController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '이메일',
                      labelStyle: textTheme.bodyText1
                          ?.copyWith(color: colorScheme.tertiary)),
                  onChanged: (value) {
                    _signInController.email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter Email';
                    // pattern 변경하면 됨.
                    // regExp = RegExp(pattern.toString());
                    // if (!regExp.hasMatch(value)) return 'Username is invalid'
                    return null;
                  }),
              const SizedBox(height: 12.0),

              SizedBox(height: 50.0.h),
              SizedBox(
                width: 104.w,
                height: 40.h,
                child: TextButton(
                  child: Text("완료", style: textTheme.headline2!.copyWith(color: colorScheme.secondary),),
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      ShowDialog(context);
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

  void ShowDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textTheme = Theme.of(context).textTheme;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "회원가입 시 입력하신 이메일이 맞나요?\n메일이 오지 않은 경우, 스팸함을 확인해주세요.",
                  style: textTheme.bodyText1,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("확인", style: textTheme.bodyText1,),
                onPressed: () async{
                  await _signInController.sendPasswordResetEmailByKorean();
                  Get.back();
                  Get.back();
                },
              ),
            ],
          );
        }
    );
  }
}


