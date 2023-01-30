import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController {
  final FirebaseMessaging fcm;

  FCMController(this.fcm);

  Future<void> requestPermission() async {

    // token = await FirebaseMessaging.instance.getToken();
    // 사용자가 이전에 설정한 알림 허용 상태를 가져옵니다.
    NotificationSettings previousSettings =
    await fcm.getNotificationSettings();

    // 사용자가 결정하지 않은 경우, 혀용 요청을 보냅니다.
    if (previousSettings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      NotificationSettings notificationSettings =
      await fcm.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);

      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }
  }

  Future<void> getMessage() async {
    RemoteMessage? message = await fcm.getInitialMessage();

    print('getInitialMessage() called !');
    print(message?.data);
  }
}