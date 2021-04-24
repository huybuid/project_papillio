library project_papilio.theme;

import 'package:flutter/material.dart';

const Map<int, Color> swatch = {
  50: Color.fromRGBO(248, 248, 248, 1),
  100: Color.fromRGBO(211, 208, 203, 1),
  200: Color.fromRGBO(105, 191, 250, 1),
  300: Color.fromRGBO(55, 129, 238, 1),
  400: Color.fromRGBO(50, 110, 240, 1),
  500: Color.fromRGBO(47, 100, 245, 1), //2f64f5
  600: Color.fromRGBO(47, 100, 245, 0.7),
  700: Color.fromRGBO(47, 100, 245, 0.8),
  800: Color.fromRGBO(51, 42, 35, 1),
  900: Color.fromRGBO(0, 10, 10, 1),
  150: Color.fromRGBO(220, 227, 245, 1), //8ba9fa
};
const MaterialColor materialColor = MaterialColor(0xFF2F64F5, swatch);

const double kDefaultPadding = 20;
