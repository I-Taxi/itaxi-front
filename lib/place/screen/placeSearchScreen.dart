import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/place/controller/placeController.dart';
import 'package:itaxi/place/controller/placeSearchController.dart';
import 'package:itaxi/place/model/place.dart';
import 'package:itaxi/place/widget/placeSearchWidget.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final PlaceSearchController _placeSearchController = Get.find();
  final PlaceController _placeController = Get.find();
  final TextEditingController _searchTextController = TextEditingController();

  late String depOrDst;

  late List<Place> places;
  late List<Place> suggestions;

  List<String> depDstString = ['출발지', '도착지', '경유지'];

  // final List<String> st_dest = ["출발지", "도착지"];
  // int i = 0; //출발지, 도착지 판단.

  // static var _place = [
  //   [],
  //   ["한동대 전체", "한동택정", "오석 흡연장", "갈대상자관", "뉴턴홀", "팔각정(뉴턴)", "느헤미야홀"],
  //   ["양덕 전체", "그할마(CU장량그랜드점)", "궁물촌", "커피유야", "야옹아 멍멍해봐", "예성사무소", "다이소"],
  //   ["포항고속버스터미널", "포항시외버스터미널", "포항역", "영일대", "육거리"]
  // ];
  // int changeCol = 0;

  @override
  void initState() {
    super.initState();
    depOrDst = depDstString[_placeSearchController.depOrDst];
    places = _placeSearchController.places;
    suggestions = _placeSearchController.suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              shadowColor: colorScheme.shadow,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                '검색',
                style: textTheme.subtitle1?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    "assets/arrow/arrow_back_1.png",
                    color: colorScheme.tertiaryContainer,
                    width: 11.62.w,
                    height: 20.51.h,
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      if (_placeSearchController.depOrDst == 0) {
                        if (_placeSearchController.selectedPlace == null ||
                            _placeSearchController.selectedPlace != null &&
                                _placeController.dst != null &&
                                _placeSearchController.selectedPlace!.placeType != 5 &&
                                _placeSearchController.selectedPlace!.name == _placeController.dst!.name) {
                          // [TODO]: 출발지 도착지 같을때 띄우는거
                          placeSearchSnackBar(
                              context: context,
                              title: Text(
                                '출발지를 다시 선택해주세요.',
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                              ),
                              color: colorScheme.surfaceVariant);
                        } else {
                          _placeController.selectDep(place: _placeSearchController.selectedPlace!);
                          _placeSearchController.selectedIndex = -1;
                          _placeSearchController.changeSearchQuery('');
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Get.back();
                        }
                      } else if (_placeSearchController.depOrDst == 1) {
                        if (_placeSearchController.selectedPlace == null ||
                            _placeController.dep != null &&
                                _placeSearchController.selectedPlace!.name == _placeController.dep!.name) {
                          // [TODO]: 출발지 도착지 같을때 띄우는거
                          placeSearchSnackBar(
                              context: context,
                              title: Text(
                                '도착지를 다시 선택해주세요.',
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                              ),
                              color: colorScheme.surfaceVariant);
                        } else {
                          _placeController.selectDst(place: _placeSearchController.selectedPlace!);
                          _placeSearchController.selectedIndex = -1;
                          _placeSearchController.changeSearchQuery('');
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Get.back();
                        }
                      } else {
                        if (_placeSearchController.selectedPlace == null ||
                            _placeController.dep != null &&
                                _placeController.dst != null &&
                                _placeSearchController.selectedPlace!.placeType != 5 &&
                                _placeSearchController.selectedPlace!.name == _placeController.dep!.name &&
                                _placeSearchController.selectedPlace!.name == _placeController.dst!.name) {
                          // [TODO]: 출발지 도착지 같을때 띄우는거
                          placeSearchSnackBar(
                              context: context,
                              title: Text(
                                '경유지를 다시 선택해주세요.',
                                textAlign: TextAlign.center,
                                style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                              ),
                              color: colorScheme.surfaceVariant);
                        } else {
                          _placeController.addStopOver(place: _placeSearchController.selectedPlace!);
                          _placeSearchController.selectedIndex = -1;
                          _placeSearchController.changeSearchQuery('');
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Get.back();
                        }
                      }
                    },
                    child: Text(
                      "다음",
                      style: textTheme.subtitle2?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ))
              ],
            ),
            backgroundColor: colorScheme.background,
            body: ColorfulSafeArea(
              color: colorScheme.primary,
              child: GetBuilder<PlaceSearchController>(builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 46.0.h,
                        child: TextField(
                          //검색창 화면
                          textAlignVertical: TextAlignVertical.bottom,
                          style: textTheme.bodyText1?.copyWith(color: colorScheme.tertiary),
                          controller: _searchTextController,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Color(0xFFF1F1F1),
                            contentPadding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 11.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search, size: 24),
                              color: colorScheme.tertiary,
                            ),
                            hintText: "$depOrDst를 입력하세요",
                            hintStyle: textTheme.subtitle2?.copyWith(color: colorScheme.tertiary),
                            //prefixIconColor :
                          ),
                          onChanged: (value) {
                            _placeSearchController.changeSearchQuery(value);
                          },
                        ),
                      ),
                      // 자동완성 리스트
                      // [TODO]: 자동완성 부분 UI 완성
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
                                  _placeSearchController.selectedIndex = -1;
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
                      SizedBox(
                        height: 35.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          selectTypeButton(colorScheme, textTheme, 5, '내 장소', () {
                            _placeSearchController.placeType = 5;
                            _placeSearchController.changeSearchQuery('');
                            _placeSearchController.fetchFavoritePlace();
                            _placeSearchController.selectedIndex = -1;
                          }),
                          SizedBox(
                            width: 4.w,
                          ),
                          selectTypeButton(colorScheme, textTheme, 0, '한동대', () {
                            _placeSearchController.placeType = 0;
                            _placeSearchController.selectedIndex = -1;
                            // 리스트 보여주기
                          }),
                          SizedBox(
                            width: 4.w,
                          ),
                          selectTypeButton(colorScheme, textTheme, 1, '양덕', () {
                            _placeSearchController.placeType = 1;
                            _placeSearchController.selectedIndex = -1;
                            // 리스트 보여주기
                          }),
                          SizedBox(
                            width: 4.w,
                          ),
                          selectTypeButton(colorScheme, textTheme, 2, '타지역', () {
                            _placeSearchController.placeType = 2;
                            _placeSearchController.selectedIndex = -1;
                            // 리스트 보여주기
                          }),
                        ],
                      ),
                      Divider(thickness: 1, height: 1, color: colorScheme.onSurfaceVariant),
                      SizedBox(
                        height: 23.h,
                      ),
                      _placeSearchController.placeType == 5
                          ? favoritePlaceSearchTile(
                              placeList: _placeSearchController.favoritePlaces,
                              context: context,
                              favoritePressed: () async {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                int _resCode = await _placeSearchController.removeFavoritePlace();
                                if (_resCode == 0) {
                                  placeSearchSnackBar(
                                    context: context,
                                    title: Text(
                                      "제거되었습니다.",
                                      textAlign: TextAlign.center,
                                      style: textTheme.subtitle2?.copyWith(color: colorScheme.primary),
                                    ),
                                    color: colorScheme.surfaceVariant,
                                  );
                                }
                              },
                            )
                          : _placeSearchController.hasResult
                              ? placeSearchTile(
                                  placeList: _placeSearchController.typeFilteredResultList,
                                  context: context,
                                  favoritePressed: () async {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    int _resCode = await _placeSearchController.addFavoritePlace();
                                    if (_resCode == 0) {
                                      placeSearchSnackBar(
                                          context: context,
                                          title: Text("즐겨찾기에 추가되었습니다.",
                                              textAlign: TextAlign.center,
                                              style: textTheme.subtitle2?.copyWith(color: colorScheme.primary)),
                                          color: colorScheme.outline);
                                    }
                                  },
                                )
                              : placeSearchTile(
                                  placeList: _placeSearchController.typeFilteredList,
                                  context: context,
                                  favoritePressed: () async {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    int _resCode = await _placeSearchController.addFavoritePlace();
                                    if (_resCode == 0) {
                                      placeSearchSnackBar(
                                          context: context,
                                          title: Text(
                                            "즐겨찾기에 추가되었습니다.",
                                            textAlign: TextAlign.center,
                                            style: textTheme.subtitle2?.copyWith(
                                              color: colorScheme.primary,
                                            ),
                                          ),
                                          color: colorScheme.outline);
                                    }
                                  },
                                ),
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }

  ElevatedButton selectTypeButton(
      ColorScheme colorScheme, TextTheme textTheme, int type, String contentText, void onPressed()) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(56.w, 32.h),
        elevation: 0,
        backgroundColor: (_placeSearchController.placeType == type) ? colorScheme.secondary : colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        contentText,
        style: textTheme.subtitle2!.copyWith(
          color: (_placeSearchController.placeType == type) ? colorScheme.primary : colorScheme.tertiary,
        ),
      ),
    );
  }
}
