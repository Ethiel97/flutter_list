import 'dart:convert';

import 'package:counter/Member.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyCounterApp());
}

class MyCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new MaterialApp(
      title: "List app",
      theme: new ThemeData(primaryColor: Colors.green.shade800),
      home: MyCounter(),
    );
  }
}

class MyCounter extends StatefulWidget {
  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _counter = 0;
  var _members = <Member>[];
  final _biggerFont =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  // void increment() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  void _loadData() async {
    String URL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(URL);

    setState(() {
      final membersJSON = json.decode(response.body);

      print(membersJSON[0]);

      membersJSON.forEach((memberJSON) =>
          _members.add(Member(memberJSON["login"], memberJSON["avatar_url"])));
    });
  }

  // toggleFav(Member member) {
  //   setState(() {
  //     // member.isFavorite = !member.isFavorite;
  //   });
  // }

  Widget _buildRow(int i) {
    return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new ListTile(
          leading: new CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green,
            backgroundImage: new NetworkImage(_members[i].avatarUrl),
          ),
          trailing: Icon(
              _members[i].isFavorite ? Icons.favorite_border : Icons.favorite,
              color: _members[i].isFavorite ? Colors.red : null),
          title: new Text(
            "${_members[i].login}",
            style: _biggerFont,
          ),
          onTap: () {
            setState(() {
              _members[i].isFavorite = !_members[i].isFavorite;
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("List app"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(12.0),
          shrinkWrap: true,
          itemCount: _members.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return new Divider();
            final index = position ~/ 2;

            return _buildRow(index);
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Click to increment',
        onPressed: () {},
        child: new Icon(Icons.add),
      ),
    );
    // TODO: implement build
  }
}
