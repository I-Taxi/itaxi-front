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

Widget unselectedView(
    {required String viewText, required BuildContext context}) {
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

Widget selectedTypeView(
    {required String viewText, required BuildContext context}) {
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

Widget unSelectedTypeView(
    {required String viewText, required BuildContext context}) {
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
        style: textTheme.headline1?.copyWith(color: colorScheme.tertiary),
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
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: placeList.length,
        itemBuilder: (_, int index){
          return ListTile(
            //   trailing: Checkbox(
            //     value: widget.selectedList[index],
            // ),
            selectedColor: colorScheme.secondary,
            selected: index == _placeSearchController.selectedIndex,
            leading: const Icon(
              Icons.location_on,
            ),
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
                      )
                  ),
                  color: Colors.green,
              );
            },
            trailing: IconButton(
              icon: Icon(
                  (_placeSearchController.placeType == 5) ? Icons.delete : Icons.add,
                  color: (index == _placeSearchController.selectedIndex) ? colorScheme.secondary : colorScheme.primary
              ),
              onPressed: favoritePressed,
            ),
            title: Text(
              placeList[index].name!,
              style: textTheme.bodyText1?.copyWith(color: (index == _placeSearchController.selectedIndex) ? colorScheme.secondary : colorScheme.onTertiary),
            ),
          );
        }
    ),
  );
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
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: placeList.length,
        itemBuilder: (_, int index){
          return ListTile(
            //   trailing: Checkbox(
            //     value: widget.selectedList[index],
            // ),
            selectedColor: colorScheme.secondary,
            selected: index == _placeSearchController.selectedIndex,
            leading: const Icon(
              Icons.location_on,
            ),
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
                    )
                ),
                color: Colors.green,
              );
            },
            trailing: IconButton(
              icon: Icon(
                  (_placeSearchController.placeType == 5) ? Icons.delete : Icons.add,
                  color: (index == _placeSearchController.selectedIndex) ? colorScheme.secondary : colorScheme.primary
              ),
              onPressed: favoritePressed,
            ),
            title: Text(placeList[index].place!.name!),
          );
        }
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}