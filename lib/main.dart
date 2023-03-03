import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview/device_preview.dart';

import 'package:get/get.dart';
import 'package:itaxi/deeplink/model/dynamicLink.dart';
import 'package:itaxi/user/controller/signInController.dart';
import 'package:itaxi/firebase_options.dart';
import 'package:itaxi/main/screen/home.dart';
import 'package:itaxi/user/screen/signInScreen.dart';
import 'package:itaxi/user/screen/splashScreen.dart';
import 'package:itaxi/user/controller/userController.dart';
import 'package:itaxi/src/theme.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info/package_info.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'user/screen/onBoardingScreen.dart';
import 'package:itaxi/fcm/fcmController.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Handling a background message: ${message.messageId}');
}

int? initScreen;

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  //임시로 OS Error: CERTIFICATE_VERIFY_FAILED 해결
  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // firebase_core 패키지 필요
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  const AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );

  // iOS
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp())
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignInController _signInController = Get.put(SignInController());
  final UserController _userController = Get.put(UserController());

  static final storage = new FlutterSecureStorage();
  String? onBoardingInfo;
  int? isOnBoarding = 1; // 0일 경우, 온보딩 페이지 x / 1일 경우, 온보딩 페이지 띄우기

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final FCMController _fcmController;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var notification = message.notification;
      var android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print(channel.description);

      // android 인 경우
      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            )));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _onBoarding();
      },
    );

    _fcmController = FCMController(_fcm);

    if (Platform.isIOS) {
      _fcmController.requestPermission();
    }

    _fcmController.getMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('FirebaseMessaging.onMessageOpenedApp listened !');
      print(message.data);
    });

    DynamicLink().setup();
  }

  _onBoarding() async {
    onBoardingInfo = await storage.read(key: "onBoarding");

    if (onBoardingInfo != null) {
      isOnBoarding = 0;
    } else {
      isOnBoarding = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return GetMaterialApp(
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,

          title: 'iTaxi',
          //datepicker 언어 설정 한국어
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
          supportedLocales: [const Locale('ko', 'KR')],
          theme: ITaxiTheme.lightThemeData,
          debugShowCheckedModeBanner: false,
          home: GetBuilder<UserController>(builder: (_) {
            return GetBuilder<SignInController>(
              builder: (_) {
                if (_signInController.signInState == SignInState.firebaseSignedIn) {
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
                  return const SplashScreen();
                } else if (_signInController.signInState == SignInState.signedOut) {
                  return const SignInScreen();
                } else {
                  if (isOnBoarding == 1) {
                    return const OnBoardingScreen();
                  } else {
                    return Home();
                  }
                }
              },
            );
          }),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
