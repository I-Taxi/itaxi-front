import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IpController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String ip = '';
  bool isError = false;

  @override
  void onInit() async {
    await fetchIp();
    super.onInit();
  }

  Future<void> fetchIp() async {
    isError = false;
    var result = _firestore.collection('Ip').doc('itaxiAddress').get();

    result.then((value) {
      if (value.data() != null) {
        ip = value.data()!['ip'];
      } else {
        isError = true;
        ip = dotenv.env['https://itaxi.kro.kr/api/'].toString();
      }
      update();
    });
  }
}
