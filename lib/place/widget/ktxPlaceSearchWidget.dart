import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/place/model/ktxPlace.dart';
import 'package:itaxi/place/controller/ktxPlaceSearchController.dart';

Widget placeSearchTile({
  required List<KtxPlace> placeList,
  required BuildContext context,
  required String depOrDet
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final KtxPlaceSearchController _ktxPlaceSearchController = Get.find();

  return Expanded(
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: placeList.length,
        itemBuilder: (_, int index) {
          return ListTile(
            //   trailing: Checkbox(
            //     value: widget.selectedList[index],
            // ),
            selectedColor: colorScheme.secondary,
            selected: index == _ktxPlaceSearchController.selectedIndex,
            leading: Image.asset(
              'assets/icon/location.png',
              width: 24.w,
              height: 24.h,
              color: index == _ktxPlaceSearchController.selectedIndex
                  ? colorScheme.onSecondaryContainer
                  : colorScheme.tertiaryContainer,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // if 문 추가해서 내 장소인지 나머지 구간들인지 구별해야 함.
              _ktxPlaceSearchController.selectedIndex = index;
              _ktxPlaceSearchController.selectedPlace = placeList[index];

              placeSearchSnackBar(
                context: context,
                title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '원하는 $depOrDet라면 ',
                      style: textTheme.subtitle2?.copyWith(
                        color: colorScheme.primary,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "상단의 다음",
                          style: textTheme.subtitle2?.copyWith(
                            color: colorScheme.secondary,
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
            title: Text(
              placeList[index].name!,
              style: textTheme.bodyText1?.copyWith(
                  color: (index == _ktxPlaceSearchController.selectedIndex)
                      ? colorScheme.secondary
                      : colorScheme.onTertiary),
            ),
          );
        }),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      duration: const Duration(seconds: 2),
    ),
  );
}
