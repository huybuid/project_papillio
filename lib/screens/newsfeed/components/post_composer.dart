import 'package:flutter/material.dart';

import '../../../theme.dart';

class PostComposer extends StatelessWidget {
  final Function onTap;

  const PostComposer({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 60,
        color: materialColor[50],
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child:Text('Share your lifestyle!', style: TextStyle(color: Colors.grey, fontSize: 16)),
                )
            ),
            Icon(Icons.add_circle_rounded,
              color: materialColor[500],
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
