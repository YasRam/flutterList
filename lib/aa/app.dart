import 'dart:html';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:transfer/content.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Screen1());
  }
}

class Screen1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "hello",
            style: TextStyle(color: Colors.red),
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {return Content("yasser");}));
          }, 
          child: Text("go to another lab"))
        ],
      )),
    );
  }
}
