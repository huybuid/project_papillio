import 'package:flutter/material.dart';
import 'package:project_papillio/theme.dart';

class AppDrawer extends StatelessWidget {
  final Function signOut;
  final Function profileTap;
  final String userFirstName;
  final String userLastName;

  const AppDrawer({Key key, this.signOut, this.userFirstName, this.userLastName, this.profileTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  materialColor[500],
                  materialColor[200],
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Expanded(
              child: DrawerItem(
                icon: Icon(Icons.account_circle_rounded, size: 28,
                  color: materialColor[500],),
                text: 'Profile',
                onTap: profileTap,
                color: materialColor[500],
              ),
          ),
          Divider(),
          DrawerItem(
            icon: Icon(Icons.logout, size: 28, color: Colors.red,),
            text: 'Sign out',
            onTap: signOut,
            color: Colors.red,
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function onTap;
  final Color color;

  const DrawerItem({Key key, this.icon, this.text, this.onTap, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(text,
        style: TextStyle(
          fontSize: 16,
          color: color
        ),
      ),
      onTap: onTap,
    );
  }
}

