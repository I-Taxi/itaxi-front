import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itaxi/controller/ktxPlaceController.dart';
import 'package:itaxi/placeSearch/ktxPlaceSearchController.dart';
import 'package:itaxi/model/ktxPlace.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/placeSearch/ktxPlaceSearchWidget.dart';

class KtxSearchScreen extends StatefulWidget {
  const KtxSearchScreen({Key? key}) : super(key: key);

  @override
  State<KtxSearchScreen> createState() => _KtxSearchScreenState();
}

class _KtxSearchScreenState extends State<KtxSearchScreen> {
  final KtxPlaceSearchController _ktxPlaceSearchController = Get.find();
  final KtxPlaceController _ktxPlaceController = Get.find();
  final TextEditingController _searchTextController = TextEditingController();

  late String depOrDst;

  late List<KtxPlace> places;
  late List<KtxPlace> suggestions;

  List<String> depDstString = ['출발지', '도착지'];

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
    depOrDst = depDstString[_ktxPlaceSearchController.depOrDst];
    places = _ktxPlaceSearchController.places;
    suggestions = _ktxPlaceSearchController.suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
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
              icon: Icon(
                Icons.chevron_left_outlined,
                color: colorScheme.tertiary,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_ktxPlaceSearchController.depOrDst == 0) {
                      if (_ktxPlaceSearchController.selectedPlace == null ||
                          _ktxPlaceController.dst != null &&
                              _ktxPlaceSearchController.selectedPlace!.name ==
                                  _ktxPlaceController.dst!.name) {
                        // [TODO]: 출발지 도착지 같을때 띄우는거
                        placeSearchSnackBar(
                            context: context,
                            title: const Text('출발지를 다시 선택해주세요.'),
                            color: colorScheme.error);
                      } else {
                        _ktxPlaceController.selectDep(
                            place: _ktxPlaceSearchController.selectedPlace!);
                        _ktxPlaceSearchController.selectedIndex = -1;
                        _ktxPlaceSearchController.changeSearchQuery('');
                        Get.back();
                      }
                    } else if (_ktxPlaceSearchController.depOrDst == 1) {
                      if (_ktxPlaceSearchController.selectedPlace == null ||
                          _ktxPlaceController.dep != null &&
                              _ktxPlaceSearchController.selectedPlace!.name ==
                                  _ktxPlaceController.dep!.name) {
                        // [TODO]: 출발지 도착지 같을때 띄우는거
                        placeSearchSnackBar(
                            context: context,
                            title: const Text('도착지를 다시 선택해주세요.'),
                            color: colorScheme.error);
                      } else {
                        _ktxPlaceController.selectDst(
                            place: _ktxPlaceSearchController.selectedPlace!);
                        _ktxPlaceSearchController.selectedIndex = -1;
                        _ktxPlaceSearchController.changeSearchQuery('');
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
            child: GetBuilder<KtxPlaceSearchController>(builder: (_) {
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
                        style: textTheme.bodyText1
                            ?.copyWith(color: colorScheme.tertiary),
                        controller: _searchTextController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF1F1F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, size: 20),
                            color: colorScheme.tertiary,
                          ),
                          hintText: "$depOrDst를 입력하세요",
                          hintStyle: textTheme.bodyText1
                              ?.copyWith(color: colorScheme.tertiary),
                          //prefixIconColor :
                        ),
                        onChanged: (value) {
                          _ktxPlaceSearchController.changeSearchQuery(value);
                        },
                      ),
                    ),
                    // 자동완성 리스트
                    // [TODO]: 자동완성 부분 UI 완성
                    if (_ktxPlaceSearchController.suggestions.isNotEmpty)
                      Container(
                        height: 50.0 + 30.0.h * suggestions.length,
                        child: ListView.builder(
                          padding: EdgeInsets.all(25),
                          itemCount: suggestions.length,
                          itemBuilder: (context, idx) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _searchTextController.text =
                                    suggestions[idx].name!;
                                _ktxPlaceSearchController
                                    .changeSearchQuery(suggestions[idx].name!);
                                _ktxPlaceSearchController.setResultByQuery();
                                _ktxPlaceSearchController.selectedIndex = -1;
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
                    _ktxPlaceSearchController.hasResult
                        ? placeSearchTile(
                            placeList: _ktxPlaceSearchController
                                .typeFilteredResultList,
                            context: context,
                          )
                        : placeSearchTile(
                            placeList:
                                _ktxPlaceSearchController.typeFilteredList,
                            context: context,
                          ),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
