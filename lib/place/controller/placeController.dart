import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/tools/controller/dateController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/tools/controller/screenController.dart';
import 'package:itaxi/place/model/place.dart';

class PlaceController extends GetxController {
  late ScreenController _screenController = Get.find();
  late PostController _postController = Get.find();
  late DateController _dateController = Get.find();
  late Future<List<Place>> places;

  Place? dep; // 출발지
  Place? dst; // 도착지
  bool hasDep = false;
  bool hasDst = false;

  bool hasStopOver = false;
  List<Place?> stopOver = [];

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
    var placeUrl = dotenv.env['API_URL'].toString();
    placeUrl = '${placeUrl}place/1';

    var response = await http.get(Uri.parse(placeUrl));

    if (response.statusCode == 200) {
      return PlacefromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load places');
    }
  }

  void selectDep({required Place place}) {
    dep = place;
    if (!hasDep) hasDep = true;
    update();
    _postController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController.formattingDateTime(_dateController.mergeDateAndTime()),
      postType: _screenController.mainScreenCurrentTabIndex,
    );
  }

  void selectDst({required Place place}) {
    dst = place;
    if (!hasDst) hasDst = true;
    update();
    _postController.getPosts(
      depId: dep?.id,
      dstId: dst?.id,
      time: _dateController.formattingDateTime(_dateController.mergeDateAndTime()),
      postType: _screenController.mainScreenCurrentTabIndex,
    );
  }

  void addStopOver({required Place place}) {
    stopOver.clear();
    stopOver.add(place);
    update();
  }

  void popStopOver() {
    stopOver.removeLast();
    update();
  }

  void clearStopOver() {
    stopOver.clear();
    update();
  }

  void swapDepAndDst() {
    if (hasDep && !hasDst) {
      Place? temp = dep;
      dst = temp;
      hasDep = false;
      hasDst = true;
      dep = null;
    } else if (!hasDep && hasDst) {
      Place? temp = dst;
      dep = temp;
      hasDep = true;
      hasDst = false;
      dst = null;
    } else {
      Place? temp = dep;
      dep = dst;
      dst = temp;
    }
    update();
  }

  void changeStopOverCount(bool to) {
    hasStopOver = to;
    update();
  }

  String printStopOvers() {
    String query = '';
    if (stopOver.isNotEmpty) {
      stopOver.length == 1 ? query = stopOver[0]!.name! : query = "${stopOver[0]!.name!} 외 ${stopOver.length - 1}";
    }
    return query;
  }
}
