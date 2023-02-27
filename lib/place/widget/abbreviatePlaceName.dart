import 'package:flutter/material.dart';

String? abbreviatePlaceName(String? place) {
  if (place == '그할마(CU장량그랜드점)') {
    return '그할마';
  } else if (place == '야옹아멍멍해봐') {
    return '야옹멍멍';
  } else if (place == '포항고속버스터미널') {
    return '포항고터';
  } else if (place == '포항시외버스터미널') {
    return '포항시터';
  } else if (place == '태화강 식당 사거리') {
    return '태화강';
  } else if (place != null) {
    return place;
  } else {
    return null;
  }
}
