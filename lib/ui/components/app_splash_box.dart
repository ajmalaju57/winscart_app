import 'package:flutter/material.dart';

import 'app_text.dart';

class AppSplashBox extends StatelessWidget {
  const AppSplashBox(
      {Key? key,
      required this.children,
      this.bgColor,
      this.bgGradient,
      this.bgImage,
      this.mainAlign = MainAxisAlignment.spaceBetween,
      this.color,
      this.size,
      this.weight})
      : super(key: key);

  final Color? bgColor;
  final Gradient? bgGradient;
  final List<Widget> children;
  final DecorationImage? bgImage;
  final MainAxisAlignment mainAlign;

  final Color? color;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      width: double.infinity,
      height: double.infinity,
      decoration:
          BoxDecoration(color: bgColor, gradient: bgGradient, image: bgImage),
      child: SafeArea(
          child: Column(mainAxisAlignment: mainAlign, children: [
        const Spacer(),
        ...children,
        const Spacer(),
        AppText("Version 1.0.0", color: color, size: size, weight: weight)
      ])),
    );
  }
}
