import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itaxi/placeSearch/placeSearchController.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  PlaceSearchController _placeSearchController = Get.put(PlaceSearchController());
  final TextEditingController _textEditingController = TextEditingController();


  final List<String> st_dest = ["출발지", "도착지"];
  int i = 0; //출발지, 도착지 판단.

  static var _place = [
    [],
    ["한동대 전체", "한동택정", "오석 흡연장", "갈대상자관", "뉴턴홀", "팔각정(뉴턴)", "느헤미야홀"],
    ["양덕 전체", "그할마(CU장량그랜드점)", "궁물촌", "커피유야", "야옹아 멍멍해봐", "예성사무소", "다이소"],
    ["포항고속버스터미널", "포항시외버스터미널", "포항역", "영일대", "육거리"]
  ];
  int changeCol = 0;
  bool _isVisible = false; // 클릭 시 아이콘 보이게 함.
  int _selectedIndex = 100; //초기에 강조되는 것을 피하기 위해서 설정함.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final colorScheme = Theme
        .of(context)
        .colorScheme;

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
                   setState(() {
                     i = 1;
                   });
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
                      controller: _textEditingController,
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
                        hintText: st_dest[i]+"를 입력하세요",
                        hintStyle: textTheme.headline1?.copyWith(
                          color: colorScheme.tertiary
                        ),
                        //prefixIconColor :
                      ),
                      onChanged: (value){
                        //여기에 자동 완성 기능 추가
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
                            backgroundColor: (changeCol == 0) ? colorScheme.secondary : colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: (){
                            setState(() {
                              changeCol = 0;
                              _selectedIndex = 100;
                            });
                          },
                        child: Text(
                          '내 장소',
                          style: textTheme.subtitle1!.copyWith(
                            color: (changeCol == 0) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: (changeCol == 1) ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (){
                          setState(() {
                            changeCol = 1;
                            _selectedIndex = 100;
                          });
                          // 리스트 보여주기
                        },
                        child: Text(
                          '한동대',
                          style: textTheme.subtitle1!.copyWith(
                            color: (changeCol == 1) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: (changeCol == 2) ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (){
                          setState(() {
                            changeCol = 2;
                            _selectedIndex = 100;
                          });
                          // 리스트 보여주기
                        },
                        child: Text(
                          '양덕',
                          style: textTheme.subtitle1!.copyWith(
                            color: (changeCol == 2) ? colorScheme.primary : colorScheme.tertiary,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: (changeCol == 3) ? colorScheme.secondary : colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: (){
                          setState(() {
                            changeCol = 3;
                            _selectedIndex = 100;
                          });
                          // 리스트 보여주기
                        },
                        child: Text(
                          '타지역',
                          style: textTheme.subtitle1!.copyWith(
                            color: (changeCol == 3) ? colorScheme.primary : colorScheme.tertiary,
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
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _place[changeCol].length,
                        itemBuilder: (_, int index){
                          return ListTile(
                            //   trailing: Checkbox(
                            //     value: widget.selectedList[index],
                            // ),
                            selectedColor: colorScheme.secondary,
                            selected: index == _selectedIndex,
                            leading: const Icon(
                              Icons.location_on,
                            ),
                            onTap: (){
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              setState(() {
                                // if 문 추가해서 내 장소인지 나머지 구간들인지 구별해야 함.
                                _selectedIndex = index;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: RichText(
                                        textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '원하는 출발지라면 ',
                                        style: textTheme.subtitle1?.copyWith(
                                          color: colorScheme.primary,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: "다음", style: textTheme.subtitle1?.copyWith(
                                            color: colorScheme.secondary,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          TextSpan(text: "을 눌러주세요."),
                                        ]
                                      )
                                    ),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                            trailing: IconButton(
                              icon: Icon(
                                (changeCol == 0) ? Icons.delete : Icons.add,
                                color: (index == _selectedIndex) ? colorScheme.secondary : colorScheme.primary
                              ),
                              onPressed: (){
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                setState(() {
                                  if(changeCol == 0){
                                    _place[0].remove(_place[changeCol][index]);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "제거되었습니다.",
                                             style: textTheme.headline2?.copyWith(
                                               color: colorScheme.primary,
                                             ),
                                            textAlign: TextAlign.center,
                                          ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                  else{
                                    if(!_place[0].contains(_place[changeCol][index]))
                                      _place[0].add(_place[changeCol][index]); //중복 추가 안되게 막음.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "즐겨찾기에 추가되었습니다.",
                                          style: textTheme.headline2?.copyWith(
                                            color: colorScheme.primary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                });
                              },
                            ),
                            title: Text(_place[changeCol][index]),
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          }),
          )
        ),
    );
  }
}




