import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_papillio/components/header.dart';
import 'package:project_papillio/components/rounded_button.dart';
import 'package:project_papillio/models/post_item.dart';
import 'package:project_papillio/models/quote_item.dart';
import 'package:project_papillio/models/to_do_item.dart';
import 'package:project_papillio/models/user.dart';
import 'package:project_papillio/screens/account/account.dart';
import 'package:project_papillio/screens/home/components/app_drawer.dart';
import 'package:project_papillio/screens/newsfeed/news_feed.dart';
import 'package:project_papillio/screens/to_do_list/to_do_list.dart';
import 'package:project_papillio/services/auth_services.dart';
import 'package:project_papillio/services/post_services.dart';
import 'package:project_papillio/services/quote_services.dart';
import 'package:project_papillio/services/to_do_list_services.dart';
import 'package:project_papillio/services/user_services.dart';
import 'package:project_papillio/theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../components/appbar.dart';
import '../../components/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
  final user = Provider.of<User>(context);
  final tabs = [
    NewsFeed(),
    DailyQuotes(),
    ToDoListBody(uid: user.uid),
  ];

  return MultiProvider(
      providers: [
        StreamProvider<List<PostItem>>.value(value: PostServices().postListData),
        StreamProvider<List<ToDoItem>>.value(value: ToDoListServices(uid: user.uid).toDoListData),
        StreamProvider<UserData>.value(value: UserServices(uid: user.uid).appUserData),
        StreamProvider<List<QuoteItem>>.value(value: QuoteServices().quoteListData),
      ],
      child: Scaffold(
        appBar: appBar('Papillio'),
        drawer: AppDrawer(
          profileTap: () {
            print('tap');
            Navigator.push(context, MaterialPageRoute(builder: (context) => StreamProvider<UserData>.value(
              value: UserServices(uid: user.uid).appUserData,
              child: Account(),
            ),));
          },
          signOut: () async {
            await _auth.SignOut(); },
        ),
        body: tabs[_currentTab],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentTab,
          onTap: (index) {
            setState(() {
              _currentTab = index;
            });
          },
        ),
        ),
      );
  }
}

class DailyQuotes extends StatefulWidget {
  @override
  _DailyQuotesState createState() => _DailyQuotesState();
}

class _DailyQuotesState extends State<DailyQuotes> {

  @override
  Widget build(BuildContext context) {
    final listItem = Provider.of<List<QuoteItem>>(context) ?? [];
    final userData = Provider.of<UserData>(context);
    final rand = Random(DateTime.now().millisecond);
    int currentItem = (listItem.isNotEmpty) ? rand.nextInt(listItem.length) : 0;
    String content='';
    String source='';

    void _showBottomSheet() {
      showModalBottomSheet(context: context,
          isScrollControlled: true,
          builder: (context) {

        return Container(
          height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child:  Text('Add a quote', style: TextStyle(color: materialColor[500]),),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextField(
                  onChanged: (value) { setState(() => content = value );} ,
                  decoration: InputDecoration(
                      hintText: 'Write your quote...'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextField(
                  onChanged: (value) { setState(() => source = value );} ,
                  decoration: InputDecoration(
                      hintText: 'Source...'
                  ),
                ),
              ),
              RoundedButton(
                  color: materialColor[500],
                  text: 'Add Quote',
                  size: MediaQuery.of(context).size.width * 0.4,
                  onPress: () async {
                    var uuid = Uuid();
                    await QuoteServices(uid: userData.uid).createQuoteItem(uuid.v4(), userData.uid, content, source, Timestamp.now(), 'a');
                  }
              ),
            ],
          ),
        );
      });
    }

    return Header(
      height: MediaQuery.of(context).size.height - 136,
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentItem++;
            if (currentItem >= listItem.length)
              currentItem = 0;
            print(currentItem);
          });
        },
        child: DailyQuoteCard(
          item: listItem[currentItem],
          onButtonPress: () => _showBottomSheet(),
        ),
      )
    );
  }
}

class DailyQuoteCard extends StatelessWidget {
  final QuoteItem item;
  final Function onButtonPress;
  const DailyQuoteCard({Key key, @required this.item, this.onButtonPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: materialColor[50],
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('Daily Quotes:',),
          ),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(item.content,
                      style: TextStyle(fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: Text(
                      item.source,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )

                ],
              )
          ),
          FloatingActionButton(
            clipBehavior: Clip.antiAlias,
            backgroundColor: materialColor[500],
            onPressed: onButtonPress,
            child: Icon(Icons.add_rounded, color: materialColor[50], size: 35,)
          ),
        ],
      ),
    );
  }
}


