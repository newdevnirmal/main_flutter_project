import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:main_project/EVENTS/view_events.dart';
import 'package:main_project/FOOD/view_food.dart';
import 'package:main_project/MONEY/view_donations.dart';

import '../main.dart';

class change_food extends StatefulWidget {
  final login_model5 login_user;
  change_food({required this.login_user});
  @override
  _change_foodState createState() => _change_foodState();
}
class _change_foodState extends State<change_food> {
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController foodtypecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  var data='';
  var Date;
  late bool status;
  late String message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    fnamecontroller= TextEditingController(text: widget.login_user.foodname);
    foodtypecontroller=TextEditingController(text: widget.login_user.foodtype);
    datecontroller=TextEditingController(text: widget.login_user.date);
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: fnamecontroller,
                          decoration: InputDecoration(
                            labelText: "Edit Food Name",
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
                          controller: foodtypecontroller,
                          decoration: InputDecoration(
                            labelText: "Edit Foodtype",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 130,vertical: 2),
                        child: TextFormField(
                          controller: datecontroller,
                          onTap: ()async{
                            DateTime Date=await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2060)) as DateTime;
                            setState(() {
                              datecontroller.text=DateFormat('yyyy-MM-dd').format(Date);
                            });
                          },
                          style: TextStyle(color: Colors.purple),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                ),
                              ),
                              hintText: "    ENTER DATE",
                              hintStyle: TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
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
                              builder: (context) =>view_food()));
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
  Future<void> submit() async {
    var ID = widget.login_user.id;
    print(ID);
    var uri = Uri.parse("http://$ip/mainflutterdata/food/change_food.php?id=$ID");

    var response = await http.post(
      uri,
      body: {
        'foodname': fnamecontroller.text,
        'foodtype': foodtypecontroller.text,
        'date': datecontroller.text,
      },
    );
    //
    if (response.statusCode == 200) {
      print('Request successful');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
