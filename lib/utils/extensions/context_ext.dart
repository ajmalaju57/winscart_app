import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  MediaQueryData get device => MediaQuery.of(this);

  Size get deviceSize => MediaQuery.of(this).size;
}
