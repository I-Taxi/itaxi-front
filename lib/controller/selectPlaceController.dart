import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/model/place.dart';

class SelectPlaceController extends GetxController {
  // Places 데이터 가져오기
  List<Place> PlacefromJson(json) {
    List<Place> result = [];
    json.forEach((item) {
      result.add(Place.fromDocs(item));
    });

    return result;
  }

  Future<List<Place>> fetchPost(
      {required String dep, required String dst, required String time}) async {
    //?dep=${dep}&dst=${dst}&time=${time}
    var placeUrl = "http://203.252.99.211:8080/";
    placeUrl = placeUrl + 'place';

    var response = await http.get(Uri.parse(placeUrl));

    if (response.statusCode == 200) {
      return PlacefromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load places');
    }
  }
}
