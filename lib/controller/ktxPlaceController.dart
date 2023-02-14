import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/ktxPostController.dart';
import 'package:itaxi/controller/screenController.dart';
import 'package:itaxi/model/ktxPlace.dart';

class KtxPlaceController extends GetxController {
  late ScreenController _screenController = Get.find();
  late KtxPostController _ktxPostController = Get.find();
  late DateController _dateController = Get.find();
  late Future<List<KtxPlace>> places;

  KtxPlace? dep; // 출발지
  KtxPlace? dst; // 도착지
  bool hasDep = false;
  bool hasDst = false;

  bool hasStopOver = false;
  List<KtxPlace?> stopOver = [];

  @override
  void onInit() {
    super.onInit();
    getPlaces();
  }

  Future<void> getPlaces() async {
    places = fetchPlace();
    update();
  }

  // Places 데이터 가져오기
  List<KtxPlace> PlacefromJson(json) {
    List<KtxPlace> result = [];
    json.forEach((item) {
      result.add(KtxPlace.fromDocs(item));
    });

    return result;
  }

  Future<List<KtxPlace>> fetchPlace() async {
    var placeUrl = dotenv.env['API_URL'].toString();
    placeUrl = '${placeUrl}ktx-place';

    var response = await http.get(Uri.parse(placeUrl));

    if (response.statusCode == 200) {
      return PlacefromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load places');
    }
  }

  void selectDep({required KtxPlace place}) {
    dep = place;
    if (!hasDep) hasDep = true;
    update();
    _ktxPostController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController
          .formattingDateTime(_dateController.mergeDateAndTime()),
    );
  }

  void selectDst({required KtxPlace place}) {
    dst = place;
    if (!hasDst) hasDst = true;
    update();
    _ktxPostController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController
          .formattingDateTime(_dateController.mergeDateAndTime()),
    );
  }

  void swapDepAndDst() {
    KtxPlace? temp = dep;
    dep = dst;
    dst = temp;
    update();
  }
}
