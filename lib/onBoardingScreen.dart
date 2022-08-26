import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'home.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({Key? key}) : super(key: key);
  static final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    storage.write(
      key: "onBoarding",
      value:
      "온보딩페이지",
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: '아이택시앱에 오신 사용자분을 환영합니다.',
          body: '해당 앱은 한동대 학생들의 원활한 택시/카풀 이용을 위해 개발되었습니다. 카풀의 경우 법적으로 오전 7시~오전 9시, 오후 6시~오후 8시 까지만 허용됩니다.',
          image: buildImage('assets/logo_1.png'),
          decoration: PageDecoration(
            titleTextStyle: textTheme.headline1!.copyWith(fontSize: 19, color: colorScheme.onPrimary) as TextStyle,
            bodyTextStyle: textTheme.headline1!.copyWith(fontSize: 15, color: colorScheme.onPrimary) as TextStyle,
            pageColor: colorScheme.primary,
          )
        ),
        PageViewModel(
          title: '홈 화면',
          body: '우측 상단에 있는 버튼을 통해 방을 생성할 수 있습니다.\n'
              '시간, 탑승가능한 인원, 출발지와 도착지, 입장한 사람들의 짐의 개수 등을 확인하신 후 입장하시길 바랍니다.',
          image: buildImage('assets/mainScreen.png'),
          decoration: PageDecoration(
            titleTextStyle: textTheme.headline1!.copyWith(fontSize: 19, color: colorScheme.onPrimary) as TextStyle,
            bodyTextStyle: textTheme.headline1!.copyWith(fontSize: 15, color: colorScheme.onPrimary) as TextStyle,
            pageColor: colorScheme.primary,
          )
        ),
        PageViewModel(
          title: '타임라인',
          body: '입장하신 방은 타임라인화면에서 확인할 수 있습니다. 홈 화면에서 방에 입장하신 후 타임라인에 입장한 방이 뜨지 않는다면, 새로고침을 해주시길 바랍니다.\n\n'
              '방을 클릭하시면, 현재 방에 입장한 사람들의 이름과 연락처 정보를 알 수 있고 채팅방에 입장하실 수 있습니다.',
          image: buildImage('assets/timeLine.png'),
          decoration: PageDecoration(
            titleTextStyle: textTheme.headline1!.copyWith(fontSize: 19, color: colorScheme.onPrimary) as TextStyle,
            bodyTextStyle: textTheme.headline1!.copyWith(fontSize: 15, color: colorScheme.onPrimary) as TextStyle,
            pageColor: colorScheme.primary,
          )
        ),
      ],
      next: Icon(Icons.navigate_next, size: 40, color: colorScheme.secondary,),
      done: Text('홈으로', style: textTheme.headline1!.copyWith(color: colorScheme.secondary)),
      onDone: () => goToHome(context),
      showSkipButton: false,
      skip: Text('Skip', style: textTheme.headline1!.copyWith(color: colorScheme.secondary),), //by default, skip goes to the last page
      onSkip: () => goToHome(context),
      dotsDecorator: DotsDecorator(
        color: colorScheme.tertiary,
        activeColor: colorScheme.secondary,
      ),
      animationDuration: 500,
      globalBackgroundColor: colorScheme.primary,
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.grey,
      size: Size(10,10),
      activeColor: Colors.redAccent,
      activeSize: Size(22,10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      )
  );

  Widget buildImage(String path) => Center(
      child: Container(
        padding: EdgeInsets.only(top: 100.h),
        child: Image.asset(path),
      )
  );

  void goToHome(BuildContext context) => Get.to(Home());

  PageDecoration buildDecoration(textTheme, colorScheme) => PageDecoration(
    titleTextStyle: textTheme.headline,
    bodyTextStyle: TextStyle(fontSize: 20),
    pageColor: Colors.purple.shade50,
    imagePadding: EdgeInsets.all(0),
  );
}
