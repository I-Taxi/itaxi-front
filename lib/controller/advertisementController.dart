import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/model/advertisement.dart';

class AdvertisementController extends GetxController {
  late Future<List<Advertisement>> advertisements;
  late Future<Advertisement> advertisement;

  Future<void> getAdvertisement({required String imgName}) async {
    advertisement = fetchAdvertisement(imgName: imgName);
    update();
  }

  Future<void> getAdvertisementList() async {
    advertisements = fetchAdvertisements();
    update();
  }

  List<Advertisement> advertisementsFromJson(json) {
    List<Advertisement> result = [];
    json.forEach(
      (item) {
        result.add(Advertisement.fromDocs(item));
      },
    );

    return result;
  }

  Future<List<Advertisement>> fetchAdvertisements() async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    advertisementUrl = "${advertisementUrl}advertisement";

    var response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return advertisementsFromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load image names');
    }
  }

  Future<Advertisement> fetchAdvertisement({required String imgName}) async {
    var advertisementUrl = dotenv.env['API_URL'].toString();

    Map<String, String?> map = {
      'imgName': imgName,
    };

    var body = utf8.encode(json.encode(map));

    http.Response response = await http.post(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return advertisementfromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load image');
    }
  }

  Advertisement advertisementfromJson(json) {
    Advertisement result = Advertisement.fromDocs(json);

    return result;
  }
}
