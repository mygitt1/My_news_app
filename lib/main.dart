
import 'package:flutter/material.dart';
import 'package:riafy/screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
        fontFamily: "Roboto"
      ),
      home: HomePage(),
    );
  }
}
