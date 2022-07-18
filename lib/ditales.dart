import 'package:flutter/material.dart';

class ditales extends StatelessWidget {
  var item;
  ditales(this.item);
  @override
  Widget build(BuildContext context) {
    return Center(
      // heightFactor:10 ,
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        Text(
          item.title,
          style: TextStyle(color: Colors.blue),
        ),
        Text(
          item.content,
          style: TextStyle(color: Colors.black),
          // textAlign: TextAlign.center,
          
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("back to list"))
      ],
    ));
  }
}
