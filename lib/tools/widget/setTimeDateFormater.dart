import 'package:intl/intl.dart';

String lookupDateFormater(DateTime dateTime) {
  String query = '';
  List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];
  query =
      '${DateFormat('MM월 dd일').format(dateTime)} (${korDays[dateTime.weekday - 1]})';
  return query;
}

String gatherDateFormater(DateTime dateTime) {
  String query = '';
  List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];
  query =
      '${DateFormat('MM월 dd일').format(dateTime)} (${korDays[dateTime.weekday - 1]}) ${DateFormat('hh:mm').format(dateTime)}';
  return query;
}

String gatherLinkDateFormater(DateTime dateTime) {
  String query = '';
  List<String> korDays = ['월', '화', '수', '목', '금', '토', '일'];
  query = '${DateFormat('MM/dd').format(dateTime)}(${korDays[dateTime.weekday - 1]}) ${DateFormat('hh:mm').format(dateTime)}';
  return query;
}
