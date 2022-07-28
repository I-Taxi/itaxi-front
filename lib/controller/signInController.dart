import 'package:firebase_auth/firebase_auth.dart';
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

  void signedInState() {
    signInState = SignInState.signedIn;
    update();
  }

  void signedOutState(){
    signInState = SignInState.signedOut;
    update();
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
