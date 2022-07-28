import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../model/userInfoList.dart';

class UserController extends GetxController {
  Future<List<UserInfoList>>? users;

  @override
  void initState() {
    // super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    users = fetchUsers();
    print(users);
    update();
  }

  List<UserInfoList> userFromJson(json) {
    List<UserInfoList> userInfo = [];
    json.forEach((item) {
      userInfo.add(UserInfoList.fromDocs(item));
    });

    return userInfo;
  }

  Future<List<UserInfoList>> fetchUsers() async {
    var userUrl = "http://walab.handong.edu:8080/itaxi/api/";
    userUrl = userUrl + 'member/';

    var queryParameters = {
      'uid' : FirebaseAuth.instance.currentUser!.uid,
    };
    var queryString = Uri(queryParameters: queryParameters).query;

    userUrl = userUrl + queryString;

    http.Response response = await http.get(
      Uri.parse(userUrl),
      headers: <String, String>{
        'Content-type': 'application/json'
      },
    );
    print("response.body ");
    print(response.body);

    if(response.statusCode == 200) {
      return userFromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else {
      throw Exception('Failed to load MyInfo');
    }
  }


}