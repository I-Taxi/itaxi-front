import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/place.dart';

void selectPlaceDialog({required BuildContext context, required int type}) {
  PlaceController _placeController = Get.put(PlaceController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        child: Container(
          width: 360.w,
          height: 288.h,
          padding: EdgeInsets.fromLTRB(12.0.w, 32.0.h, 20.0.w, 12.0.h),
          child: FutureBuilder<List<Place>>(
            future: _placeController.places,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                // place 가 있을 때
                if (snapshot.data!.isNotEmpty) {
                  return Column(
                    children: [
                      (type == 0)
                          ? Text(
                              '출발지',
                              style: textTheme.headline1
                                  ?.copyWith(color: colorScheme.secondary),
                            )
                          : Text(
                              '도착지',
                              style: textTheme.headline1
                                  ?.copyWith(color: colorScheme.secondary),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      displayPlaces(
                          context: context, places: snapshot.data!, type: type),
                      // (snapshot.data!.length >= 6)
                      //     ? displayPlaces(
                      //         context: context,
                      //         places: snapshot.data!.sublist(0, 6),
                      //         type: type)
                      //     : displayPlaces(
                      //         context: context,
                      //         places: snapshot.data!,
                      //         type: type),
                      // Icon(
                      //   Icons.arrow_drop_down,
                      //   color: colorScheme.tertiary,
                      // ),
                      // Divider(
                      //   color: colorScheme.tertiary,
                      //   thickness: 0.3,
                      // ),
                      // const SizedBox(
                      //   height: 4.0,
                      // ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     '최근 검색 기록',
                      //     style: textTheme.subtitle1
                      //         ?.copyWith(color: colorScheme.tertiary),
                      //   ),
                      // ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '취소',
                          style: textTheme.headline1
                              ?.copyWith(color: colorScheme.tertiary),
                        ),
                      ),
                    ],
                  );
                }
                // place 가 없을 때
                else {
                  return Center(
                    child: Text(
                      '저장된 장소가 없습니다',
                      style: textTheme.headline1
                          ?.copyWith(color: colorScheme.tertiary, fontSize: 15),
                    ),
                  );
                }
              }
              // place read 중 오류 발생
              else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                  ),
                );
              }
              // place data reading
              return Center(
                child: CircularProgressIndicator(
                  color: colorScheme.secondary,
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

Widget displayPlaces(
    {required BuildContext context,
    required List<Place> places,
    required int type}) {
  PlaceController _placeController = Get.put(PlaceController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2 / 1,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 0.0,
    ),
    itemCount: places.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (type == 0) {
            _placeController.selectDep(place: places[index]);
          } else {
            _placeController.selectDst(place: places[index]);
          }
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '${places[index].name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline1
                ?.copyWith(color: colorScheme.tertiary, fontSize: 15),
          ),
        ),
      );
    },
  );
}
