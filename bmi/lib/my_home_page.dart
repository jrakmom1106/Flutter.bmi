import 'package:bmi/LoginPage.dart';
import 'package:bmi/bmi_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }


    @override
    Future<void> initState() async {
      super.initState();

      _permission();
      _logout();
      _auth();
  }


  @override
  void dispose() {
    super.dispose();
  }
  _permission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    // logger.i(statuses[Permission.storage]);
  }

  _auth(){
    Future.delayed(const Duration(milliseconds: 100),()
    {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(() => const LoginPage());
      } else {
        Get.off(() => const BmiPage());
      }
    });
  }

  _listenAuth(){

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null){
        Get.off(() => const LoginPage());
      } else {
        Get.off(() =>const BmiPage());
      }


    });

  }
  _logout() async {
    await FirebaseAuth.instance.signOut();
  }

}