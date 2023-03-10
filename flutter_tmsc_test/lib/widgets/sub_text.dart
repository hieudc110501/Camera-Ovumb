import 'package:edge_detection_example/utils/primary_font.dart';
import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const SubText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: PrimaryFont.regular(size, FontWeight.w400)
          .copyWith(color: color, height: 1.5),
      textAlign: TextAlign.center,
    );
  }
}
