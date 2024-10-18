import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/EVENTS/view_events.dart';

import '../main.dart';
class detailed_events extends StatefulWidget {
  @override
  final login_model3 login_user1;
  detailed_events({required this.login_user1});
  _detailed_eventsState createState() => _detailed_eventsState();
}
class _detailed_eventsState extends State<detailed_events> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Scaffold(
          appBar: AppBar(
            title: Text("Event Details"),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image:NetworkImage("https://www.wallpapertip.com/wmimgs/167-1671007_best-android-app-background.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(top: 90,bottom: 300),
            child: Card(
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListTile(
                      title: Column(
                        children: [
                          Text(
                              widget.login_user1.user_id,style: TextStyle(fontSize: 40),
                          ),
                          Text(
                             widget.login_user1.eventname,style: TextStyle(fontSize: 40,color:Colors.red),
                          ),
                          Text(
                            widget.login_user1.description,style: TextStyle(fontSize: 20),
                          ),
                          Text(
                              widget.login_user1.date,style: TextStyle(fontSize: 40),
                          ),
                          Text(
                              widget.login_user1.time,style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                          onTap: (){
                            delrecord(widget.login_user1.id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  view_events()));
                          },
                          child: Icon(Icons.cancel,color: Colors.red.shade900,size: 40,)),
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
Future<void> delrecord(String id) async {
  print(id);
  String url =
      "http://$ip/mainflutterdata/events/cancel_event.php?id=$id";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
  });
  var resoponse = jsonDecode(res.body);
  if (resoponse["success"] == "true") {
    print("success");
  }
}
}