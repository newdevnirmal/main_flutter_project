import 'dart:async';
import 'package:flutter/material.dart';
import 'package:main_project/ADMIN/admin_login.dart';
import 'package:main_project/ADMIN/admin_welcome.dart';
import 'package:main_project/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
var user_key;
class admin_splashscreen extends StatefulWidget {
  _admin_splashscreenState createState() => _admin_splashscreenState();
}

class _admin_splashscreenState extends State<admin_splashscreen> {

  void initState() {
    getValidationData().whenComplete(() async {
      await Timer(Duration(seconds: 1), () {
        user_key == null
            ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>admin_login()))
            : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                //Admin_Dashboard(data_passing_admin: null,)
                admin_welcome()));
      });
    });
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading......",
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }

  Future getValidationData() async {
    final SharedPreferences preflog = await SharedPreferences.getInstance();
    var obtainedemail = await preflog.getString('id');
    setState(() {
      user_key = obtainedemail;
    });
    print('thisis service  value $user_key');
  }
}
