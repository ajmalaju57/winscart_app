import 'package:flutter/material.dart';
import 'package:winscart/ui/components/app_text.dart';
import 'package:winscart/utils/color.dart';

class AppButton extends StatelessWidget {
  final double height, width, fontSize;
  final double? borderRadius;
  final Color btBgColor, textColor, assetColor;
  final Color? borderColor;
  final String? family;
  final String text;
  final String? assetName, leftAssetName;
  final void Function() onPressed;
  final bool isTrue;
  const AppButton({
    super.key,
    this.height = 45,
    required this.width,
    this.btBgColor = blue,
    this.borderColor,
    this.family = "",
    this.borderRadius = 10,
    required this.onPressed,
    required this.text,
    this.textColor = colorWhite,
    this.fontSize = 14,
    this.assetName,
    this.leftAssetName,
    this.isTrue = true,
    this.assetColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(width, height),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
        ),
        backgroundColor: btBgColor,
        side: BorderSide(
          color: borderColor ?? btBgColor,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // leftAssetName?.isNotEmpty ?? false
          //     ? AppSvg(assetName: leftAssetName ?? "")
          //     : 0.hBox,
          // 9.wBox,
          AppText(
            text,
            color: textColor,
            size: fontSize,
            family: family,
          ),
          // 9.wBox,
          // assetName?.isNotEmpty ?? false
          //     ? AppSvg(assetName: assetName ?? "", color: assetColor)
          //     : 0.hBox,
        ],
      ),
    );
  }
}

// BoxDecoration _decoration(bool isTrue) {
//   return const BoxDecoration(boxShadow: [
//     // // BoxShadow(
//     // //   color: isTrue ? buttonColor.withOpacity(0.6) : buttonColor.withOpacity(0.3),
//     // //   blurRadius: isTrue ? 18 : 25.0,
//     // //   spreadRadius: -4,
//     // //   offset: isTrue ? const Offset(0, 8) : const Offset(0, 6),
//     // // )
//   ]);
// }
