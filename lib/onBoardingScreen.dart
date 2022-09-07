import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/src/theme.dart';
import 'package:onboarding/onboarding.dart';

import 'package:itaxi/home.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static final storage = new FlutterSecureStorage();
  late Material materialButton;
  int index = 0;

  final onBoardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: ITaxiTheme.lightColorScheme.secondary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160.h,
            ),
            Image.asset(
              'assets/logo_2.png',
              width: 80.w,
              height: 54.86.h,
            ),
            SizedBox(
              height: 16.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '한동이들의 No.1 교통 어플리케이션',
                style: Platform.isIOS
                    ? ITaxiTheme.textThemeIOS.subtitle1!.copyWith(
                        color: ITaxiTheme.lightColorScheme.primary,
                      )
                    : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                        color: ITaxiTheme.lightColorScheme.primary,
                      ),
              ),
            ),
            SizedBox(
              height: 160.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'iTaxi는',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.primary,
                            letterSpacing: -1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.primary,
                            letterSpacing: -1,
                          ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '원활한 택시 및 카풀 이용을 위해 개발되었습니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.primary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.primary,
                            wordSpacing: 1,
                          ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '카풀의 경우 법적으로 7시 ~ 9시, 18시 ~ 20시까지만 허용됩니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.primary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.primary,
                            wordSpacing: 1,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: ITaxiTheme.lightColorScheme.primary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40.h,
            ),
            Image.asset(
              'assets/mainScreen.png',
              width: 140.w,
              height: 280.h,
            ),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '홈 화면',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.secondary,
                            letterSpacing: -1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.secondary,
                            letterSpacing: -1,
                          ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '우측 상단의 버튼으로 방을 생성할 수 있습니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '시간, 탑승가능한 인원, 출발지와 도착지, 입장한 사람들의 짐의 개수 등을 확인한 후 입장하길 바랍니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: ITaxiTheme.lightColorScheme.primary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Image.asset(
              'assets/timeLine.png',
              width: 160.w,
              height: 280.h,
            ),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '타임라인',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.secondary,
                            letterSpacing: -1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: ITaxiTheme.lightColorScheme.secondary,
                            letterSpacing: -1,
                          ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '입장한 방은 타임라인에서 확인할 수 있습니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '홈 화면에서 방에 입장한 후 타임라인에 입장한 방이 뜨지 않는다면, 새로고침을 하길 바랍니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '방을 누르면, 현재 방에 입장한 사람의 이름 및 연락처를 알 수 있고 채팅방에 입장할 수 있습니다.',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          )
                        : ITaxiTheme.textThemeDefault.headline1!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                            wordSpacing: 1,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: index == 0
          ? ITaxiTheme.lightColorScheme.primary
          : ITaxiTheme.lightColorScheme.tertiary,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: Platform.isIOS
                ? ITaxiTheme.textThemeIOS.subtitle1!.copyWith(
                    color: index == 0
                        ? ITaxiTheme.lightColorScheme.secondary
                        : ITaxiTheme.lightColorScheme.primary,
                  )
                : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                    color: index == 0
                        ? ITaxiTheme.lightColorScheme.secondary
                        : ITaxiTheme.lightColorScheme.primary,
                  ),
          ),
        ),
      ),
    );
  }

  Material get _homeButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: ITaxiTheme.lightColorScheme.secondary,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Get.offAll(Home());
        },
        child: Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Home',
            style: Platform.isIOS
                ? ITaxiTheme.textThemeIOS.subtitle1!.copyWith(
                    color: ITaxiTheme.lightColorScheme.primary,
                  )
                : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                    color: ITaxiTheme.lightColorScheme.primary,
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    storage.write(
      key: "onBoarding",
      value: "온보딩페이지",
    );
    return Scaffold(
      body: ColorfulSafeArea(
        color: index == 0 ? colorScheme.secondary : colorScheme.primary,
        child: Onboarding(
          pages: onBoardingPagesList,
          onPageChange: (int pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index == 0 ? colorScheme.secondary : colorScheme.primary,
                border: Border.all(
                  width: 0.0,
                  color:
                      index == 0 ? colorScheme.secondary : colorScheme.primary,
                ),
              ),
              child: ColoredBox(
                color: index == 0 ? colorScheme.secondary : colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 48.w,
                    vertical: 44.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.polygon(
                            polygonDesign: PolygonDesign(
                              polygon: DesignType.polygon_circle,
                            ),
                          ),
                          activeIndicator: ActiveIndicator(
                            color: index == 0
                                ? colorScheme.primary
                                : colorScheme.tertiary,
                          ),
                          closedIndicator: ClosedIndicator(
                            color: index == 0
                                ? colorScheme.primary
                                : colorScheme.secondary,
                          ),
                        ),
                      ),
                      index == pagesLength - 1
                          ? _homeButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//           PageViewModel(
//             title: '타임라인',
//             body:
//                 '입장하신 방은 타임라인화면에서 확인할 수 있습니다. 홈 화면에서 방에 입장하신 후 타임라인에 입장한 방이 뜨지 않는다면, 새로고침을 해주시길 바랍니다.\n\n'
//                 '방을 클릭하시면, 현재 방에 입장한 사람들의 이름과 연락처 정보를 알 수 있고 채팅방에 입장하실 수 있습니다.',
//             image: Image.asset('assets/timeLine.png'),
//             decoration: PageDecoration(
//               titleTextStyle: textTheme.headline1!.copyWith(
//                 fontSize: Platform.isIOS ? 21 : 19,
//                 color: colorScheme.onPrimary,
//               ),
//               bodyTextStyle: textTheme.headline2!.copyWith(
//                 color: colorScheme.onPrimary,
//               ),
//               pageColor: colorScheme.primary,
//             ),
//           ),
//         ],
//         next: Icon(
//           Icons.navigate_next,
//           size: 40,
//           color: colorScheme.secondary,
//         ),
//         done: Text(
//           '홈으로',
//           style: textTheme.headline1!.copyWith(
//             color: colorScheme.secondary,
//           ),
//         ),
//         onDone: () => goToHome(context),
//         showSkipButton: false,
//         skip: Text(
//           'Skip',
//           style: textTheme.headline1!.copyWith(
//             color: colorScheme.secondary,
//           ),
//         ), //by default, skip goes to the last page
//         onSkip: () => goToHome(context),
//         dotsDecorator: DotsDecorator(
//           color: colorScheme.tertiary,
//           activeColor: colorScheme.secondary,
//         ),
//         animationDuration: 500,
//         globalBackgroundColor: colorScheme.primary,
//       ),
//     );
//   }

//   DotsDecorator getDotDecoration() => DotsDecorator(
//         color: Colors.grey,
//         size: const Size(10, 10),
//         activeColor: Colors.redAccent,
//         activeSize: const Size(22, 10),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//       );

//   Widget buildImage(Image image) => Center(
//         child: Container(
//           padding: EdgeInsets.only(top: 100.h),
//           child: image,
//         ),
//       );

//   void goToHome(BuildContext context) => Get.offAll(Home());
// }
