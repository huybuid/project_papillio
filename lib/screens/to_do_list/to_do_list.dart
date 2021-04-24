import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_papillio/models/to_do_item.dart';
import 'package:project_papillio/services/to_do_list_services.dart';
import 'package:provider/provider.dart';
import 'package:project_papillio/screens/to_do_list/components/to_do_tile.dart';
import 'package:uuid/uuid.dart';
import '../../theme.dart';

class ToDoListBody extends StatefulWidget {
  final String uid;
  const ToDoListBody({Key key, this.uid}) : super(key: key);

  @override
  _ToDoListBodyState createState() => _ToDoListBodyState();
}

class _ToDoListBodyState extends State<ToDoListBody> {
  String activity = '';
  List<bool> tick = [];
  final audioPlayer = AudioCache(prefix: 'assets/sound_effects/');

  @override
  Widget build(BuildContext context) {
    final toDoList = Provider.of<List<ToDoItem>>(context) ?? [];
    print(toDoList.length);
    //toDoList.sort((a,b) => a.timeToDo.toDate().compareTo(b.timeToDo.toDate()));
    tick = [];
    for (ToDoItem x in toDoList) {
        tick.add((x.status == 'c') ? true : false);
    }
    _AddToDo() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 60,
        color: materialColor[50],
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'I want to...',
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) { setState(() => activity = value); },
                    ))),
            IconButton(
              icon: Icon(Icons.add_circle_rounded),
              color: materialColor[500],
              onPressed: (activity == '')
                  ? null
                  : () async {
                      try {
                        var uuid = Uuid();
                        DateTime date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2090));
                        TimeOfDay time = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
                        date = date.add(Duration(hours: time.hour, minutes: time.minute));
                        print(date.toString());
                        Timestamp timestamp = Timestamp.fromDate(date);
                        dynamic result = ToDoListServices(uid: widget.uid)
                            .updateToDoList(uuid.v4(), activity, timestamp, null,
                            Timestamp.now(), 'u');
                        setState(() => activity = '');
                      }
                      catch (e) {

                      }
                    },
              iconSize: 25,
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
              child: (toDoList.isEmpty) ? Container(
                alignment: Alignment.center,
                child: Text('All done, good job! Now try creating a new task!'),
              ) : ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    toDoItem: toDoList[index],
                    value: tick[index],
                    onTick: (value) async {
                      setState(() {
                        tick[index] = !tick[index];
                      });
                      if (value == true) {
                        audioPlayer.play('ding.mp3');
                        await ToDoListServices().executeToDoList(
                            toDoList[index].id, Timestamp.fromDate(DateTime
                            .now()), 'c');
                      }
                      else {
                        await ToDoListServices().executeToDoList(
                            toDoList[index].id, null, 'u');
                      }
                    },
                    onDeletePress: tick[index] ? () async {
                      await ToDoListServices().deleteToDoList(toDoList[index].id);
                      setState(() {});
                    } : null,
                  );
                  },
              )
          ),
          _AddToDo(),
        ],
      ),
    );
  }
}

class TaskComposer extends StatelessWidget {
  final Function onTextChanged;
  final Function onPressed;

  const TaskComposer(
      {Key key, @required this.onTextChanged, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      color: materialColor[50],
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'I want to...',
                    ),
                    cursorColor: materialColor[500],
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: onTextChanged,
                  ))),
          IconButton(
            icon: Icon(Icons.add_circle_rounded),
            color: materialColor[500],
            onPressed: onPressed,
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
