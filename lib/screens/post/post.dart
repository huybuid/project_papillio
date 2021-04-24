import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_papillio/components/appbar.dart';
import 'package:project_papillio/models/user.dart';
import 'package:project_papillio/services/post_services.dart';
import 'package:project_papillio/theme.dart';
import 'package:uuid/uuid.dart';

class Post extends StatefulWidget {
  final UserData user;

  const Post({Key key, this.user}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String content='';
  String photo='';

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: Text("Choose a photo"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(onPressed: () {
                setState(() {
                  photo = 'assets/icons/weightlift.png';
                });
                Navigator.pop(context);
              },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/weightlift.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
              ),
              FlatButton(onPressed: () {
                setState(() {
                  photo = 'assets/icons/yoga.jpg';
                });
                Navigator.pop(context);
              },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/yoga.jpg'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No photo'),
              onPressed: () {
                setState(() {
                  photo = '';
                });
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    Color color = (content.isEmpty) ? Colors.grey : materialColor[200];
    return Scaffold(
      appBar: appBar('Post'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Image.asset('assets/icons/profile.png'),
              ),
              title: Text(widget.user.firstName + ' ' + widget.user.lastName, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Container(),
              trailing: FlatButton(
                onPressed: (content.isEmpty) ? null : () async {
                  var uuid = Uuid();
                  await PostServices().createPostItem(uuid.v4(), widget.user.uid, content, photo, Timestamp.now(), 'a');
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Post', style: TextStyle(fontSize: 12, color: color),),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                onChanged: (value) { setState(() {
                  content = value;
                }); },
                style: TextStyle(fontSize: 16),
                minLines: 2,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Share your lifestyle!',
                  border: InputBorder.none,
                ),
              ),
            ),
            (photo.isEmpty) ? Container() :
            Container(
                height: 400,
                child: Image.asset(photo, fit: BoxFit.fitHeight)
            ),
            IconButton(icon: Icon(Icons.add_a_photo_outlined, color: materialColor[200],),
              onPressed: _showMaterialDialog,
            ),
          ],
        ),
      ),
    );
  }
}

