import 'package:get/get.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:itaxi/model/notice.dart';

class NoticeController extends GetxController {
  late Future<List<Notice>> notices;

  NoticeController() {
    getNotices();
  }

  Future<void> getNotices() async {
    notices = fetchNotices();
    update();
  }

  List<Notice> noticeFromJson(json) {
    List<Notice> result = [];
    json.forEach(
      (item) {
        result.add(Notice.fromDocs(item));
      },
    );
    return result;
  }

  Notice? getLatestNotice(List<Notice> noticeList) {
    Notice? result;
    for (Notice notice in noticeList) {
      DateTime parseNoticeCreatedAt = DateTime.parse(notice.createdAt!);
      Duration diff = parseNoticeCreatedAt.difference(DateTime.now());
      if (diff.inDays >= -10) {
        result = notice;
        break;
      }
    }
    return result;
  }

  Future<List<Notice>> fetchNotices() async {
    var noticeUrl = dotenv.env['API_URL'].toString();
    noticeUrl = "${noticeUrl}notice";

    var response = await http.get(
      Uri.parse(noticeUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return noticeFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load Notice');
    }
  }
}
