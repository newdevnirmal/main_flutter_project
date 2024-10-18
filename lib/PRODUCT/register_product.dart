import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_login.dart';

import '../main.dart';
class productregister extends StatefulWidget {
  const productregister({Key? key}) : super(key: key);
  @override
  State<productregister> createState() => _productregisterState();
}
class _productregisterState extends State<productregister> {
  var _img;
  TextEditingController cidcontroller = TextEditingController();
  TextEditingController cnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  late bool status;
  late String message;
  @override
  void initState() {
    cidcontroller = TextEditingController();
    cnamecontroller= TextEditingController();
    descriptioncontroller=TextEditingController();
    pricecontroller=TextEditingController();
    quantitycontroller=TextEditingController();
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
        title: Text("ADD PRODUCT"),
        backgroundColor: Colors.purple.shade600,
        centerTitle: true,
      ),
      body: Container(
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
                      }, child: Text("Choose product image from gallery",style: TextStyle(fontSize: 20,color: Colors.lightGreen),)),
                ),
                Container(
                  // child: _img!=null?Image.file(_img):Text("No image"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: cidcontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Craft ID",
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
                    controller: cnamecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Craft Name",
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
                    controller: descriptioncontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter description",
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
                    controller: pricecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Price",
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
                    controller: quantitycontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Create Quantity",
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
    var uri=Uri.parse("http://$ip/mainflutterdata/register_product.php");
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
    }
    on PlatformException catch (e) {
      print("Failed");
    }
  }
}

