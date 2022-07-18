import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  String name ;
  Content(this.name);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "welcome, "+ name,
            style: TextStyle(color: Colors.blue),
          ),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          },
          child: Text("back to lab1"))
        ],
      )),
    );
  }
}
