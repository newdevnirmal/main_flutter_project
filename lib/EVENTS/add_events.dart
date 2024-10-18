import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:main_project/USER/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class add_event extends StatefulWidget {
  const add_event({Key? key}) : super(key: key);
  @override
  State<add_event> createState() => _add_eventState();
}
class _add_eventState extends State<add_event> {
  TextEditingController enamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  var data='';
  var Date;
  var time;
  late bool status;
  late String message;
  @override
  void initState() {
    enamecontroller= TextEditingController();
    descriptioncontroller=TextEditingController();
    datecontroller=TextEditingController();
    timecontroller=TextEditingController();
    status = false;
    message = "";
    super.initState();
    getdata();
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
        title: Text("ADD EVENTS"),
        backgroundColor: Colors.purple.shade600,
        centerTitle: true,
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://wallpaperaccess.com/full/862301.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:  SingleChildScrollView(
          child: Form(
            key:_formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 2,
                  width: 3,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: enamecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Event Name",
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
                  height: 40,
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
                SizedBox(
                  height: 40,
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
                        hintText: "    ENTER TIME",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  height: 40,
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
  Future getdata() async{
    final preflog= await SharedPreferences.getInstance();
    setState(() {
      data=preflog.getString('id')!;
    });
  }
  Future Submit() async {
    // getdata();
    print(data);
    var uri=Uri.parse("http://$ip/mainflutterdata/events/add_events.php?userid=$data");
    var request=http.MultipartRequest("POST",uri);
    request.fields['eventname']=enamecontroller.text;
    request.fields['description']=descriptioncontroller.text;
    request.fields['date']=datecontroller.text;
    request.fields['time']=timecontroller.text;
    request.send();
  }
}

