import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
//Creating a class user to store the data;

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
class admin_view_events extends StatefulWidget {
  @override
  _admin_view_eventsState createState() => _admin_view_eventsState();
}
class _admin_view_eventsState extends State<admin_view_events> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/admin/admin_view_events.php";
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
        body: Scaffold(
          body: Container(
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
                          color: Colors.blueAccent,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text(
                                        snapshot.data[index].user_id,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].eventname,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].description,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].date,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].time,style: TextStyle(color:Colors.black),
                                      ),
                                    ],
                                  ),
                                  // leading:  GestureDetector(
                                  //     onTap: (){
                                  //       Navigator.pushReplacement(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) =>  user_edit(login_user: snapshot.data[index],)));
                                  //     },
                                  //     child: Icon(Icons.edit,color: Colors.red.shade900,size: 40,)),
                                  // trailing: GestureDetector(
                                  //     onTap: (){
                                  //       delrecord(snapshot.data[index].id);
                                  //       Navigator.pushReplacement(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) =>  user_login()));
                                  //     },
                                  //     child: Icon(Icons.delete,color: Colors.red.shade900,size: 40,)),
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
// Future<void> delrecord(String id) async {
//   print(id);
//   String url =
//       "http://192.168.29.92/mainflutterdata/user/user_delete.php?id=$id";
//   var res = await http.post(Uri.parse(url), body: {
//     "id": id,
//   });
//   var resoponse = jsonDecode(res.body);
//   if (resoponse["success"] == "true") {
//     print("success");
//   }
// }
}