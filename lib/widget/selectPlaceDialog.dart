import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/place.dart';

Dialog selectPlaceDialog({required BuildContext context, required int type}) {
  PlaceController _placeController = Get.put(PlaceController());
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Dialog(
    child: Container(
      child: FutureBuilder<List<Place>>(
        future: _placeController.places,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // place 가 있을 때
            if (snapshot.data!.isNotEmpty) {
              // return Text('데이터 있음');
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      type == 0
                          ? _placeController.selectDep(
                              place: snapshot.data![index])
                          : _placeController.selectDst(
                              place: snapshot.data![index]);
                    },
                    child: Container(
                      child: Text(
                        '${snapshot.data![index].name}',
                        style: textTheme.headline2
                            ?.copyWith(color: colorScheme.tertiary),
                      ),
                    ),
                  );
                },
              );
            }

            // place 가 없을 때
            else {
              return Center(
                child: Text('저장된 장소가 없습니다'),
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
          return CircularProgressIndicator(
            color: colorScheme.secondary,
          );
        },
      ),
    ),
  );
}
