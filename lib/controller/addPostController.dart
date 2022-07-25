import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';

class AddPostController extends GetxController {
  int capacity = 0;
  int luggage = 0;

  Future<http.Response> fetchAddPost({required Post post}) async {
    var addPostUrl = "http://walab.handong.edu:8080/itaxi/api/";
    addPostUrl = addPostUrl + 'post';

    var body = json.encode(post.toMap());

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to add posts');
    }
  }
}
