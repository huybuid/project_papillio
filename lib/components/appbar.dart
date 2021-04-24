import 'package:flutter/material.dart';

import '../theme.dart';

AppBar appBar(String title) {
  return AppBar(
      backgroundColor: materialColor[500],
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: '',
        ),
      ),
      centerTitle: true,
  );
}

