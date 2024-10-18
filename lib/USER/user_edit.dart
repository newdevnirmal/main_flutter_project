import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:main_project/USER/user_change_password.dart';
import 'package:main_project/USER/user_welcome.dart';
import 'package:main_project/USER/userdata.dart';
import '../main.dart';
class user_edit extends StatefulWidget {
  final login_model login_user;
  user_edit({required this.login_user});
  @override
  _user_editState createState() => _user_editState();
}
class _user_editState extends State<user_edit> {
  var _img;
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  // TextEditingController passwordcontroller = TextEditingController();
  late bool status;
  late String message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    unamecontroller = TextEditingController(text: widget.login_user.username);
    phonecontroller = TextEditingController(text: widget.login_user.phone);
    emailcontroller = TextEditingController(text: widget.login_user.email);
    // passwordcontroller = TextEditingController(text: widget.login_user.password);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "EDIT",
        ),
        backgroundColor: Colors.brown.shade300,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, color: Colors.lightBlueAccent,
            size: 35, // add custom icons also
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://wallpapercave.com/wp/wp11016562.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.only(
                                  left: 100, right: 100, top: 20, bottom: 20),
                            ),
                            onPressed: () {
                              gallery();
                            }, child: Text("Choose from gallery")),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        child: _img == null ? Image.network(
                            widget.login_user.file) : Image.file(_img),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: unamecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter user Name",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: phonecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      //   child: TextFormField(
                      //     controller: passwordcontroller,
                      //     decoration: InputDecoration(
                      //       labelText: "Enter password",
                      //       border: new OutlineInputBorder(
                      //         borderSide: new BorderSide(color: Colors.blue),
                      //       ),
                      //     ),
                      //     keyboardType: TextInputType.text,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 20, bottom: 20),
                    ),
                    onPressed: () {
                      submit();
                      unamecontroller.clear();
                      phonecontroller.clear();
                      emailcontroller.clear();
                      // passwordcontroller.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>user_welcome()));
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => user_change_password(id:widget.login_user.id,)));
                  }, child: Text(
                    "Change Password",
                    style: TextStyle(fontSize: 20),
                  ), )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future gallery() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if (image == null) return;
      final imagetemp = File(image.path);

      setState(() {
        this._img = imagetemp;
      });
      print("**************");
      print(_img);
    } on PlatformException catch (e) {
      print("Failed");
    }
  }
  Future submit() async {
    var ID=widget.login_user.id;
    var uri=Uri.parse("http://$ip/mainflutterdata/user/user_edit.php?id=$ID");
    var request=http.MultipartRequest("POST",uri);
    request.fields['username']=unamecontroller.text;
    request.fields['phone']=phonecontroller.text;
    request.fields['email']=emailcontroller.text;
    // request.fields['password']=passwordcontroller.text;
    var pic=await http.MultipartFile.fromPath("file",_img.path);
    print(_img);
    request.files.add(pic);
    request.send();
  }
}