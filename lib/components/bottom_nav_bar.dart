import 'package:flutter/material.dart';
import '../theme.dart';

class BottomNavBar extends StatelessWidget {
  final Function onTap;
  final int currentIndex;

  const BottomNavBar({Key key, this.onTap, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: materialColor[500],
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'News feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud_rounded),
          label: 'Quick share',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box_rounded),
          label: 'To-do List',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}

