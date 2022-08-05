import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../model/userInfoList.dart';

class UserController extends GetxController {
  late Future<UserInfoList> users;

  late String? uid;
  late String? bank;
  late String? bankAddress;
  late String? phone;

  void onInit() {
    super.onInit();
    uid = FirebaseAuth.instance.currentUser!.uid;
    getUsers();
  }

  Future<void> getUsers() async {
    users = fetchUsers();
    // print(users);
    update();
  }

  UserInfoList userFromJson(json) {
    UserInfoList userInfo;
    // json.forEach((item) {
    //   print(item);
    //   userInfo.add(UserInfoList.fromDocs(item));
    // });
    Map<String, dynamic> myMap = new Map<String, dynamic>.from(json);

    userInfo = UserInfoList.fromDocs(json);
    uid = userInfo.uid;

    return userInfo;
  }

  Future<UserInfoList> fetchUsers() async {
    var userUrl = "http://walab.handong.edu:8080/itaxi/api/";
    userUrl = '${userUrl}member/info';

    final body = jsonEncode({"uid": uid});

    http.Response response = await http.post(Uri.parse(userUrl),
        headers: <String, String>{'Content-type': 'application/json'},
        body: body);

    if (response.statusCode == 200) {
      // print(UserInfoList.fromDocs(json.decode(utf8.decode(response.bodyBytes))));
      // users = UserInfoList.add(json.decode(utf8.decode(response.bodyBytes)))
      return userFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load MyInfo');
    }
  }

  // 정보 수정
  Future<void> fetchNewUsers() async {
    var userUrl = "http://walab.handong.edu:8080/itaxi/api";
    userUrl = userUrl + '/member';

    http.Response response = await http.patch(Uri.parse(userUrl),
        headers: <String, String>{'Content-type': 'application/json'},
        body: json.encode({
          'bank': bank.toString(),
          'bankAddress': bankAddress.toString(),
          'phone': phone.toString(),
          // 'uid': 'ryan_uid'.toString(),
          'uid': FirebaseAuth.instance.currentUser!.uid,
        }));

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to patch My new Info');
    }
  }
}
