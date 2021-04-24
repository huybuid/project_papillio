import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          child: Image.asset('assets/icons/profile.png',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text('test'),
        subtitle: Text('test'),
      ),
    );
  }
}