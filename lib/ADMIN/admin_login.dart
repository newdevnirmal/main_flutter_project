import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/ADMIN/admin_forgot_password1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../first_page.dart';
import '../main.dart';
import 'admin_welcome.dart';

class admin_login extends StatefulWidget {
  const admin_login({Key? key}) : super(key: key);
  @override
  State<admin_login> createState() => _admin_loginState();
}
class _admin_loginState extends State<admin_login> {
  TextEditingController anamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late bool status;
  late String message;
  void initState() {
    super.initState();
    status = false;
    message = "";
  }
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
        }, icon: Icon(Icons.arrow_back),),
        title: Text("ADMIN"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Container(
                width: 350,
                height: 560,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/appbg_blurr.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white12, width: 10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0, left: 70, right: 70),
                      child: Image.asset("assets/images/loginlogo.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: anamecontroller,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.red),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.greenAccent),
                          ),
                          hintText: "     ADMIN NAME",
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 25, letterSpacing: 3, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your admin name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: TextFormField(
                        controller: passwordcontroller,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.red),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.greenAccent),
                          ),
                          hintText: "      PASSWORD",
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 25, letterSpacing: 3, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.only(left: 70, right: 70, top: 20, bottom: 20),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Submit();
                          }
                        },
                        child: Text("LOGIN", style: TextStyle(fontSize: 20, color: Colors.pinkAccent)),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => admin_forgot_password1()));

                    }, child: Text("Forgot Password ??",style: TextStyle(color: Colors.pinkAccent,fontSize: 20),))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Submit() async {
    var APIURL = "http://$ip/mainflutterdata/admin/admin_login.php";

    // JSON mapping user-entered details
    Map<String, String> mappedData = {
      'adminname': anamecontroller.text,
      'password': passwordcontroller.text,
    };

    http.Response response = await http.post(Uri.parse(APIURL), body: mappedData);
    var data = jsonDecode(response.body);
    print("***************");
    print(data);

    if (data != null) {
      for (var user in data) {
        setState(() async {
          final preflog = await SharedPreferences.getInstance();
          preflog.setString('aname', anamecontroller.text);
          preflog.setString('id', user['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => admin_welcome()));
        });
      }
    }
  }
}