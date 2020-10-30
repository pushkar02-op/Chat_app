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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                elevation: 10,
                color: Colors.amber,
                child: Text('Register'),
                onPressed: () {
                  Navigator.pushNamed(context, "/reg");
                }),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
                elevation: 10,
                color: Colors.amber,
                child: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                }),
          ],
        )),
      ),
    );
  }
}
