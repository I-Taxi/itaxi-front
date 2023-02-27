import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/place/model/advertisement.dart';

class AdvertisementController extends GetxController {
  late Future<List<Advertisement>> advertisements;
  late Future<Advertisement> advertisement;
  late Future<Advertisement> advertisementImage;

  @override
  Future<void> onInit() async {
    super.onInit();
    advertisementImage = fetchAdvertisementImage(imgName: 'dog');
  }

  Future<void> getAdvertisement({required String imgName}) async {
    advertisement = fetchAdvertisement(imgName: imgName);
    update();
  }

  Future<void> getAdvertisementImage({required String imgName}) async {
    advertisementImage = fetchAdvertisementImage(imgName: imgName);
    update();
  }

  Future<void> getAdvertisementList() async {
    advertisements = fetchAdvertisements();
    update();
  }

  Advertisement advertisementfromJson(json) {
    List<Advertisement> result = [];
    json.forEach(
      (item) {
        result.add(Advertisement.fromDocs(item));
      },
    );

    return result[0];
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

  Advertisement imageFromJson(Map<String, dynamic> ds) {
    Advertisement result;

    result = Advertisement.getImageFrom(ds);

    return result;
  }

  Future<Advertisement> fetchAdvertisementImage(
      {required String imgName}) async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    advertisementUrl = "${advertisementUrl}advertisement/$imgName";

    Map<String, dynamic> map = {
      'imgName': imgName,
    };

    var body = utf8.encode(json.encode(map));

    var response = await http.post(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return imageFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load advertisement list');
    }
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
      throw Exception('Failed to load advertisement list');
    }
  }

  Future<Advertisement> fetchAdvertisement({required String imgName}) async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    final Map<String, dynamic> queryParameters;

    queryParameters = {'imgName': imgName};

    String queryString = Uri(queryParameters: queryParameters).query;

    advertisementUrl = '${advertisementUrl}advertisement?$queryString';

    http.Response response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    print(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return advertisementfromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load advertisement');
    }
  }
}
