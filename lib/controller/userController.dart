import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  @override
  void onInit() {
    super.onInit();
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
      return userFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load MyInfo');
    }
  }

  // 정보 수정
  Future<void> fetchNewUsers() async {
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member';

    http.Response response = await http.patch(
      Uri.parse(userUrl),
      headers: <String, String>{'Content-type': 'application/json'},
      body: json.encode(
        {
          'bank': "1",
          'bankAddress': "1",
          'phone': phone.toString(),
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
