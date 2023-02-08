import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';

import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/model/joiner.dart';

class HistoryController extends GetxController {
  UserController _userController = Get.put(UserController());

  final key = Key.fromUtf8(dotenv.env['ENCRYPTION_KEY'].toString());
  final iv = IV.fromLength(16);

  late final Encrypter encrypter;

  late Future<List<Post>> historys;
  late Future<Post> history;
  late List<Post> historiesWithoutFuture;

  bool loaded = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    historys = fetchHistorys();
    historiesWithoutFuture = await historys;
    encrypter = Encrypter(AES(key));
  }

  List<Post> HistorysfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromStopoverDocs(item));
    });

    return result;
  }

  Post historyfromJson(json) {
    Post result = Post.fromJoinerAndStopoversDocs(json);
    for (Joiner joiner in result.joiners!) {
      joiner.memberPhone = encrypter.decrypt64(joiner.memberPhone!, iv: iv);
    }
    return result;
  }

  Future<void> getHistorys() async {
    historys = fetchHistorys();
    update();
  }

  Future<void> getHistoryInfo({required int postId}) async {
    loaded = false;
    history = fetchHistoryInfo(postId: postId);
    loaded = true;
    update();
  }

  // /itaxi/api/post/history
  Future<List<Post>> fetchHistorys() async {
    var historyUrl = dotenv.env['API_URL'].toString();
    historyUrl = '${historyUrl}post/history';

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
      return HistorysfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(response.statusCode);
      throw Exception('Failed to load historys');
    }
  }

  Future<Post> fetchHistoryInfo({required int postId}) async {
    var historyUrl = dotenv.env['API_URL'].toString();
    historyUrl = '${historyUrl}post/history/$postId';

    http.Response response = await http.get(
      Uri.parse(historyUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(utf8.decode(response.bodyBytes));
      return historyfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load history info');
    }
  }
}
