import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class AdvertisementController extends GetxController {
  late Future<List<String>> advertisements;
  late Image advertisement;

  AdvertisementController() {
    getAdvertisementes();
  }

  Future<void> getAdvertisementes() async {
    advertisements = fetchAdvertisementes();
    update();
  }

  List<String> advertisementeFromJson(json) {
    List<String> result = [];
    json.forEach(
      (item) {
        result.add("hi");
      },
    );
    return result;
  }

  Future<List<String>> fetchAdvertisementes() async {
    var advertisementUrl = dotenv.env['API_URL'].toString();
    advertisementUrl = "${advertisementUrl}advertisement";

    // var response = await http.get(
    //   Uri.parse(advertisementUrl),
    //   headers: <String, String>{
    //     'Content-type': 'application/json',
    //   },
    // );
    return advertisements;
  }
}
