import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/model/place.dart';
import 'package:itaxi/widget/selectPlaceDialog.dart';

class PlaceController extends GetxController {
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
    //?dep=${dep}&dst=${dst}&time=${time}
    var placeUrl = "http://walab.handong.edu:8080/itaxi/api/";
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
  }

  void selectDst({required Place place}) {
    dst = place;
    update();
  }
}
