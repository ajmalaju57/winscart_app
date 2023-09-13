// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcons, sufficIcon;
  final int? maxLine, maxLength;
  final TextEditingController controller;
  final TextInputType? inputType;
  void Function()? onTap;
  final bool obscureText;
  final bool fillcolor;
  final bool readOnly;
  void Function()? sufixOnTap;
  final TextAlign textAlign;
  final double? sufficIconSize;
  AppTextField({
    super.key,
    this.hintText = '',
    this.prefixIcons,
    this.sufficIcon,
    this.maxLine = 1,
    this.maxLength = 30,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.fillcolor = true,
    this.textAlign = TextAlign.start,
    this.sufficIconSize = 16,
    this.sufixOnTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      maxLines: maxLine,
      maxLength: maxLength,
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      textAlign: textAlign,
      readOnly: readOnly,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillcolor ? Colors.white : Colors.transparent,
        filled: false,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[400],
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        prefixIcon: Icon(
          prefixIcons,
          size: 18,
        ),
        suffixIcon: InkWell(
          onTap: sufixOnTap,
          child: Icon(
            sufficIcon,
            size: sufficIconSize,
          ),
        ),
      ),
    );
  }
}
