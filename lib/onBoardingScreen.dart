import 'dart:io';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:itaxi/src/theme.dart';
import 'package:onboarding/onboarding.dart';
import 'package:itaxi/settings/addAccountScreen.dart';

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
            color: ITaxiTheme.lightColorScheme.background,
          ),
          child: Container(
            color: ITaxiTheme.lightColorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Image(image: AssetImage("assets/onBoarding/indicator1.png"), height: 4.h,),
                SizedBox(
                  height: 101.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '혼자 이동하기 부담이라면\n팀원들을 모아 보아요',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          )
                        : ITaxiTheme.textThemeDefault.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Image(
                  image: AssetImage("assets/onBoarding/onBoardingScreen1.png"),
                  width: 296.61.w,
                  height: 397.09.h,
                )
              ],
            ),
          )),
    ),
    PageModel(
      widget: DecoratedBox(
          decoration: BoxDecoration(
            color: ITaxiTheme.lightColorScheme.background,
          ),
          child: Container(
            color: ITaxiTheme.lightColorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Image(image: AssetImage("assets/onBoarding/indicator2.png"), height: 4.h,),
                SizedBox(
                  height: 101.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '입장한 방은 타임라인에서\n언제나 확인할 수 있어요',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          )
                        : ITaxiTheme.textThemeDefault.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 37.h,
                ),
                Image(
                  image: AssetImage("assets/onBoarding/onBoardingScreen2.png"),
                  width: 442.w,
                  height: 328.h,
                )
              ],
            ),
          )),
    ),
    PageModel(
      widget: DecoratedBox(
          decoration: BoxDecoration(
            color: ITaxiTheme.lightColorScheme.background,
          ),
          child: Container(
            color: ITaxiTheme.lightColorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Image(image: AssetImage("assets/onBoarding/indicator3.png"), height: 4.h,),
                SizedBox(
                  height: 101.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '자세한 이야기는\n채팅방에서 나눌 수 있어요',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          )
                        : ITaxiTheme.textThemeDefault.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 11.5.h,
                ),
                Image(
                  image: AssetImage("assets/onBoarding/onBoardingScreen3.png"),
                  width: 436.w,
                  height: 382.h,
                )
              ],
            ),
          )),
    ),
    PageModel(
      widget: DecoratedBox(
          decoration: BoxDecoration(
            color: ITaxiTheme.lightColorScheme.background,
          ),
          child: Container(
            color: ITaxiTheme.lightColorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Image(image: AssetImage("assets/onBoarding/indicator4.png"), height: 4.h,),
                SizedBox(
                  height: 101.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '계좌번호를 추가해두면\n편리하게 이용할 수 있어요',
                    style: Platform.isIOS
                        ? ITaxiTheme.textThemeIOS.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          )
                        : ITaxiTheme.textThemeDefault.headline3!.copyWith(
                            color: ITaxiTheme.lightColorScheme.onPrimary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image(
                  image: AssetImage("assets/onBoarding/onBoardingScreen4.png"),
                  width: 427.w,
                  height: 422.h,
                )
              ],
            ),
          )),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _nextButton();
    index = 0;
  }

  Material _nextButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: BorderRadius.circular(33),
      color: ITaxiTheme.lightColorScheme.secondary,
      child: InkWell(
        onTap: () {
          if (setIndex != null && index != 3) {
            index = index+1;
            setIndex(index);
          }
        },
        child: Container(
          width: 156.w,
          height: 64.h,
          child: Center(
            child: Text(
              '다음으로',
              style: Platform.isIOS
                  ? ITaxiTheme.textThemeIOS.subtitle1!
                      .copyWith(color: ITaxiTheme.lightColorScheme.primary)
                  : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                      color: ITaxiTheme.lightColorScheme.primary,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Column get _homeButton {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(33),
          color: ITaxiTheme.lightColorScheme.secondary,
          child: InkWell(
            onTap: () {
              Get.to(() => AddAccountScreen());
            },
            child: Container(
              width: 342.w,
              height: 64.h,
              child: Center(
                child: Text(
                  '계좌번호 입력하고 시작하기',
                  style: Platform.isIOS
                      ? ITaxiTheme.textThemeIOS.subtitle1!
                          .copyWith(color: ITaxiTheme.lightColorScheme.primary)
                      : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                          color: ITaxiTheme.lightColorScheme.primary,
                        ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Material(
          borderRadius: BorderRadius.circular(33),
          color: ITaxiTheme.lightColorScheme.primary,
          child: InkWell(
            onTap: () {
              Get.offAll(Home());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33),
                border: Border.all(
                  width: 1,
                  color: ITaxiTheme.lightColorScheme.secondary
                )
              ),
              width: 342.w,
              height: 64.h,
              child: Center(
                child: Text(
                  '지금은 건너뛰기',
                  style: Platform.isIOS
                      ? ITaxiTheme.textThemeIOS.subtitle1!.copyWith(
                          color: ITaxiTheme.lightColorScheme.secondary,
                        )
                      : ITaxiTheme.textThemeDefault.subtitle1!.copyWith(
                          color: ITaxiTheme.lightColorScheme.secondary,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    storage.write(
      key: "onBoarding",
      value: "온보딩페이지",
    );
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        child: Onboarding(
          pages: onBoardingPagesList,
          onPageChange: (int pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return Padding(
              padding: index == pagesLength - 1 ? EdgeInsets.only(bottom: 17.h) : EdgeInsets.only(bottom: 65.h),
              child: index == pagesLength - 1
                  ? _homeButton
                  : _nextButton(setIndex: setIndex),
            );
          },
        ),
      ),
    );
  }
}
