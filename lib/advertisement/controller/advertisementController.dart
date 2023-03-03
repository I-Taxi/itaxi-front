import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/place/model/advertisement.dart';
import 'package:itaxi/ip/controller/ipController.dart';

class AdvertisementController extends GetxController {
  late Future<List<Advertisement>> advertisements;
  late Future<Advertisement> advertisement;
  late Future<Advertisement> advertisementImage;
  IpController _ipController = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    advertisementImage = fetchAdvertisementImage(imgName: 'cra-recruiting');
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


  Future<Advertisement> fetchAdvertisementImage({required String imgName}) async {
    var advertisementUrl = _ipController.ip.toString();
    advertisementUrl = "${advertisementUrl}advertisement/image/$imgName";

    var response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return imageFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(utf8.decode(response.bodyBytes));
      throw Exception('Failed to load advertisement list');
    }
  }

  Future<List<Advertisement>> fetchAdvertisements() async {
    var advertisementUrl = _ipController.ip.toString();
    advertisementUrl = "${advertisementUrl}advertisement";

    var response = await http.get(
      Uri.parse(advertisementUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return advertisementsFromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load advertisement list');
    }
  }

  Future<Advertisement> fetchAdvertisement({required String imgName}) async {
    var advertisementUrl = _ipController.ip.toString();
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
      return advertisementfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load advertisement');
    }
  }
}
