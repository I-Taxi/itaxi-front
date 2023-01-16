import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itaxi/controller/placeController.dart';
import 'package:itaxi/model/place.dart';

import 'dart:io';

class PlaceSearchController extends GetxController {
  int _currentIndex = 0;
  int _postType = 0;
  int _peopleCount = 2;
  int _depOrDst = 0;
  int _placeType = 0;
  int _selectedIndex = -1;

  String _searchQuery = '';

  late DateTime _pickedDate;
  late TimeOfDay _pickedTime;

  final PlaceController _placeController = Get.find();

  Place? selectedPlace;

  List<Place> places = [];
  final List<Place> _suggestions = [];
  final List<Place> _searchResult = [];
  final List<Place> _typeFilteredList = [];
  final List<Place> _typeFilteredResultList = [];

  bool _hasResult = false;

  int get currentIndex => _currentIndex;
  int get postType => _postType;
  int get peopleCount => _peopleCount;
  int get depOrDst => _depOrDst;
  int get placeType => _placeType;
  int get selectedIndex => _selectedIndex;

  String get searchQuery => _searchQuery;

  DateTime get pickedDate => _pickedDate;
  TimeOfDay get pickedTime => _pickedTime;

  List<Place> get suggestions => _suggestions;
  List<Place> get searchResult => _searchResult;
  List<Place> get typeFilteredList => _typeFilteredList;
  List<Place> get typeFilteredResultList => _typeFilteredResultList;

  bool get hasResult => _hasResult;

  set placeType(int value) {
    _placeType = value;
    filterPlacesByIndex();
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }

  void changeIndex(int idx) {
    _currentIndex = idx;
    update();
  }

  void changePostType(int idx) {
    _postType = idx;
    update();
  }

  void increasePeople() {
    if (_peopleCount < 4) {
      _peopleCount++;
      update();
    }
  }

  void decreasePeople() {
    if (_peopleCount > 2) {
      _peopleCount--;
      update();
    }
  }

  void removeResult() {
    _hasResult = false;
    _searchResult.clear();
    _typeFilteredResultList.clear();
  }

  void changeDepOrDst(int idx) {
    _depOrDst = idx;
    update();
  }

  void changePlaceType(int idx) {
    _placeType = idx;
    update();
  }

  void changeSearchQuery(String text) {
    _searchQuery = text;
    if (_hasResult) {
      removeResult();
    }
    getSearchSuggestions();
    update();
  }

  void setResultByQuery() {
    _hasResult = true;
    _searchResult.clear();

    _searchResult.addAll(places.where((element) {
      return (element.name != null && element.name!.contains(_searchQuery));
    }));
    _searchQuery = '';
    changePlaceType(_searchResult[0].placeType!);
    filterPlacesByIndex();
    update();
  }

  void getSearchSuggestions() {
    suggestions.clear();
    if (_searchQuery != '') {
      suggestions.addAll(places.where((element) {
        return (element.name != null && element.name!.contains(_searchQuery));
      }));
    }
  }

  void filterPlacesByIndex() {
    if (_hasResult) {
      _typeFilteredResultList.clear();
      _searchResult.forEach((place) {
        if (place.placeType == _placeType) {
          _typeFilteredResultList.add(place);
        }
      });
    }
    _typeFilteredList.clear();
    places.forEach((place) {
      if (place.placeType == _placeType) {
        _typeFilteredList.add(place);
      }
    });
    update();
  }

  void setDeparture() {
    _placeController.dep = selectedPlace;
    update();
  }

  void setDestination() {
    _placeController.dst = selectedPlace;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: pickedDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 31)),
        helpText: '출발일',
        cancelText: '취소',
        confirmText: '확인',
        fieldLabelText: '날짜를 입력해주세요',
        fieldHintText: '월/일/년도',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: colorScheme.copyWith(
                primary: colorScheme.secondary,
                onPrimary: colorScheme.primary,
                onSurface: colorScheme.tertiary,
              ),
              textTheme: textTheme.copyWith(
                bodySmall: TextStyle(
                  fontSize: Platform.isIOS ? 15 : 13,
                  fontFamily: 'Seoul',
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colorScheme.secondary,
                  textStyle: TextStyle(
                    fontSize: Platform.isIOS ? 15 : 13,
                    fontFamily: 'NotoSans',
                  ), // button text color
                ),
              ),
            ),
            child: child!,
          );
        }
    );

    if (selectedDate != null) {
      _pickedDate = selectedDate;
      update();

    }
  }

  Future<void> selectTime(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: '출발시간',
      cancelText: '취소',
      confirmText: '확인',
      hourLabelText: '시간',
      minuteLabelText: '분',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.secondary,
              onPrimary: colorScheme.primary,
              onSurface: colorScheme.tertiary,
            ),
            textTheme: textTheme.copyWith(
              bodySmall: TextStyle(
                fontSize: Platform.isIOS ? 15 : 13,
                fontFamily: 'Seoul',
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: colorScheme.secondary,
                textStyle: TextStyle(
                  fontSize: Platform.isIOS ? 15 : 13,
                  fontFamily: 'NotoSans',
                ), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      _pickedTime = selectedTime;
      update();
    }
  }

  DateTime mergeDateAndTime() {
    return DateTime(_pickedDate.year, _pickedDate.month, _pickedDate.day,
        _pickedTime.hour, _pickedTime.minute);
  }

  @override
  void onInit() {
    super.onInit();
    _placeController.places.then((value) {
      places = value;
      filterPlacesByIndex();
      update();
    });
    _pickedDate = DateTime.now();
    _pickedTime = TimeOfDay.now();
  }
}