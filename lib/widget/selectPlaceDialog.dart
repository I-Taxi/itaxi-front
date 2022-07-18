import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/place.dart';

void selectPlaceDialog({required BuildContext context, required int type}) {
  PlaceController _placeController = Get.put(PlaceController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  List<String> places = ['한동대학교', '유야', '궁물촌', '그할마', '포항역', '하나로마트'];

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 360,
            padding: EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 12.0),
            child: Column(
              children: [
                (places.length >= 6)
                    ? displayPlaces(
                        context: context,
                        places: places.sublist(0, 6),
                        type: type)
                    : displayPlaces(
                        context: context, places: places, type: type),
                // if (places.length > 6)
                Icon(
                  Icons.arrow_drop_down,
                  color: colorScheme.tertiary,
                ),
                Divider(
                  color: colorScheme.tertiary,
                  thickness: 0.3,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '최근 검색 기록',
                    style: textTheme.subtitle1
                        ?.copyWith(color: colorScheme.tertiary),
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      '확인',
                      style: textTheme.headline1
                          ?.copyWith(color: colorScheme.secondary),
                    ))
              ],
            ),

            // child: FutureBuilder<List<Place>>(
            //   future: _placeController.places,
            //   builder: (BuildContext context, snapshot) {
            //     if (snapshot.hasData) {
            //       // place 가 있을 때
            //       if (snapshot.data!.isNotEmpty) {
            //
            //       }
            //       // place 가 없을 때
            //       else {
            //         return Center(
            //           child: Text('저장된 장소가 없습니다'),
            //         );
            //       }
            //     }
            //     // place read 중 오류 발생
            //     else if (snapshot.hasError) {
            //       return Center(
            //         child: Text(
            //           '${snapshot.error}',
            //         ),
            //       );
            //     }
            //     // place data reading
            //     return CircularProgressIndicator(
            //       color: colorScheme.secondary,
            //     );
            //   },
            // ),
          ),
        );
      });
}

Widget displayPlaces(
    {required BuildContext context,
    required List<String> places,
    required int type}) {
  PlaceController _placeController = Get.put(PlaceController());
  final colorScheme = Theme.of(context).colorScheme;
  final texttheme = Theme.of(context).textTheme;

  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2 / 1,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 4.0,
    ),
    itemCount: places.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // if (type == 0) {
          //   _placeController.selectDep(place: places[index]);
          // } else {
          //   _placeController.selectDst(place: places[index]);
          // }
          print(index);
          Get.back();
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '${places[index]}',
            style: texttheme.headline1
                ?.copyWith(color: colorScheme.tertiary, fontSize: 15),
          ),
        ),
      );
    },
  );
}
