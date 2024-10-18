import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_login.dart';

import '../ADMIN/admin_login.dart';
import '../main.dart';
class userregister extends StatefulWidget {
  const userregister({Key? key}) : super(key: key);
  @override
  State<userregister> createState() => _userregisterState();
}
class _userregisterState extends State<userregister> {
  var _img;
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late bool status;
  late String message;
  @override
  void initState() {
    unamecontroller = TextEditingController();
    phonecontroller= TextEditingController();
    emailcontroller=TextEditingController();
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
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => user_login()));
          }, icon:Icon(Icons.login))
        ],
        title: Text("USER REGISTER"),
        backgroundColor: Colors.purple.shade600,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://wallpapercave.com/wp/wp11016562.jpg"),
            fit: BoxFit.cover,
          ),
        ),
child:  SingleChildScrollView(
  child: Form(
    key:_formkey,
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.purple,
                padding: EdgeInsets.only(
                    left: 60, right: 60, top: 20, bottom: 20),
              ),
              onPressed: () {
                gallery();
              }, child: Text("Choose DP from gallery",style: TextStyle(fontSize: 20,color: Colors.lightGreen),)),
        ),
        Container(
          // child: _img!=null?Image.file(_img):Text("No image"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: unamecontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                hintText: "Create User Name",
                hintStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: phonecontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                hintText: "Enter Phone Number",
                hintStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: emailcontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                hintText: "Enter Email",
                hintStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: passwordcontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                hintText: "Create Password",
                hintStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.only(
                left: 60, right: 60, top: 20, bottom: 20),
          ),
          onPressed: () {
            Submit();
          },
          child: Text("SUBMIT"),
        )
              ],
            ),
           ),
         ),
      ),
    );
  }
  Future Submit() async {
    var uri=Uri.parse("http://$ip/mainflutterdata/user/register_user.php");
    var request=http.MultipartRequest("POST",uri);
    request.fields['username']=unamecontroller.text;
    request.fields['phone']=phonecontroller.text;
    request.fields['email']=emailcontroller.text;
    request.fields['password']=passwordcontroller.text;
    var pic=await http.MultipartFile.fromPath("file",_img.path);
    print(_img);
    request.files.add(pic);
    request.send();
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
    }
    on PlatformException catch (e) {
      print("Failed");
    }
  }
}

