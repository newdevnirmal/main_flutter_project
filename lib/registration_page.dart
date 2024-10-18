import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/ADMIN/admin_register.dart';
import 'package:main_project/USER/user_login.dart';
import 'package:main_project/USER/user_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class registration_page extends StatefulWidget {
  const registration_page({Key? key}) : super(key: key);
  @override
  State<registration_page> createState() => _registration_pageState();
}
class _registration_pageState extends State<registration_page> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:
        Scaffold(
          appBar: AppBar(
            title: Text("REGISTRATION"),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.menu_book),
                  text: "User",
                ),
                Tab(
                  icon: Icon(Icons.list_sharp),
                  text: "Admin",
                )
              ],
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              userregister(),
              adminregister()
            ],
          ),
        )
    );
  }
}
