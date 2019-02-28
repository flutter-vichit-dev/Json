import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  print(_data[0]);

  runApp(new MaterialApp(
      home: new Scaffold(
    appBar: new AppBar(
      title: new Text("JSON Parsing"),
      centerTitle: true,
      backgroundColor: Colors.teal,
    ),

    //Add List
    body: new Container(
        child: new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) return new Divider(color: Colors.teal);

        final position = index ~/ 2;

        return new ListTile(
          title: new Text(
            "${_data[index]["title"]}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),

          subtitle: new Text(
            "${_data[index]["body"]}",
            style: new TextStyle(fontSize: 14.5, fontStyle: FontStyle.italic),
          ),

          //Add Icon
          leading: new CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: new Text(
              "${_data[index]["title"][0].toString().toUpperCase()}",
              style: new TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
            ),
          ),

          //Event Click
          onTap: () {
            _onShowDialog(context, "${_data[index]["title"]}");
          },
        );
      },
    )),
  )));
}

////String
//Future<String> getJson() async {
//  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
//  http.Response response = await http.get(apiUrl);
//  return json.decode(response.body).toString(); //Return type String
//}

//List
Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

//Show Dialog
void _onShowDialog(BuildContext context, String msg) {
  var alert;

  if (alert == null) {
    alert = new AlertDialog(
      title: new Text("App"),
      content: new Text(msg),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("OK"))
      ],
    );
  }

  showDialog(context: context, child: alert);
}
