import 'package:flutter/material.dart';
import 'package:project_papillio/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final Function validator, onIconPressed;
  final Color color, boxColor;
  final double size;
  const RoundedPasswordField({
    Key key,
    this.hintText,
    this.obscureText = true,
    this.onChanged,
    this.validator,
    this.onIconPressed,
    this.color,
    this.boxColor, this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: boxColor,
      size: size,
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        cursorColor: color,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock_rounded,
            color: color,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility_rounded,
              color: color,
            ),
            onPressed: onIconPressed,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
