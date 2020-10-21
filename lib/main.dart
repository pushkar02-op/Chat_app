import 'package:chat/pages/home.dart';
import 'package:chat/pages/login.dart';
import 'package:chat/pages/reg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/reg': (context) => Reg(),
      },
    ),
  );
}
