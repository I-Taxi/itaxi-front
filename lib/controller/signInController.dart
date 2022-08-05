import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../mainScreen.dart';

enum SignInState {
  signedIn,
  signedOut,
}

class SignInController extends GetxController {
  SignInState signInState = SignInState.signedOut;

  late String id;
  late String pw;


  // 자동 로그인 시 필요한 변수
  String userInfo = "";
  static final storage = new FlutterSecureStorage();


  void signedInState() {
    signInState = SignInState.signedIn;
    update();
  }

  void signedOutState(){
    signInState = SignInState.signedOut;
    update();
  }

  @override
  void initState() {
    super.onInit();
    // print("hi");
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   _asyncMethod();
    // });
  }


  _asyncMethod() async {
    // 데이터 없을 경우 null 반환
    userInfo = await storage.read(key: "login") as String;
    print("userINfo");
    print(userInfo);


    // user 정보가 있을 경우 바로 main으로 넘어가게 함
    if (userInfo != null) {
      id = userInfo.split(" ")[1];
      pw = userInfo.split(" ")[3];
      signIn();
    }
  }


  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: id, password: pw) //아이디와 비밀번호로 로그인 시도
          .then((value) {
        // print(value);
        value.user!.emailVerified == true //이메일 인증 여부
            ? {
                signedInState(),
                update(),
              }
            : print('이메일 확인 안댐');
        return value;
      });
    } on FirebaseAuthException catch (e) {
      //로그인 예외처리
      if (e.code == 'user-not-found') {
        print('등록되지 않은 이메일입니다');
      } else if (e.code == 'wrong-password') {
        print('비밀번호가 틀렸습니다');
      } else {
        // print("error Cdoe");
        print(e.code);
      }
    }
  }
}
