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
  final PlaceController _placeController = Get.find();
  final TextEditingController _searchTextController = TextEditingController();

  late String depOrDst;

  late List<Place> places;
  late List<Place> suggestions;

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
    depOrDst = _placeSearchController.depOrDst == 0 ? '출발지' : '도착지';
    places = _placeSearchController.places;
    suggestions = _placeSearchController.suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: (){
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
              fontWeight: FontWeight.bold,
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
                 onPressed: (){
                   if (_placeSearchController.depOrDst == 0) {
                     if (_placeSearchController.selectedPlace!.name == _placeController.dst!.name) {
                       // [TODO]: 출발지 도착지 같을때 띄우는거
                       placeSearchSnackBar(context: context, title: const Text('춥발지를 다시 선택해주세요.'));
                     }
                     else {
                       _placeSearchController.setDeparture();
                       _placeSearchController.selectedIndex = -1;
                       _placeSearchController.changeSearchQuery('');
                       Get.back();
                     }
                   }
                   else {
                     if (_placeSearchController.selectedPlace!.name == _placeController.dep!.name) {
                       // [TODO]: 출발지 도착지 같을때 띄우는거
                       placeSearchSnackBar(context: context, title: const Text('도착지를 다시 선택해주세요.'));
                     }
                     else {
                       _placeSearchController.setDestination();
                       _placeSearchController.selectedIndex = -1;
                       _placeSearchController.changeSearchQuery('');
                       Get.back();
                     }
                   }
                 },
                 child: Text(
                   "다음",
                   style: textTheme.subtitle1?.copyWith(
                     color: colorScheme.secondary,
                     fontWeight: FontWeight.bold,
                   ),
                 )
             )
           ],
        ),
        backgroundColor: colorScheme.background,
        body: ColorfulSafeArea(
          color: colorScheme.primary,
          child: GetBuilder<PlaceSearchController>(
          builder: (_) {
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
                    child: TextField(//검색창 화면
                      textAlignVertical: TextAlignVertical.bottom,
                      style: textTheme.headline1?.copyWith(
                          color: colorScheme.tertiary
                      ),
                      controller: _searchTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF1F1F1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: (){},
                          icon: const Icon(
                            Icons.search,
                            size: 20
                          ),
                          color: colorScheme.tertiary,
                        ),
                        hintText: "$depOrDst를 입력하세요",
                        hintStyle: textTheme.headline1?.copyWith(
                          color: colorScheme.tertiary
                        ),
                        //prefixIconColor :
                      ),
                      onChanged: (value){
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: (_placeSearchController.placeType == 5) ? colorScheme.secondary : colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: (){
                            _placeSearchController.placeType == 5;
                            // setState(() {
                            //   changeCol = 0;
                            //   _placeSearchController.selectedIndex = 100;
                            // });
                          },
                        child: Text(
                          '내 장소',
                          style: textTheme.subtitle1!.copyWith(
                            color: (_placeSearchController.placeType == 5) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: (_placeSearchController.placeType == 0) ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          _placeSearchController.placeType = 0;
                          _placeSearchController.selectedIndex = -1;
                          // 리스트 보여주기
                        },
                        child: Text(
                          '한동대',
                          style: textTheme.subtitle1!.copyWith(
                            color: (_placeSearchController.placeType == 0) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: (_placeSearchController.placeType == 1) ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (){
                          _placeSearchController.placeType = 1;
                          _placeSearchController.selectedIndex = -1;
                          // 리스트 보여주기
                        },
                        child: Text(
                          '양덕',
                          style: textTheme.subtitle1!.copyWith(
                            color: (_placeSearchController.placeType == 1) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: _placeSearchController.placeType == 2 ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (){
                          _placeSearchController.placeType = 2;
                          _placeSearchController.selectedIndex = -1;
                          // 리스트 보여주기
                        },
                        child: Text(
                          '타지역',
                          style: textTheme.subtitle1!.copyWith(
                            color: (_placeSearchController.placeType == 2) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      thickness: 1,
                      height: 1,
                      color: colorScheme.tertiary
                  ),
                  _placeSearchController.hasResult
                    ? placeSearchTile(
                      placeList: _placeSearchController.typeFilteredResultList,
                      context: context,
                      favoritePressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        // setState(() {
                        //   if(changeCol == 0){
                        //     _place[0].remove(_place[changeCol][index]);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //           content: Text(
                        //               "제거되었습니다.",
                        //              style: textTheme.headline2?.copyWith(
                        //                color: colorScheme.primary,
                        //              ),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         backgroundColor: Colors.red,
                        //         behavior: SnackBarBehavior.floating,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         duration: const Duration(seconds: 2),
                        //       ),
                        //     );
                        //   }
                        //   else{
                        //     if(!_place[0].contains(_place[changeCol][index]))
                        //       _place[0].add(_place[changeCol][index]); //중복 추가 안되게 막음.
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(
                        //           "즐겨찾기에 추가되었습니다.",
                        //           style: textTheme.headline2?.copyWith(
                        //             color: colorScheme.primary,
                        //           ),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //         backgroundColor: Colors.green,
                        //         behavior: SnackBarBehavior.floating,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         duration: const Duration(seconds: 2),
                        //       ),
                        //     );
                        //   }
                        // });
                      },
                    )
                    : placeSearchTile(
                      placeList: _placeSearchController.typeFilteredList,
                      context: context,
                      favoritePressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        // setState(() {
                        //   if(changeCol == 0){
                        //     _place[0].remove(_place[changeCol][index]);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //           content: Text(
                        //               "제거되었습니다.",
                        //              style: textTheme.headline2?.copyWith(
                        //                color: colorScheme.primary,
                        //              ),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         backgroundColor: Colors.red,
                        //         behavior: SnackBarBehavior.floating,
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         duration: const Duration(seconds: 2),
                        //       ),
                        //     );
                        //   }
                        //   else{
                        //     if(!_place[0].contains(_place[changeCol][index]))
                        //       _place[0].add(_place[changeCol][index]); //중복 추가 안되게 막음.
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(
                        //           "즐겨찾기에 추가되었습니다.",
                        //           style: textTheme.headline2?.copyWith(
                        //             color: colorScheme.primary,
                        //           ),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //         backgroundColor: Colors.green,
                        //         behavior: SnackBarBehavior.floating,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         duration: const Duration(seconds: 2),
                        //       ),
                        //     );
                        //   }
                        // });
                      },
                    ),
                ],
              ),
            );
          }),
          )
        ),
    );
  }
}
