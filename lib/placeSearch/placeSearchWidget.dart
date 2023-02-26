import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/place.dart';
import 'package:itaxi/placeSearch/placeSearchController.dart';

import '../model/favoritePlace.dart';

Widget selectedView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: EdgeInsets.fromLTRB(20.0.w, 15.0.h, 20.0.w, 25.0.h),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorScheme.secondary,
          shape: BoxShape.rectangle,
        ),
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.primary),
        ),
      ));
}

Widget unselectedView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      child: Container(
        width: 67.0.w,
        height: 28.0.h,
        alignment: Alignment.center,
        child: Text(
          viewText,
          style: textTheme.headline1?.copyWith(color: colorScheme.onPrimary),
        ),
      ));
}

Widget selectedTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.secondary),
    ),
  );
}

Widget unSelectedTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      viewText,
      style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
    ),
  );
}

Widget searchTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: EdgeInsets.all(5),
    child: Container(
      width: 56.0.w,
      height: 27.0.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        viewText,
        style: textTheme.headline1?.copyWith(color: colorScheme.onSecondary),
      ),
    ),
  );
}

Widget unselectedSearchTypeView({required String viewText, required BuildContext context}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: EdgeInsets.all(5),
    child: Container(
      width: 56.0.w,
      height: 27.0.h,
      alignment: Alignment.center,
      child: Text(
        viewText,
        style: textTheme.subtitle2?.copyWith(color: colorScheme.tertiary),
      ),
    ),
  );
}

Widget placeSearchTile({
  required List<Place> placeList,
  required BuildContext context,
  required void Function()? favoritePressed,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final PlaceSearchController _placeSearchController = Get.find();

  return Expanded(
      child: ListView(
    children: [
      for (int index = 0; index < placeList.length; index++)
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // if 문 추가해서 내 장소인지 나머지 구간들인지 구별해야 함.
            _placeSearchController.selectedIndex = index;
            _placeSearchController.selectedPlace = placeList[index];

            placeSearchSnackBar(
              context: context,
              title: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '원하는 출발지라면 ',
                    style: textTheme.subtitle2?.copyWith(
                      color: colorScheme.primary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "다음",
                        style: textTheme.subtitle2?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                      TextSpan(
                        text: "을 눌러주세요.",
                        style: textTheme.subtitle2?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  )),
              color: Color(0xff69c077),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 16.h),
            child: SizedBox(
              width: 330.w,
              height: 32.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage('assets/icon/location.png'),
                        size: 24.r,
                        color: index == _placeSearchController.selectedIndex ? colorScheme.onSecondaryContainer : colorScheme.tertiaryContainer,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(placeList[index].name!,
                          style: index == _placeSearchController.selectedIndex
                              ? textTheme.subtitle2?.copyWith(
                                  color: colorScheme.onSecondaryContainer,
                                )
                              : textTheme.bodyText1?.copyWith(
                                  color: colorScheme.onTertiary,
                                ))
                    ],
                  ),
                  if (index == _placeSearchController.selectedIndex)
                    GestureDetector(
                      onTap: favoritePressed,
                      child: ImageIcon(
                        AssetImage('assets/button/add_favorite_place.png'),
                        size: 24.r,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    )
                ],
              ),
            ),
          ),
        )
    ],
  ));
}

Widget favoritePlaceSearchTile({
  required List<FavoritePlace> placeList,
  required BuildContext context,
  required void Function()? favoritePressed,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final PlaceSearchController _placeSearchController = Get.find();

  return Expanded(
    child: ListView(
      children: [
        for (int index = 0; index < placeList.length; index++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // if 문 추가해서 내 장소인지 나머지 구간들인지 구별해야 함.
              _placeSearchController.selectedIndex = index;
              _placeSearchController.favoriteSelectedPlace = placeList[index];
              _placeSearchController.selectedPlace = placeList[index].place;
          
              placeSearchSnackBar(
                context: context,
                title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '원하는 출발지라면 ',
                      style: textTheme.subtitle2?.copyWith(
                        color: colorScheme.primary,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "다음",
                          style: textTheme.subtitle2?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        TextSpan(
                          text: "을 눌러주세요.",
                          style: textTheme.subtitle2?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    )),
                color: Color(0xff69c077),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 16.h),
              child: SizedBox(
                width: 330.w,
                height: 32.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          AssetImage('assets/icon/location.png'),
                          size: 24.r,
                          color: index == _placeSearchController.selectedIndex ? colorScheme.onSecondaryContainer : colorScheme.tertiaryContainer,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(placeList[index].place!.name!,
                            style: index == _placeSearchController.selectedIndex
                                ? textTheme.subtitle2?.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                  )
                                : textTheme.bodyText1?.copyWith(
                                    color: colorScheme.onTertiary,
                                  )),
                      ],
                    ),
                    if (index == _placeSearchController.selectedIndex)
                      GestureDetector(
                        onTap: favoritePressed,
                        child: ImageIcon(
                          AssetImage('assets/button/remove_favorite_place.png'),
                          size: 24.r,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
      ],
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> placeSearchSnackBar({
  required BuildContext context,
  required Widget title,
  required Color color,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: title,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      width: 343.w,
      padding: EdgeInsets.only(top: 22.h, bottom: 22.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      duration: const Duration(seconds: 2),
    ),
  );
}
