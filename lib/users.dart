import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OneItemScreen();
  }
}

class _OneItemScreen extends State<ItemsScreen> {
  late Future<List<OneItem>> item;
  @override
  void initState() {
    super.initState();
    item = RemoteDataSource().fitchItems();
    print(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: item,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                var myItems = (snapshot.data as List<OneItem>);
                print(myItems);
                return ListView.builder(
                    itemCount: myItems.length,
                    itemBuilder: ((context, index) => ItemRow(myItems[index])));
              } else if (snapshot.hasError) {
                return Container();
              }
              return CircularProgressIndicator();
            })));
  }
}

class ItemRow extends StatelessWidget {
  var _item;
  ItemRow(this._item);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Center(
          child: Card(
        child: Row(children: [
          Container(
            //child: Image.network(_item.picture),
            child: Image.network(
                "https://play-lh.googleusercontent.com/5e7z5YCt7fplN4qndpYzpJjYmuzM2WSrfs35KxnEw-Ku1sClHRWHoIDSw3a3YS5WpGcI"),
          ),
          Text(_item.title),
        ]),
      )),
    );
  }
}

class OneItem {
  String id;
  String picture;
  String title;
  String content;
  OneItem(this.id, this.picture, this.title, this.content);
  factory OneItem.fromJson(Map<String, dynamic> json) {
    return OneItem(
      json['id'],
      json['picture'],
      json['title'],
      json['content'],
    );
  }
}

class RemoteDataSource {
  Future<List<OneItem>> fitchItems() async {
    var response = await http.get(
        Uri.parse('http://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var list = (jsonResponse as List);
      var newList = list.map((e) => OneItem.fromJson(e)).toList();
      return newList;
    } else {
      throw Exception("Can't fitch data");
    }
  }
}

class ItemUseCase {
  Future<List<OneItem>> getItems() {
    return RemoteDataSource().fitchItems();
  }
}
