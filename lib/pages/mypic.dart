import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImage extends StatefulWidget {
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  File imagefilepath;
  var imgurl;
  var furl;

  clickphoto() async {
    var picker = ImagePicker();
    var image = await picker.getImage(
      source: ImageSource.camera,
    );

    print(imagefilepath);
    print('photo clicked');

    setState(() {
      imagefilepath = File(image.path);
    });

    var fbstorage =
        FirebaseStorage.instance.ref().child("myimages").child("my.jpg");
    print(fbstorage);

    fbstorage.putFile(imagefilepath);

    imgurl = await fbstorage.getDownloadURL();
    print(imgurl);

    setState(() {
      furl = imgurl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: clickphoto,
      ),
      appBar: AppBar(
        title: Text('Image'),
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: furl == null
                ? NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/lwsocialchatproject.appspot.com/o/myimages%2Fmy.jpg?alt=media&token=587267a7-3f2d-44c5-8208-8f3d456095fb')
                : NetworkImage(furl),
          )
        ],
      ),
      body: Center(
        child: Container(
            width: 200,
            height: 200,
            color: Colors.amberAccent,
            child: imagefilepath == null
                ? Text('set ur image')
                : Image.network(furl)),
      ),
    );
  }
}
