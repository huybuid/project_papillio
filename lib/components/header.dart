import 'package:flutter/material.dart';
import '../theme.dart';

class Header extends StatelessWidget {
  final double height;
  final Widget child;

  const Header({Key key, this.height, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            materialColor[500],
            materialColor[200],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
