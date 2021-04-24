import 'package:flutter/material.dart';
import 'package:project_papillio/theme.dart';

class CommentComposer extends StatelessWidget {
  final Function onSubmit;

  const CommentComposer({Key key, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: materialColor[200]),
      ),
      child:TextField(
        decoration: InputDecoration(
          hintText: 'Add a comment...',
          border: InputBorder.none,
        ),
        onSubmitted: onSubmit,
        maxLines: 1,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

