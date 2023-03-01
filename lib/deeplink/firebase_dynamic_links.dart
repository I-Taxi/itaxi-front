import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info/package_info.dart';

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
