import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var msgtextcontroller = TextEditingController();

  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;

  String chatmsg;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    var signInUser = authc.currentUser.email;

    return Scaffold(
        appBar: AppBar(
          title: Text('chat'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator();
                    }
                    var msg = snapshot.data.docs;
                    List<Widget> y = [];
                    for (var d in msg) {
                      var msgText = d.data()['text'];
                      var msgSender = d.data()['sender'];
                      var msgWidget = Text("$msgText : $msgSender");
                      // if (msgSender == signInUser) {
                      // } else {}

                      y.add(msgWidget);
                    }

                    //print(y);

                    return Container(
                        height: deviceheight * 0.8,
                        width: deviceWidth * 0.9,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: y.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new ListTile(
                                title: y[index],
                              );
                            }));
                    // return Container(
                    //   child: Column(
                    //     children: y,
                    //   ),
                    // );
                  },
                  stream: fs.collection("chat").snapshots(),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: deviceWidth * 0.70,
                        child: TextField(
                          controller: msgtextcontroller,
                          decoration: InputDecoration(hintText: 'Enter msg ..'),
                          onChanged: (value) {
                            chatmsg = value;
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.20,
                      color: Colors.blue,
                      child: FlatButton(
                        child: Text('send'),
                        onPressed: () async {
                          msgtextcontroller.clear();

                          await fs.collection("chat").add({
                            "text": chatmsg,
                            "sender": signInUser,
                          });
                          print(signInUser);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
