// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:edge_detection_example/utils/primary_color.dart';
import 'package:edge_detection_example/utils/primary_font.dart';
import 'package:flutter/material.dart';


// cũng là input filed nhưng là border hình vuông
class InputFieldRectangle extends StatefulWidget {
  String name;
  String iconUrl;
  TextEditingController controller;
  bool isClick;

  InputFieldRectangle({
    Key? key,
    required this.name,
    required this.iconUrl,
    required this.controller,
    required this.isClick,
  }) : super(key: key);

  @override
  State<InputFieldRectangle> createState() => _InputFieldRectangleState();
}

class _InputFieldRectangleState extends State<InputFieldRectangle> {
  late FocusNode _focus;

  @override
  void initState() {
    _focus = FocusNode();
    _focus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: primaryColorGrey200,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focus,
        cursorColor: primaryColorRose500,
        style: PrimaryFont.medium(16, FontWeight.w500).copyWith(
          color: _focus.hasFocus ? primaryColorRose400 : primaryColorGrey400,
        ),
        decoration: InputDecoration(
          focusColor: primaryColorRose400,
          prefixIcon: Image.asset(
            widget.iconUrl,
            color: _focus.hasFocus ? primaryColorRose400 : primaryColorGrey400,
          ),
          prefixIconColor: primaryColorGrey400,
          hintText: widget.name,
          hintStyle: PrimaryFont.medium(16, FontWeight.w500).copyWith(
            color: primaryColorGrey400,
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          fillColor: primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 0,
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: widget.controller.text.isEmpty && widget.isClick
                ? const BorderSide(
                    width: 1,
                    color: primaryColorRose500,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
