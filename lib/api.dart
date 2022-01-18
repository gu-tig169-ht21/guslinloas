import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;

const API_KEY = '173c7faa-942f-415b-bd68-dd3d5f81d098';
const API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';

class Item_Api {
  //lägg till
  static Future<List<Task>> addItem(Task item) async {
    Map<String, dynamic> json = Task.toJson(item);
    var bodyString = jsonEncode(json);
    var respone = await http.post(
      Uri.parse('$API_URL/todos?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = respone.body;
    var list = jsonDecode(bodyString);
    return list.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }

//ta bort
  static Future deleteItem(String itemID) async {
    var respone =
        await http.delete(Uri.parse('$API_URL/todos/$itemID?key=$API_KEY'));
    var bodyString = respone.body;
    var list = jsonDecode(bodyString);

    return list.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }

//uppdatera
  static Future updateItem(String itemID, Task item) async {
    Map<String, dynamic> json = Task.toJson(item);
    var bodyString = jsonEncode(json);
    var response = await http.put(
      Uri.parse('$API_URL/todos/$itemID?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }

//visa
  static Future<List<Task>> itemList() async {
    http.Response response =
        await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'));
    var jSonResp = response.body;
    var json = jsonDecode(jSonResp);
    return json.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }
}
