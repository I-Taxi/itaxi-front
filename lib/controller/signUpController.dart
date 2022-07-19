// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../signInUp/signInScreen.dart';
import '../signInUp/signUpScreen.dart';

// enum SignInState {
//   signedIn,
//   signedOut,
// }

class SignUpController extends GetxController {


  late String studentId;
  late String customId;
  late String customPw;


  Future<void> signIn() async {
    // signInState = SignInState.signedIn;
    // update();
  }

  // Future<void> signOut() async {
  // }

  Future<void> signUp() async {
    try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: customId,
        password: customPw);
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('11111');
      }
    } catch (e) {
      print('끝');
    }
    Get.to(SignInScreen());
    // SignInController의 SignUp 함수 만들어서 적용.
    // pop
    // Main Screen 또는 SignInScreen으로.
  }

  // 구글 로그인 (참고용), google_sign_in 패키지 필요
  // Future<void> signInWithGoogle() async {
  //   UserController _userController = Get.find<UserController>();

  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication? googleAuth =
  //   await googleUser?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   await UserRepository().setUser();
  //   await _userController.setUser();
  //   loginState = LoginState.loggedGoogleIn;

  //   update();
  // }

  // Future<void> signOutWithGoogle() async {
  //   FirebaseAuth.instance.signOut();
  //   loginState = LoginState.loggedOut;
  //   update();
  // }
}
