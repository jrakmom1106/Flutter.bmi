import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'package:bmi/my_home_page.dart';
import 'package:get/get.dart'; // 겟.dart 임포트할것
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


    @override
    State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{


  var _db;

  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() async {
    super.dispose();

  }


}




