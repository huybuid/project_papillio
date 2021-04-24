import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_papillio/models/post_item.dart';
import 'package:project_papillio/models/user.dart';
import 'package:project_papillio/screens/newsfeed/components/post_tile.dart';
import 'package:project_papillio/screens/post/post.dart';
import 'package:project_papillio/services/post_services.dart';
import 'package:project_papillio/services/user_services.dart';
import 'package:provider/provider.dart';

import 'components/post_composer.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final postList = Provider.of<List<PostItem>>(context) ?? [];


    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: (postList.isEmpty) ? Container(color: Colors.grey) : ListView.separated(
                  itemCount: postList.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    thickness: 5,
                  ),
                  itemBuilder: (context,index) => StreamProvider<UserData>.value(
                    value: UserServices(uid: postList[index].uid).appUserData,
                    child: PostTile(
                      post: postList[index],
                      trailing: (postList[index].uid == user.uid)
                          ? IconButton(
                          icon: Icon(Icons.delete_rounded),
                          onPressed: () async {
                            await PostServices().deletePost(postList[index].id);
                            setState(() {});
                          }
                      ) : null,
                    ),
                  )
              )
          ),
          PostComposer(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Post(user: user),
                ));
              }
          )
        ],
      ),
    );
  }
}

