import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';

class AddPostController extends GetxController {
  late HistoryController _historyController = Get.find();
  int capacity = 0;
  int luggage = 0;

  Future<http.Response> fetchAddPost({required Post post}) async {
    var addPostUrl = "http://walab.handong.edu:8080/itaxi/api/";
    addPostUrl = addPostUrl + 'post';
    print('2');
    var body = utf8.encode(json.encode(post.toAddPostMap()));
    print('3');
    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    print('AddPost : ${response.body}');
    if (response.statusCode == 200) {
      _historyController.getHistorys();
      return response;
    } else {
      throw Exception('Failed to add posts');
    }
  }
}
