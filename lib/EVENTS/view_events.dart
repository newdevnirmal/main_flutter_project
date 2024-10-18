import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/EVENTS/change_events.dart';
import 'package:main_project/EVENTS/detailed_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class login_model3 {
  final String user_id;
  final String eventname;
  final String description;
  final String date;
  final String time;
  final String id;
  login_model3({
    required this.user_id,
    required this.eventname,
    required this.description,
    required this.date,
    required this.time,
    required this.id,
  });
}
class view_events extends StatefulWidget {
  @override
  _view_eventsState createState() => _view_eventsState();
}
var data='';
class _view_eventsState extends State<view_events> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    getdata();
    String url = "http://$ip/mainflutterdata/events/view_events.php?userid=$data";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model3> users = [];
    for (var singleUser in responseData) {
      login_model3 user = login_model3(
        id:singleUser ['id'].toString(),
        user_id:singleUser ['user_id'].toString(),
        eventname:singleUser ['event_name'].toString(),
        description: singleUser["description"].toString(),
        time: singleUser["time"].toString(),
        date: singleUser["date"].toString(),
      );
      // print( singleUser["file"]);
      //Adding user to the list.
      users.add(user);
    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.teal,Colors.deepOrangeAccent.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image:NetworkImage("https://img.freepik.com/premium-vector/wave-liquid-background-abstract-vibrant-poster-web-element_41901-2696.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red.shade900,
                            strokeWidth: 5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Data Loading Please Wait!",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else
                {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        Card(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text(
                                        snapshot.data[index].eventname,style: TextStyle(color:Colors.black,fontSize: 30),
                                      ),
                                      Text(
                                        snapshot.data[index].date,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  leading:  GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  change_events(login_user: snapshot.data[index],)));
                                      },
                                      child: Icon(Icons.edit,color: Colors.black26,size: 40,)),
                                  trailing:   IconButton(onPressed: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  detailed_events(login_user1: snapshot.data[index],)));
                                  }, icon:Icon(Icons.info_outline,size: 50,)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
              },
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
}