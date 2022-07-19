import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ItemsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OneItemScreen();
  }
}

class _OneItemScreen extends State<ItemsScreen> {
  String? text;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    textEditingController.text = "controler";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "type here"),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
                onPressed: () {
                  print(textEditingController.text);
                  // textEditingController.clear();
                  writeToFile(textEditingController.text);
                },
                child: Text("save me!")),

            SizedBox(height: 30,),
            Divider(color: Colors.red,),
            SizedBox(height: 30,),

            Text(text ?? "oldtext"),
            
            SizedBox(height: 20,),
            
            ElevatedButton(
                onPressed: () {
                  // print("load data");
                  loadData();
                  print(text);
                  // readFromFile();
                },
                child: Text("Load Data"))
          ],
        ),
      ),
    );
  }

  void loadData() async {
    var name = await rootBundle.loadString("assets/text.txt");
    // text = name;
    // print(text);

    setState(() {
      text = name;
    });
  }

  void writeToFile(String text) async {
    var dir = await getApplicationDocumentsDirectory();
    var path = dir.path;
    var myFile = File('$path/itiexample.txt');
    await myFile.writeAsString(text);
  }

  void readFromFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var path = dir.path;
    var myFile = File('$path/itiexample.txt');
    var texty = await myFile.readAsString();

    setState(() {
      text =  texty;
    });
  }
}