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
  int selected;
  var msgSender;

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
                  stream: fs
                      .collection("chat")
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // print(snapshot.);
                    var msg = snapshot.data.docs;
                    List<Widget> y = [];
                    for (var d in msg) {
                      var msgText = d.data()['text'];
                      msgSender = d.data()['sender'];
                      var msgWidget = Text("$msgText : $msgSender");

                      y.add(msgWidget);
                      // print(y);
                    }
                    return Container(
                        height: deviceheight * 0.8,
                        width: deviceWidth * 0.9,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: y.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (msgSender == signInUser) {
                                return Container(
                                  // alignment: Alignment.centerRight,
                                  child: new ListTile(
                                    title: y[index],
                                    hoverColor: Colors.blue,
                                    //leading: FlutterLogo(size: 56.0),
                                    selected: index == selected,
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                      });
                                    },
                                    contentPadding: EdgeInsets.all(0.5),
                                    selectedTileColor:
                                        Colors.lightBlue.shade100,
                                  ),
                                );
                              } else {
                                return new ListTile(
                                  title: y[index],
                                  hoverColor: Colors.blue,
                                  //leading: FlutterLogo(size: 56.0),
                                  // selected: index == selected,
                                  // onTap: () {
                                  //   setState(() {
                                  //     selected = index;
                                  //   });
                                  // },
                                  contentPadding: EdgeInsets.all(0.5),
                                  selectedTileColor: Colors.lightBlue.shade100,
                                );
                              }
                            }));
                  },
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
                      decoration: BoxDecoration(
                          border: Border.all(), shape: BoxShape.circle),
                      child: FlatButton(
                        child: Icon(Icons.send_rounded,
                            size: 50, color: Colors.blue),
                        onPressed: () async {
                          msgtextcontroller.clear();

                          await fs.collection("chat").add({
                            "text": chatmsg,
                            "sender": signInUser,
                            "time": DateTime.now().millisecondsSinceEpoch,
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
