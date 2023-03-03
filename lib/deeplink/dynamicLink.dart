import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/chat/screen/chatRoomListScreen.dart';
import 'package:itaxi/place/controller/placeController.dart';
import 'package:itaxi/post/controller/postController.dart';
import 'package:itaxi/post/screen/checkPlaceScreen.dart';
import 'package:package_info/package_info.dart';
import 'package:uni_links/uni_links.dart';

import '../post/screen/postDeepLinkScreen.dart';
import '../user/controller/signInController.dart';
import '../user/controller/userController.dart';
import '../user/screen/onBoardingScreen.dart';
import '../user/screen/signInScreen.dart';
import '../user/screen/splashScreen.dart';

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
        _redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  static final storage = new FlutterSecureStorage();
  String? onBoardingInfo;
  int? isOnBoarding = 1; // 0일 경우, 온보딩 페이지 x / 1일 경우, 온보딩 페이지 띄우기
  _onBoarding() async {
    onBoardingInfo = await storage.read(key: "onBoarding");

    if (onBoardingInfo != null) {
      isOnBoarding = 0;
    } else {
      isOnBoarding = 1;
    }
  }

  final SignInController _signInController = Get.put(SignInController());
  final UserController _userController = Get.put(UserController());

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink
        .listen((
      PendingDynamicLinkData dynamicLinkData,
    ) {})
        .onError((error) {
      debugPrint(error);
    });
  }

  void _redirectScreen(PendingDynamicLinkData dynamicLinkData) {
    PostController _postController = Get.put(PostController());

    print(dynamicLinkData.link.toString());
    if (dynamicLinkData.link.queryParameters.containsKey('id')) {
      String link = dynamicLinkData.link.path.split('/').last;
      String id = dynamicLinkData.link.queryParameters['id']!;
      print(link);
      print(id);
      print(link == 'chat');

      switch (link) {
        case 'chat':
          _postController.fetchPostInfo(id: int.parse(id));
          GetBuilder<UserController>(builder: (_) {
            return GetBuilder<SignInController>(
              builder: (_) {
                if (_signInController.signInState == SignInState.firebaseSignedIn) {
                  print("1");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _userController.getUsers().whenComplete(() {
                      if (_userController.userFetchSuccess) {
                        _signInController.signedInState();
                      } else {
                        _signInController.backServerErrorState();
                      }
                    });
                  });
                }
                if (_signInController.signInState == SignInState.start || _signInController.signInState == SignInState.firebaseSignedIn || _signInController.signInState == SignInState.backServerError) {
                  print(2);
                  return const SplashScreen();
                } else if (_signInController.signInState == SignInState.signedOut) {
                  print(3);
                  return const SignInScreen();
                } else {
                  print(4);
                  if (isOnBoarding == 1) {
                    return const OnBoardingScreen();
                  } else {
                    _postController.fetchPostInfo(id: int.parse(id));
                    return PostDeepLinkScreen();
                  }
                }
              },
            );
          });
          break;
      }
    }
  }

  Future<String> getShortLink(String screenName, String id, String text) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    String dynamicLinkPrefix = 'https://itaxikakao.page.link';

    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('$dynamicLinkPrefix/$screenName?id=$id'),
      // link: Uri.parse('https://www.example.com/'),
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

    // return dynamicLink.toString();
    return "Hi hello " + dynamicLink.shortUrl.toString();
  }
}
