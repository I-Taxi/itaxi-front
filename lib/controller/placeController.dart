import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/postController.dart';
import 'package:itaxi/controller/tabViewController.dart';
import 'package:itaxi/model/place.dart';

class PlaceController extends GetxController {
  late TabViewController _tabViewController = Get.find();
  late PostController _postController = Get.find();
  late DateController _dateController = Get.find();
  late Future<List<Place>> places;

  Place? dep; // 출발지
  Place? dst; // 도착지

  @override
  void initState() {
    super.onInit();
    getPlaces();
  }

  Future<void> getPlaces() async {
    places = fetchPlace();
    update();
  }

  // Places 데이터 가져오기
  List<Place> PlacefromJson(json) {
    List<Place> result = [];
    json.forEach((item) {
      result.add(Place.fromDocs(item));
    });

    return result;
  }

  Future<List<Place>> fetchPlace() async {
    // var placeUrl = "http://walab.handong.edu:8080/itaxi/api/";
    var placeUrl = dotenv.env['API_URL'].toString();
    placeUrl = placeUrl + 'place';

    var response = await http.get(Uri.parse(placeUrl));

    if (response.statusCode == 200) {
      return PlacefromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load places');
    }
  }

  void selectDep({required Place place}) {
    dep = place;
    update();
    _postController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController
          .formattingDateTime(_dateController.mergeDateAndTime()),
      postType: _tabViewController.currentIndex,
    );
  }

  void selectDst({required Place place}) {
    dst = place;
    update();
    _postController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController
          .formattingDateTime(_dateController.mergeDateAndTime()),
      postType: _tabViewController.currentIndex,
    );
  }
}
