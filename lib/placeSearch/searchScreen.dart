import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/placeSearch/placeSearchController.dart';
import 'package:itaxi/model/place.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/placeSearch/placeSearchWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PlaceSearchController _placeSearchController = Get.find();

  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final String depOrDst = _placeSearchController.depOrDst == 0 ? '출발' : '도착';

    List<Place> places = _placeSearchController.places;
    List<Place> suggestions = _placeSearchController.suggestions;

    return Scaffold(
      appBar: AppBar(
        shadowColor: colorScheme.shadow,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          '검색',
          style: textTheme.subtitle1?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ColorfulSafeArea(
        color: colorScheme.primary,
        child: GetBuilder<PlaceSearchController>(
          builder: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      width: 342.0.w,
                      height: 46.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: colorScheme.shadow,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _searchTextController,
                          autocorrect: false,
                          cursorColor: colorScheme.tertiary,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                              hintText: '${depOrDst}지를 입력하세요'
                          ),
                          onChanged: (value) {
                            _placeSearchController.changeSearchQuery(value);
                          },
                        ),
                      )
                  ),
                ),
                if (_placeSearchController.suggestions.isNotEmpty)
                  Container(
                    height: 50.0 + 30.0.h * suggestions.length,
                    child: ListView.builder(
                      padding: EdgeInsets.all(25),
                      itemCount: suggestions.length,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _searchTextController.text = suggestions[idx].name!;
                            _placeSearchController.changeSearchQuery(suggestions[idx].name!);
                            _placeSearchController.setResultByQuery();
                          },
                          child: Container(
                            height: 30.0.h,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(suggestions[idx].name!),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('내 장소');
                          _placeSearchController.changePlaceType(5);
                        },
                        child: (_placeSearchController.placeType == 5)
                          ? searchTypeView(viewText: '내 장소', context: context)
                          : unselectedSearchTypeView(viewText: '내 장소', context: context),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('한동대');
                          _placeSearchController.changePlaceType(0);
                          _placeSearchController.filterPlacesByIndex();
                        },
                        child: (_placeSearchController.placeType == 0)
                          ? searchTypeView(viewText: '한동대', context: context)
                          : unselectedSearchTypeView(viewText: '한동대', context: context),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('양덕');
                          _placeSearchController.changePlaceType(1);
                          _placeSearchController.filterPlacesByIndex();
                        },
                        child: (_placeSearchController.placeType == 1)
                          ? searchTypeView(viewText: '양덕', context: context)
                          : unselectedSearchTypeView(viewText: '양덕', context: context),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('타 지역');
                          _placeSearchController.changePlaceType(2);
                          _placeSearchController.filterPlacesByIndex();
                        },
                        child: (_placeSearchController.placeType == 2)
                          ? searchTypeView(viewText: '타 지역', context: context)
                          : unselectedSearchTypeView(viewText: '타 지역', context: context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: GetBuilder<PlaceSearchController>(
                      builder: (_) {
                        if (_placeSearchController.placeType == 5) {
                          if (_placeSearchController.hasResult) {

                            return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int idx) {
                                return ListTile(
                                  title: Text(_placeSearchController.searchResult[idx].name!),
                                );
                              }
                            );
                          }
                          return ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (BuildContext context, int idx) {
                              return ListTile(
                                title: Text(places[idx].name!),
                              );
                            }
                          );
                        }
                        if (_placeSearchController.hasResult) {
                          int _cnt = _placeSearchController.typeFilteredResultList.length;
                          _cnt = (_cnt == 0) ? 0 : 1;
                          return ListView.builder(
                              itemCount: _cnt,
                              itemBuilder: (BuildContext context, int idx) {
                                return ListTile(
                                  title: Text(_placeSearchController.typeFilteredResultList[idx].name!),
                                );
                              }
                          );
                        }
                        return ListView.builder(
                          itemCount: _placeSearchController.typeFilteredList.length,
                          itemBuilder: (BuildContext context, int idx) {
                            return ListTile(
                              title: Text(_placeSearchController.typeFilteredList[idx].name!),
                            );
                          }
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          })
      ),
    );
  }
}
