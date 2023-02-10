import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/repository/chatRepository.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/model/joiner.dart';

class PostController extends GetxController {
  late DateController _dateController = Get.find();
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late Future<List<Post>> posts;
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
    var postUrl = dotenv.env['API_URL'].toString();
    final Map<String, dynamic> queryParameters;
    if ((depId == null || depId == -1) && (dstId == null || dstId == -1)) {
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
    } else if (depId != null && (dstId == null || dstId == -1)) {
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
    } else if ((depId == null || depId == -1) && dstId != null) {
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
    print(1);
    if (response.statusCode == 200) {
      print(utf8.decode(response.bodyBytes));
      print(2);
      return postsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPostInfo({required int? id}) async {
    var postUrl = dotenv.env['API_URL'].toString();
    postUrl = '${postUrl}post/$id';

    Map<String, String?> map = {
      'uid': _userController.uid,
    };

    var body = utf8.encode(json.encode(map));

    http.Response response = await http.post(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print(utf8.decode(response.bodyBytes));
      return Post.fromDocs(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(response.statusCode);
      print(utf8.decode(response.bodyBytes));
      throw Exception('Failed to load post info');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required Post post, required int luggage}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}post/${post.id}/join';

    Map<String, dynamic> map = {
      'luggage': luggage,
      'status': 0,
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
      Post result = Post.fromDocs(json.decode(utf8.decode(response.bodyBytes)));
      await _chatRoomController.joinChat(post: result);
      await ChatRepository().setPost(post: result);
      print('join');
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required Post post}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}post/${post.id}/join';
    Joiner? owner;

    post.joiners?.forEach((joiner) {
      print(1);
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
    if (response.statusCode == 200) {
      print(response.body);
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
