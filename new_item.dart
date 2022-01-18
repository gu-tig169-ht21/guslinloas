import 'package:flutter/material.dart';
import 'model.dart';

//SIDA 2
class ItemListEdit extends StatefulWidget {
  final Task event;
  ItemListEdit(this.event);

  @override
  State<StatefulWidget> createState() {
    return item_list_edit_state(event);
  }
}

class item_list_edit_state extends State<ItemListEdit> {
  String event = 'Event';
  TextEditingController textEditingController = TextEditingController();

  item_list_edit_state(Task todo) {
    event = todo.event;

    textEditingController.addListener(() {
      setState(() {
        event = textEditingController.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new task...'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                      hintText: 'What are you going to do?'),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, Task(event: event, ID: ''));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add),
                  Text(
                    'ADD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
