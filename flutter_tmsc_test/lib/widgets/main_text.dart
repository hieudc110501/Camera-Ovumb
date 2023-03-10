import 'package:edge_detection_example/utils/primary_font.dart';
import 'package:flutter/material.dart';


class MainText extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign align;
  const MainText({
    super.key,
    required this.text,
    required this.color,
    required this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: PrimaryFont.bold(
        24,
        FontWeight.w700,
      ).copyWith(
        color: color,
      ),
      textAlign: align,
    );
  }
}
