import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itaxi/model/user.dart';
import 'package:itaxi/signInUp/signInScreen.dart';

// enum SignInState {
//   signedIn,
//   signedOut,
// }

class SignUpController extends GetxController {
  late String studentId;
  late String customId;
  late String customPw;
  late String name;
  late String phone;
  late String bank;
  late String bankAddress;

  Future<http.Response> fetchAddUser({required Login login}) async {
    var addUserUrl = "http://walab.handong.edu:8080/itaxi/api/";
    addUserUrl = '${addUserUrl}member';

    var body = json.encode(login.toMap());

    http.Response response = await http.post(Uri.parse(addUserUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);

    return response;
  }

  Future<void> signUp() async {
    // print(FirebaseAuth.instance.currentUser!.displayName.toString());
    customId = "$customId@handong.ac.kr";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: customId, password: customPw);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Login login = Login(
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        phone: phone,
        name: name,
        bank: bank,
        bankAddress: bankAddress,
      );
      fetchAddUser(login: login);
      Get.to(const SignInScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e);
      }
    }
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
