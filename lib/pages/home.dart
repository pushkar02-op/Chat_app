import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Container(
            child: MaterialButton(
                child: Text('Resister'),
                onPressed: () {
                  Navigator.pushNamed(context, "/reg");
                })),
      ),
    );
  }
}
