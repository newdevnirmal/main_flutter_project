import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:main_project/ADMIN/admin_welcome.dart';
import 'package:main_project/PRODUCT/view_product.dart';

import '../main.dart';

class edit_product extends StatefulWidget {
  final login_model3 login_user;
  edit_product({required this.login_user});
  @override
  _edit_productState createState() => _edit_productState();
}
class _edit_productState extends State<edit_product> {
  var _img;
  TextEditingController cidcontroller = TextEditingController();
  TextEditingController cnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  late bool status;
  late String message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    cidcontroller = TextEditingController();
    cnamecontroller= TextEditingController();
    descriptioncontroller=TextEditingController();
    pricecontroller=TextEditingController();
    quantitycontroller=TextEditingController();
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
                            widget.login_user.photo) : Image.file(_img),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: cidcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Craft ID",
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
                          controller: cnamecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Craft Name",
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
                          controller: pricecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter price",
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
                          controller: descriptioncontroller,
                          decoration: InputDecoration(
                            labelText: "Enter description",
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
                          controller: quantitycontroller,
                          decoration: InputDecoration(
                            labelText: "Enter quantity",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>admin_welcome()));
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future submit() async {
    var ID=widget.login_user.id;
    print(ID);
    var uri=Uri.parse("http://$ip/mainflutterdata/edit_product.php?id=$ID");
    var request=http.MultipartRequest("POST",uri);
    request.fields['cid']=cidcontroller.text;
    request.fields['craftname']=cnamecontroller.text;
    request.fields['description']=descriptioncontroller.text;
    request.fields['price']=pricecontroller.text;
    request.fields['quantity']=quantitycontroller.text;
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
    } on PlatformException catch (e) {
      print("Failed");
    }
  }
}
