import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:main_project/EVENTS/view_events.dart';
import 'package:main_project/MONEY/view_donations.dart';

import '../main.dart';

class change_events extends StatefulWidget {
  final login_model3 login_user;
  change_events({required this.login_user});
  @override
  _change_eventsState createState() => _change_eventsState();
}
class _change_eventsState extends State<change_events> {
  TextEditingController enamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  var data='';
  var Date;
  var time;
  late bool status;
  late String message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    enamecontroller= TextEditingController(text: widget.login_user.eventname);
    descriptioncontroller=TextEditingController(text: widget.login_user.description);
    datecontroller=TextEditingController(text: widget.login_user.date);
    timecontroller=TextEditingController(text: widget.login_user.time);
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
                          controller: enamecontroller,
                          decoration: InputDecoration(
                            labelText: "Edit Event Name",
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
                            labelText: "Edit description",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 130,vertical: 2),
                        child: TextFormField(
                          controller: timecontroller,
                          onTap: ()async{
                            var Time=await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now());
                            print(Time);
                            if(Time!=null)
                            {
                              setState(() {
                                timecontroller.text=Time.format(context);
                              });
                            }
                          },
                          style: TextStyle(color: Colors.purple),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                ),
                              ),
                              hintText: "    EDIT TIME",
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
                              builder: (context) =>view_events()));
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
    var uri = Uri.parse("http://$ip/mainflutterdata/events/change_event.php?id=$ID");

    var response = await http.post(
      uri,
      body: {
        'eventname': enamecontroller.text,
        'description': descriptioncontroller.text,
        'date': datecontroller.text,
        'time': timecontroller.text,
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
