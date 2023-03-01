import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/place/controller/placeController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/post/screen/checkPlaceScreen.dart';
import 'package:package_info/package_info.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLink {
  Future<bool> setup() async {
    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    return isExistDynamicLink;
  }

  Future<bool> _getInitialDynamicLink() async {
    final String? deepLink = await getInitialLink();

    if (deepLink != null) {
      PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(deepLink));

      if (dynamicLinkData != null) {
        // _redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
      PendingDynamicLinkData dynamicLinkData,
    ) {
      // _redirectScreen(dynamicLinkData);
    }).onError((error) {
      debugPrint(error);
    });
  }

  void _redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    PostController _postController = Get.put(PostController());
    PlaceController _placeController = Get.put(PlaceController());

    if (dynamicLinkData.link.queryParameters.containsKey('id')) {
      String link = dynamicLinkData.link.path.split('/').last;
      String id = dynamicLinkData.link.queryParameters['id']!;

      switch (link) {
        case "chat":
          // TODO: 장소 검색 화면으로 옮기기 (post id 가져왔는데, 어떻게 접근할 것인가.)
          // _postController.fetchPostInfo(id: int.parse(id));
          // _placeController.selectDep(place: post.)
          Get.offAll(() => CheckPlaceScreen());
          break;
      }
    }
  }

  Future<String> getShortLink(String screenName, String id) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String dynamicLinkPrefix = 'https://itaxikakao.page.link/share';

    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('$dynamicLinkPrefix/$screenName?id=$id'),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,
        minimumVersion: '0',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }
}
