import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/chat/controller/chatRoomController.dart';
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/ip/controller/ipController.dart';
import 'package:itaxi/chat/repository/chatRepository.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/joiner/model/joiner.dart';

class PostController extends GetxController {
  IpController _ipController = Get.find();
  late DateController _dateController = Get.find();
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late Future<List<Post>> posts;
  late Post deepLinkPost;
  late int deepLinkId;
  bool isLoading = true;

  List<Post> postsfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromPostAllDocs(item));
    });

    return result;
  }

  List<Post> postsfromJsonWithoutJoiners(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromStopoverDocs(item));
    });

    return result;
  }

  Future<void> getPosts({int? depId, int? dstId, required String time, required int postType}) async {
    posts = fetchPost(
      depId: depId,
      dstId: dstId,
      time: time,
      postType: postType,
    );
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  Future<List<Post>> fetchPost({int? depId, int? dstId, required String time, required int postType}) async {
    var postUrl = _ipController.ip.toString();
    final Map<String, dynamic> queryParameters;
    if ((depId == null || depId == -1 || depId == 3232) && (dstId == null || dstId == -1 || dstId == 3232)) {
      if (postType == 0) {
        queryParameters = {
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else if (depId != null && (dstId == null || dstId == -1 || dstId == 3232)) {
      if (postType == 0) {
        queryParameters = {
          'depId': depId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'depId': depId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else if ((depId == null || depId == -1 || depId == 3232) && dstId != null) {
      if (postType == 0) {
        queryParameters = {
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else {
      if (postType == 0) {
        queryParameters = {
          'depId': depId.toString(),
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'depId': depId.toString(),
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    }
    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = '${postUrl}post?$queryString';

    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return postsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPostInfo({required int id}) async {
    var postUrl = _ipController.ip.toString();
    postUrl = '${postUrl}post/$id';

    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("200 status code");
      deepLinkId = id;
      deepLinkPost = Post.fromDocs(json.decode(utf8.decode(response.bodyBytes)));
      return deepLinkPost;
    } else {
      print("PostUrl");
      print(postUrl);
      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
      throw Exception('Failed to load post info');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required Post post}) async {
    var joinUrl = _ipController.ip.toString();
    joinUrl = '${joinUrl}post/${post.id}/join';

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
      Post result = Post.fromJoinerAndStopoversDocs(json.decode(utf8.decode(response.bodyBytes)));
      await _chatRoomController.joinChat(post: result);
      await ChatRepository().setPost(post: result);
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required Post post}) async {
    var joinUrl = _ipController.ip.toString();
    joinUrl = '${joinUrl}post/${post.id}/join';
    Joiner? owner;

    post.joiners?.forEach((joiner) {
      if (joiner.owner!) {
        owner = joiner;
      }
      // post.joiners?.remove(joiner);
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
    if (response.statusCode == 200 && DateTime.tryParse(_chatRoomController.post.deptTime!)!.isAfter(DateTime.now())) {
      await _chatRoomController.outChat(post: post);
      ChatRepository().setPost(post: post);
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
      // if (_userController.memberId == owner?.memberId) {
      //   _chatRoomController.changeOwnerChat(post: post);
      // }
    } else {
      throw Exception(json.decode(utf8.decode(response.bodyBytes)));
    }
  }
}
