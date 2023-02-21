import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class AdvertisementController extends GetxController {
  late Future<List<String>> advertisements;
  late Image advertisement;

  Future<void> getAdvertisementImage({required String name}) async {
    advertisement = fetchAdvertisementImage(name: name) as Image;
    update();
  }

  Future<void> getAdvertisements() async {
    advertisements = fetchAdvertisements();
    update();
  }

  List<String> advertisementNamesFromJson(json) {
    List<String> result = [];
    json.forEach(
      (item) {
        result.add(item.toString());
      },
    );
    return result;
  }

  Future<List<String>> fetchAdvertisements() async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    advertisementUrl = "${advertisementUrl}advertisement";

    var response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return advertisementNamesFromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load image names');
    }
  }

  Future<Image> fetchAdvertisementImage({required String name}) async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    advertisementUrl = "${advertisementUrl}advertisement/$name";

    http.Response response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return advertisementfromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load image');
    }
  }

  Image advertisementfromJson(json) {
    Image result = json;

    return result;
  }
}
