import 'package:flutter/material.dart';
import 'package:helloworld/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SignInPage(),
    );
  }
}
