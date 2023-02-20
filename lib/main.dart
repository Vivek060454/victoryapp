import 'package:flutter/material.dart';
import 'package:wowc/regis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(

        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.red,
        colorScheme: ThemeData().colorScheme.copyWith(primary: Color.fromRGBO(250,3,120,1),),
        primaryColor:  Color.fromRGBO(1,202,0,100),

      ),
      home: const Regis(),
    );
  }
}

