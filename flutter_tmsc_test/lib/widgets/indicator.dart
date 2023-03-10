import 'package:edge_detection_example/utils/primary_color.dart';
import 'package:flutter/material.dart';


// indicator của chân trang question
Widget buildIndicator(bool isActive, Size size) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.bounceInOut,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    width: isActive ? size.width * 1 / 15 : size.width * 1 / 30,
    decoration: BoxDecoration(
      color: isActive ? primaryColorRose400 : primaryColorGrey300,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
  );
}
