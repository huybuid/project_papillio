import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_papillio/models/to_do_item.dart';
import 'package:project_papillio/theme.dart';
import 'package:provider/provider.dart';

class ToDoTile extends StatelessWidget {
  final ToDoItem toDoItem;
  final bool value;
  final Function onTick;
  final Function onDeletePress;

  const ToDoTile({Key key, @required this.toDoItem, this.value, this.onTick, this.onDeletePress}) : super(key: key);
  String getStringTime(DateTime time) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('EEE, MMM d, yyyy; hh:mm');
    DateFormat timeOnlyFormat = DateFormat('hh:mm');
    if (time.month == now.month && time.year == now.year) {
      if (time.day == now.day)
        return 'Today; ' + timeOnlyFormat.format(time);
    }
    return format.format(time);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: CheckboxListTile(
          title: Text(toDoItem.name),
          subtitle: Text(getStringTime(toDoItem.timeToDo.toDate())),
          secondary: IconButton(
            icon: Icon(Icons.delete_rounded),
            color: Colors.red,
            onPressed: onDeletePress,
          ),
          value: value,
          onChanged: onTick,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: materialColor[500],
        ),
      ),
    );
  }
}

