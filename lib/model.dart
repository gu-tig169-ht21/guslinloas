import 'package:flutter/material.dart';
import 'api.dart';

class Task {
  String ID;
  String event;
  bool done;
  Task({
    required this.ID,
    required this.event,
    this.done = false,
  });

  void toggleCompleted(Task item) {
    done = !done;
  }

  static Map<String, dynamic> toJson(Task item) {
    return {
      'title': item.event,
      'done': item.done,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      ID: json['id'],
      event: json['title'],
      done: json['done'],
    );
  }
}

class myState extends ChangeNotifier {
  List<Task> _itemlist = [];
  String _filterBy = 'all';

  List<Task> get list => _itemlist;
  String get filterBy => _filterBy;

  Future getList() async {
    List<Task> list = await Item_Api.itemList();
    _itemlist = list;
    notifyListeners();
  }

  void addItem(Task item) async {
    _itemlist = await Item_Api.addItem(item);
    notifyListeners();
  }

  void removeItem(Task item) async {
    _itemlist = await Item_Api.deleteItem(item.ID);
    notifyListeners();
  }

  void setStatus(Task item) async {
    item.toggleCompleted(item);
    _itemlist = await Item_Api.updateItem(item.ID, item);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
