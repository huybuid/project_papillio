import 'package:flutter/material.dart';
import 'package:project_papillio/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChanged;
  final double size;
  final Function validator;
  final Color color, boxColor;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.validator,
    this.boxColor,
    @required this.size, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: boxColor,
      size: size,
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        cursorColor: color,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
