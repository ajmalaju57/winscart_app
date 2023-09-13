import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(this.text,
      {super.key,
      this.color,
      this.size = 14,
      this.align,
      this.maxLines,
      this.family,
      this.weight,
      this.style,
      this.overflow,
      this.decoration, this.decorationColor});

  final dynamic text;
  final String? family;
  final Color? color,decorationColor;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text('${text ?? ''}',
        maxLines: maxLines,
        overflow: overflow,
        style: style ??
            TextStyle(
                height: 1.6,
                fontSize: size,
                color: color,
                decoration: decoration,
                decorationColor: decorationColor,
                fontWeight: weight,
                fontFamily: family),
        textAlign: align);
  }
}
