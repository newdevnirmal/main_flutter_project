import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/bottomnav.dart';
import 'package:main_project/USER/user_forgot_password_3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
class user_forgot_password2 extends StatefulWidget {
  const user_forgot_password2({Key? key}) : super(key: key);
  @override
  State<user_forgot_password2> createState() => _user_forgot_password2State();
}
class _user_forgot_password2State extends State<user_forgot_password2> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  late bool status;
  late String message;
  // late bool data;
  void initState() {
    phonecontroller=TextEditingController();
    emailcontroller=TextEditingController();
    status = false;
    message = "";
    super.initState();
  }
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FORGOT PASSWORD"),
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
                        padding: const EdgeInsets.only(top: 50.0, bottom: 70, left: 10, right: 10),
                        child: Text("ENTER  YOUR  EMAIL  AND  PHONE  NUMBER  FOR  THE  PASSWORD  RECOVERY  PROCESS", style: GoogleFonts.b612(
                          textStyle: TextStyle(color: Colors.lightGreenAccent,fontSize: 20),
                        ),)
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: emailcontroller,
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
                          hintText: "     EMAIL",
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 25, letterSpacing: 3, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your EMAIL';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        controller: phonecontroller,
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
                          hintText: "     PHONE NUMBER",
                          hintStyle: TextStyle(color: Colors.white38, fontSize: 25, letterSpacing: 3, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
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
                        child: Text("NEXT", style: TextStyle(fontSize: 20, color: Colors.pinkAccent)),
                      ),
                    ),
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
        "http://$ip/mainflutterdata/user/check_email_phone_forgot_password.php";
    // JSON mapping user-entered details
    Map<String, String> mappedData = {
      'email': emailcontroller.text,
      'phone': phonecontroller.text,
    };
    http.Response response = await http.post(Uri.parse(APIURL), body: mappedData);
    var data = jsonDecode(response.body);
    // print("***************");
    // print(data);
    if (data != null) {
      for (var user in data) {
        setState(() async {
          final preflog = await SharedPreferences.getInstance();
          preflog.setString('id', user['id']);
          print(user['id']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => user_forgot_password3(id: user['id'],)));
        });
      }
    }
  }
}



