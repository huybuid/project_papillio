import 'package:flutter/material.dart';
import 'package:project_papillio/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final double size;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.onPress,
    this.color,
    this.textColor = Colors.white, this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
