import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../model/notice.dart';

class NoticeController extends GetxController {
  late Future<List<Notice>> notices;


  @override
  void initState() {
    // super.onInit();
    getNotices();
  }

  Future<void> getNotices() async {
    notices = fetchNotices();
    // print(notices);
    update();
  }

  List<Notice> noticeFromJson(json) {
    List<Notice> result = [];
    json.forEach((item) {
      result.add(Notice.fromDocs(item));
    });
    print(result);
    return result;
  }



  Future<List<Notice>> fetchNotices() async {
    var noticeUrl = "http://walab.handong.edu:8080/itaxi/api/";
    noticeUrl = noticeUrl + "notice";

    var response = await http.get(
        Uri.parse(noticeUrl),
      headers: <String, String>{
          'Content-type': 'application/json',
      }
    );

    if (response.statusCode == 200) {
      return noticeFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load Notice');
    }
  }

}