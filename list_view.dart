import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'new_item.dart';
import 'model.dart';

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TIG169 TODO'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              Provider.of<myState>(context, listen: false)
                  .setFilterBy(value.toString());
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('All'),
                value: 'all',
              ),
              const PopupMenuItem(
                child: Text('Done'),
                value: 'done',
              ),
              const PopupMenuItem(
                child: Text('Undone'),
                value: 'undone',
              ),
            ],
          ),
        ],
      ),
      body: Consumer<myState>(
        builder: (context, state, child) =>
            ItemList(_filterList(state.list, state.filterBy)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var newItem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemListEdit(
                Task(event: 'Event', ID: ''),
              ),
            ),
          );
          if (newItem != null) {
            Provider.of<myState>(context, listen: false).addItem(newItem);
          }
        },
      ),
    );
  }

  List<Task> _filterList(list, filterBy) {
    if (filterBy == 'all') return list;
    if (filterBy == 'undone') {
      return list.where((item) => item.done == false).toList();
    }
    if (filterBy == 'done') {
      return list.where((item) => item.done == true).toList();
    }
    return list;
  }
}

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
      margin: const EdgeInsets.all(1),
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
