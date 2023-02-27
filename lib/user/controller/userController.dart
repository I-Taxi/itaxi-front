import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:encrypt/encrypt.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itaxi/user/model/userInfoList.dart';
import 'package:itaxi/fcm/fcmController.dart';

class UserController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final FCMController _fcmController;

  late Future<UserInfoList> users;

  int isDeleted = 0;

  late String? uid;
  late int? memberId;
  late String? name;
  late String? phone;

  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY'].toString());
  final iv = IV.fromLength(16);

  late final Encrypter encrypter;
  late String? token;

  bool alarm = false;
  bool loaded = false;
  bool userFetchSuccess = false;

  @override
  void onInit() {
    super.onInit();
    _fcmController = FCMController(_fcm);
    encrypter = Encrypter(AES(key));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setAlarm(bool to) {
    alarm = to;
    update();
  }

  Future<void> getUsers() async {
    users = fetchUsers();
    await fetchUsers();
    await updateUserFirestore();
    update();
  }

  void encryptUser(UserInfoList user) {
    user.phone = encrypter.encrypt(user.phone!, iv: iv).base64;
  }

  void decryptUser(UserInfoList user) {
    user.phone = encrypter.decrypt64(user.phone!, iv: iv);
  }

  UserInfoList userFromJson(json) {
    UserInfoList userInfo;

    userInfo = UserInfoList.fromDocs(json);
    uid = userInfo.uid;
    memberId = userInfo.id;
    name = userInfo.name;
    phone = userInfo.phone;
    return userInfo;
  }

  Future<int> updateUserFirestore() async {
    final token = await _fcmController.getToken();
    DocumentReference reference = _firestore.collection('Users').doc(memberId.toString());
    await reference.set({"memberId": memberId, "token": token});
    return 0;
  }

  Future<UserInfoList> fetchUsers() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member/info';

    final body = jsonEncode({"uid": uid});

    http.Response response =
        await http.post(Uri.parse(userUrl), headers: <String, String>{'Content-type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      userFetchSuccess = true;
      loaded = true;
      update();
      UserInfoList result = userFromJson(json.decode(utf8.decode(response.bodyBytes)));
      decryptUser(result);

      return result;
    } else {
      print(utf8.decode(response.bodyBytes));
      userFetchSuccess = false;
      loaded = true;
      update();
      return Future.error('계정 정보를 불러오는 데 실패했습니다.');
    }
  }

  // 정보 수정
  Future<void> fetchNewUsers() async {
    var userUrl = dotenv.env['API_URL'].toString();
    userUrl = '${userUrl}member';

    var encryptPhone = encrypter.encrypt(phone!, iv: iv).base64;

    http.Response response = await http.patch(
      Uri.parse(userUrl),
      headers: <String, String>{'Content-type': 'application/json'},
      body: json.encode(
        {
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

  Future<FirebaseAuthException?> changePassword(String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    try {
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
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
        'Content-Type': 'application/json',
      },
      body: body,
    );
    print(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      isDeleted = 1;
    } else if (json.decode(utf8.decode(response.bodyBytes))["message"] == "다른 방에 입장해있으면 탈퇴할 수 없습니다.") {
      print(json.decode(utf8.decode(response.bodyBytes))["message"]);
      isDeleted = 2;
    } else {
      throw Exception('Failed to Delete User');
    }
    return response;
  }
}
