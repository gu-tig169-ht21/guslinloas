import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_model.dart';

class ItemList extends StatelessWidget {
  final List<Task> list;

  ItemList(this.list);
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((Task task) => _taskItem(context, task)).toList());
  }

  Widget _taskItem(context, Task item) {
    var state = Provider.of<myState>(context, listen: false);
    return Card(
      margin: EdgeInsets.all(1),
      child: ListTile(
        leading: Checkbox(
          value: item.done,
          onChanged: (value) {
            state.setStatus(item);
          },
        ),
        title: Text(
          item.event,
          style: TextStyle(
              decoration: item.done ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
          onPressed: () {
            state.removeItem(item);
          },
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
