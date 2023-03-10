// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:edge_detection_example/utils/primary_color.dart';
import 'package:flutter/material.dart';


// tháng 1/2022
List<String> dates = ['8', '9', '10', '11', '12'];
String monthMarker = '2';
List<Color> colors = [
  primaryColorRose700,
  primaryColorRose600,
  primaryColorRose500,
  primaryColorRose400,
  primaryColorRose300,
];

List<String> dates1 = ['1', '2', '3', '4', '5'];
String monthMarker1 = '2';
List<Color> colors1 = [
  primaryColorPink300,
  primaryColorPink400,
  primaryColorPink500,
  primaryColorPink600,
  primaryColorPink700,
];

// lấy tất cả tháng trong năm
List<Map<String, DateTime>> getMonthDateRange(int year) {
  List<Map<String, DateTime>> monthDateRanges = [];

  for (int month = 1; month <= 12; month++) {
    DateTime firstDayOfMonth = DateTime.utc(year, month, 1);
    DateTime lastDayOfMonth = DateTime.utc(year, month + 1, 0);

    monthDateRanges.add({
      'start': firstDayOfMonth,
      'end': lastDayOfMonth,
    });
  }
  return monthDateRanges;
}

List<String> listOfMonth = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

List<String> listOfMonthVI = [
  'Tháng 1',
  'Tháng 2',
  'Tháng 3',
  'Tháng 4',
  'Tháng 5',
  'Tháng 6',
  'Tháng 7',
  'Tháng 8',
  'Tháng 9',
  'Tháng 10',
  'Tháng 11',
  'Tháng 12',
];

// các url của icon khi show modal bottom trong calendar
List<String> listIconUrl = [
  'assets/icons/calendar_icon1.png',
  'assets/icons/calendar_icon2.png',
  'assets/icons/calendar_icon3.png',
  'assets/icons/calendar_icon4.png',
  'assets/icons/calendar_icon5.png',
  'assets/icons/calendar_icon6.png',
];

// convert ngày tháng năm phân cách bởi dấu /
String convertDateTime(DateTime dateTime) =>
    '${dateTime.day}/${dateTime.month}/${dateTime.year}';

// convert ngày tháng năm phân cách bởi dấu .
String convertDateTimeChart(DateTime dateTime) =>
    '${dateTime.day}.${dateTime.month}.${dateTime.year}';
