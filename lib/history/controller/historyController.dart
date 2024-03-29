import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';

import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/ip/controller/ipController.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/joiner/model/joiner.dart';
import 'package:itaxi/history/model/history.dart';
import 'package:itaxi/post/model/ktxPost.dart';

class HistoryController extends GetxController {
  UserController _userController = Get.put(UserController());
  IpController _ipController = Get.find();
  
  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY'].toString());
  final iv = IV.fromLength(16);

  late final Encrypter encrypter;

  late Future<List<History>> historys;
  late Future<History> history;

  bool loaded = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    historys = fetchHistorys();
    encrypter = Encrypter(AES(key));
  }

  List<History> historysfromJson(json) {
    List<History> result = [];
    json.forEach((item) {
      result.add(History.fromDocs(item));
    });

    return result;
  }

  History historyfromJson(json) {
    History result = History.fromDetailDocs(json);
    for (Joiner joiner in result.joiners!) {
      joiner.memberPhone = encrypter.decrypt64(joiner.memberPhone!, iv: iv);
    }
    return result;
  }

  Future<void> getHistorys() async {
    historys = fetchHistorys();
    update();
  }

  Future<void> getHistoryInfo({required int postId, required int postType}) async {
    loaded = false;
    history = fetchHistoryInfo(postId: postId, postType: postType);
    history.then((_) {
      loaded = true;
      update();
    });
  }

  // /itaxi/api/post/history
  Future<List<History>> fetchHistorys() async {
    var historyUrl = _ipController.ip.toString();
    historyUrl = '${historyUrl}history';

    Map<String, dynamic> map = {
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));
    http.Response response = await http.post(
      Uri.parse(historyUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return historysfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(response.statusCode);
      throw Exception('Failed to load historys');
    }
  }

  Future<History> fetchHistoryInfo({required int postId, required int postType}) async {
    var historyUrl = _ipController.ip.toString();
    historyUrl = '${historyUrl}history/$postId';
    final Map<String, dynamic> queryParameters;

    Map<String, dynamic> map = {
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));

    if (postType == 3) {
      queryParameters = {'type': '1'};
    } else {
      queryParameters = {'type': '0'};
    }

    String queryString = Uri(queryParameters: queryParameters).query;
    historyUrl = '$historyUrl?$queryString';

    http.Response response = await http.post(
      Uri.parse(historyUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return historyfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load history info');
    }
  }
}
