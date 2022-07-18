import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:transfer/aa/content.dart';
import 'package:transfer/ditales.dart';

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
  String url ="https://freedomdefined.org/upload/6/62/Mfalzon-freecontent_logo01--normal.png";
  ItemRow(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      // width: MediaQuery.of(context).size.width / 3,
      child: Center(
          child: Card(
        child: Row(children: [
          Container(
            child: Image.network(
                //     _item.picture
                //     ""
                "https://freedomdefined.org/upload/6/62/Mfalzon-freecontent_logo01--normal.png"
                ),
          ),
          Text(_item.title),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ditales(_item);
                }));
              },
              child: Text("=>")),
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
