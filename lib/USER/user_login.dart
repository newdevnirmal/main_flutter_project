import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/bottomnav.dart';
import 'package:main_project/USER/user_forgot_password_1.dart';
import 'package:main_project/USER/user_welcome.dart';
import 'package:main_project/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
class user_login extends StatefulWidget {
  const user_login({Key? key}) : super(key: key);
  @override
  State<user_login> createState() => _user_loginState();
}
class _user_loginState extends State<user_login> {
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late bool status;
  late String message;
  // late bool data;
  void initState() {
    unamecontroller=TextEditingController();
    passwordcontroller=TextEditingController();
    status = false;
    message = "";
    super.initState();
  }
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("USER"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.purple,Colors.pink,Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
                height: 530,
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
                        controller: unamecontroller,
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
                          hintText: "     USER NAME",
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 25, letterSpacing: 3, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user name';
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
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => user_forgot_password1()));
                    }, child:Text("forgot password ??",style: TextStyle(fontSize: 20,color: Colors.pinkAccent),))
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
    var APIURL =
    "http://$ip/mainflutterdata/user/user_login.php";
    // JSON mapping user-entered details
    Map<String, String> mappedData = {
      'username': unamecontroller.text,
      'password': passwordcontroller.text,
    };
    http.Response response = await http.post(Uri.parse(APIURL), body: mappedData);
    var data = jsonDecode(response.body);
    // print("***************");
    // print(data);
    if (data != null) {
      for (var user in data) {
        setState(() async {
          final preflog = await SharedPreferences.getInstance();
          preflog.setString('name', unamecontroller.text);
          preflog.setString('id', user['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => bottomnav()));
        });
      }
    }
  }
}



