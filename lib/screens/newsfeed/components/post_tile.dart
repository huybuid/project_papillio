
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:project_papillio/models/comment.dart';
import 'package:project_papillio/models/post_item.dart';
import 'package:project_papillio/models/user.dart';
import 'package:project_papillio/services/post_services.dart';
import 'package:project_papillio/theme.dart';
import 'package:provider/provider.dart';

import 'comment_composer.dart';

class PostTile extends StatefulWidget {
  final PostItem post;
  final Function onHeartPress;
  final Function onCommentPress;
  final Function onSharePress;
  final Widget trailing;

  const PostTile({
    Key key,
    @required this.post,
    this.onHeartPress,
    this.onCommentPress,
    this.onSharePress, this.trailing}) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool isCommentPressed = false;

  @override
  Widget build(BuildContext context) {
    BubblesColor bubblesColor = BubblesColor(
        dotPrimaryColor: materialColor[500],
        dotSecondaryColor: materialColor[400],
        dotThirdColor: materialColor[300],
        dotLastColor: materialColor[200]
    );

    UserData user = Provider.of<UserData>(context);

    String getStringTime(DateTime time) {
      DateTime now = DateTime.now();
      DateFormat format = DateFormat('MMM d, yy, hh:mm');
      DateFormat timeOnlyFormat = DateFormat('hh:mm');
      if (time.month == now.month && time.year == now.year) {
        if (time.day == now.day)
          return 'Today, ' + timeOnlyFormat.format(time);
      }
      return format.format(time);
    }

    return Container(
      color: materialColor[50],
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Image.asset('assets/icons/profile.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            title: Text(
                (user.firstName + ' ' + user.lastName),
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(getStringTime(widget.post.timeCreated.toDate()),
                style: TextStyle()),
            trailing: widget.trailing,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(widget.post.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
          (widget.post.photo == null) ? Container() : Container(
              height: 400,
              child: Image.asset(widget.post.photo, fit: BoxFit.fitHeight)
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LikeButton(
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      EvaIcons.heart,
                      color: isLiked ? materialColor[500] : Colors.grey,
                      size: 25,
                    );
                  },
                  bubblesColor: bubblesColor,
                  onTap: widget.onHeartPress,
                ),
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.grey, size: 25,),
                  onPressed: () {
                    setState(() {
                      isCommentPressed = !isCommentPressed;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.grey, size: 25,),
                  onPressed: () {},
                ),
              ],
            )
          ),
          (isCommentPressed) ? StreamProvider<List<Comment>>.value(
            value: PostServices(id: widget.post.id).commentListData,
            child: CommentComposer())
              : Container(),
          Divider(),
        ],
      ),
    );
  }
}

