import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/ip/controller/ipController.dart';
import 'package:itaxi/chat/repository/ktxChatRepository.dart';
import 'package:itaxi/post/model/ktxPost.dart';
import 'package:itaxi/joiner/model/joiner.dart';

class KtxPostController extends GetxController {
  IpController _ipController = Get.find();
  late DateController _dateController = Get.find();
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late Future<List<KtxPost>> posts;
  bool isLoading = true;

  List<KtxPost> ktxPostsfromJson(json) {
    List<KtxPost> result = [];
    json.forEach((item) {
      result.add(KtxPost.fromPostAllDocs(item));
    });

    return result;
  }

  Future<void> getPosts({
    int? depId,
    int? dstId,
    required String time,
  }) async {
    posts = fetchPost(
      depId: depId,
      dstId: dstId,
      time: time,
    );
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  Future<List<KtxPost>> fetchPost({int? depId, int? dstId, required String time}) async {
    var postUrl = _ipController.ip.toString();
    final Map<String, dynamic> queryParameters;
    if ((depId == null || depId == -1 || depId == 3232) && (dstId == null || dstId == -1 || dstId == 3232)) {
      queryParameters = {
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if (depId != null && (dstId == null || dstId == -1 || dstId == 3232)) {
      queryParameters = {
        'depId': depId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if ((depId == null || depId == -1 || depId == 3232) && dstId != null) {
      queryParameters = {
        'dstId': dstId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else {
      queryParameters = {
        'depId': depId.toString(),
        'dstId': dstId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    }
    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = '${postUrl}ktx?$queryString';

    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ktxPostsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<KtxPost> fetchPostInfo({required int? id}) async {
    var postUrl = _ipController.ip.toString();
    postUrl = '${postUrl}ktx/$id';

    http.Response response = await http.post(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: {
        'uid': _userController.uid,
      },
    );

    if (response.statusCode == 200) {
      return KtxPost.fromPostAllDocs(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
      throw Exception('Failed to load post info');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required KtxPost ktxPost}) async {
    var joinUrl = _ipController.ip.toString();
    joinUrl = '${joinUrl}ktx/${ktxPost.id}/join';

    Map<String, dynamic> map = {
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));

    http.Response response = await http.post(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      KtxPost result = KtxPost.fromPostAllDocs(json.decode(utf8.decode(response.bodyBytes)));
      await _chatRoomController.ktxJoinChat(post: result);
      await KtxChatRepository().setPost(post: result);
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required KtxPost post}) async {
    var joinUrl = _ipController.ip.toString();
    joinUrl = '${joinUrl}ktx/${post.id}/join';
    Joiner? owner;

    post.joiners?.forEach((joiner) {
      if (joiner.owner!) {
        owner = joiner;
      }
      //post.joiners?.remove(joiner);
    });

    Map<String, dynamic> map = {
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));

    http.Response response = await http.put(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      await _chatRoomController.ktxOutChat(post: post);
      KtxChatRepository().setPost(post: post);

      int oldOwnerId = -1;
      for (Joiner joiner in post.joiners!) {
        if (joiner.owner!) {
          oldOwnerId = joiner.memberId!;
        }
      }
      int newOwnerId = int.parse(response.body);
      if (post.participantNum! > 1 && newOwnerId != oldOwnerId) {
        String newOwnerName = '';
        for (Joiner joiner in post.joiners!) {
          if (newOwnerId == joiner.memberId) {
            newOwnerName = joiner.memberName!;
          }
        }
        _chatRoomController.changeOwnerChat(ownerName: newOwnerName);
      }

      // if (_userController.name != response.body) {
      //   _chatRoomController.changeOwnerChat(ownerName: response.body);
      // }
    } else {
      throw Exception(json.decode(utf8.decode(response.bodyBytes)));
    }
  }
}
