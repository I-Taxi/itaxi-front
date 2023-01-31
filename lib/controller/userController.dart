import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:encrypt/encrypt.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itaxi/model/userInfoList.dart';

class UserController extends GetxController {
  late Future<UserInfoList> users;

  int isDeleted = 0;

  late String? uid;
  late int? memberId;
  late String? name;
  late String? bank;
  late String? bankAddress;
  late String? phone;

  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY'].toString());
  final iv = IV.fromLength(16);

  late final Encrypter encrypter;

  @override
  void onInit() {
    super.onInit();
    encrypter = Encrypter(AES(key));
    getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUsers() async {
    users = fetchUsers();
    update();
  }

  void encryptUser(UserInfoList user) {
    user.phone = encrypter.encrypt(user.phone!, iv: iv).base64;
    user.bank = encrypter.encrypt(user.bank!, iv: iv).base64;
    user.bankAddress = encrypter.encrypt(user.bankAddress!, iv: iv).base64;
  }

  void decryptUser(UserInfoList user) {
    user.phone = encrypter.decrypt64(user.phone!, iv: iv);
    user.bank = encrypter.decrypt64(user.bank!, iv: iv);
    user.bankAddress = encrypter.decrypt64(user.bankAddress!, iv: iv);
  }

  UserInfoList userFromJson(json) {
    UserInfoList userInfo;

    userInfo = UserInfoList.fromDocs(json);
    uid = userInfo.uid;
    memberId = userInfo.id;
    name = userInfo.name;
    bank = userInfo.bank;
    bankAddress = userInfo.bankAddress;
    phone = userInfo.phone;

    return userInfo;
  }

  Future<UserInfoList> fetchUsers() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member/info';

    final body = jsonEncode({"uid": uid});

    http.Response response = await http.post(Uri.parse(userUrl),
        headers: <String, String>{'Content-type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      UserInfoList result =
          userFromJson(json.decode(utf8.decode(response.bodyBytes)));
      decryptUser(result);
      return result;
    } else {
      throw Exception('계정 정보를 불러오는 데 실패했습니다.');
    }
  }

  // 정보 수정
  Future<void> fetchNewUsers() async {
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member';

    var encryptPhone = encrypter.encrypt(phone!, iv: iv).base64;
    var encryptBank = encrypter.encrypt("1", iv: iv).base64;
    var encryptBankAddress = encrypter.encrypt("1", iv: iv).base64;

    http.Response response = await http.patch(
      Uri.parse(userUrl),
      headers: <String, String>{'Content-type': 'application/json'},
      body: json.encode(
        {
          'bank': encryptBank,
          'bankAddress': encryptBankAddress,
          'phone': encryptPhone,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        },
      ),
    );

    if (response.statusCode == 200) {
      //return response;
    } else {
      throw Exception('Failed to patch My new Info');
    }
  }

  // 회원탈퇴
  Future<http.Response> fetchDeleteUsers() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member/resign';

    final body = jsonEncode({"uid": uid});

    http.Response response = await http.patch(
      Uri.parse(userUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      isDeleted = 1;
      return response;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to Delete User');
    }
  }
}
