import 'package:edge_detection_example/utils/primary_font.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double size;
  final Color color;
  const TitleText({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: PrimaryFont.semibold(size, fontWeight).copyWith(
        color: color,
      ),
    );
  }
}
