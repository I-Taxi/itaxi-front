import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:encrypt/encrypt.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itaxi/model/user.dart';
import 'package:itaxi/signInUp/signInScreen.dart';

class SignUpController extends GetxController {
  static const List<String> signUpStatusStringList = [
    'loading',
    'success',
    'weak-password',
    'email-already-in-use',
    'unknown-error'
  ];

  late String customId;
  String customPw = ""; // 나중에 수정 요망.
  late String name;
  late String phone;
  late String bank;
  late String bankAddress;
  late String bankOwner;
  int signUpStatus = 0;

  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY'].toString());
  final iv = IV.fromLength(16);

  late final Encrypter encrypter;

  @override
  void onInit() {
    super.onInit();
    encrypter = Encrypter(AES(key));
  }

  String getSignUpStatusString() {
    return signUpStatusStringList[signUpStatus];
  }

  void setSignUpStatus(int to) {
    signUpStatus = to;
    update();
  }

  void encryptUser(Login login) {
    login.phone = encrypter.encrypt(login.phone!, iv: iv).base64;
  }

  void decryptUser(Login login) {
    login.phone = encrypter.decrypt64(login.phone!, iv: iv);
  }

  Future<http.Response> fetchAddUser({required Login login}) async {
    var addUserUrl = dotenv.env['API_URL'].toString();
    addUserUrl = '${addUserUrl}member';

    var body = json.encode(login.toMap());

    http.Response response = await http.post(Uri.parse(addUserUrl),
        headers: <String, String>{'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      print(response);
      return response;
    } else {
      print(response.statusCode);
      print(response.body);

      throw Exception('Failed to Add User');
    }
  }

  Future<void> signUp() async {
    // print(FirebaseAuth.instance.currentUser!.displayName.toString());
    customId = "${customId}@handong.ac.kr";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: customId, password: customPw);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Login login = Login(
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        phone: phone,
        name: name,
      );
      encryptUser(login);
      await fetchAddUser(login: login);
      setSignUpStatus(1);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setSignUpStatus(2);
        throw Exception('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print(1131);
        setSignUpStatus(3);
        throw Exception('The account already exists for that email.');
      } else {
        setSignUpStatus(4);
        throw Exception(e);
      }
    }
  }
}
