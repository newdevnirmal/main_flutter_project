import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
//Creating a class user to store the data;

class login_model5 {
  final String user_id;
  final String foodname;
  final String foodtype;
  final String date;
  final String id;
  login_model5({
    required this.user_id,
    required this.foodname,
    required this.foodtype,
    required this.date,
    required this.id,
  });
}
class admin_view_food extends StatefulWidget {
  @override
  _admin_view_foodState createState() => _admin_view_foodState();
}
class _admin_view_foodState extends State<admin_view_food> {
//Applying get request.
  Future<List<login_model5>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/admin/admin_view_food.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model5> users = [];
    for (var singleUser in responseData) {
      login_model5 user = login_model5(
        id:singleUser ['id'].toString(),
        user_id:singleUser ['user_id'].toString(),
        foodname:singleUser ['food_name'].toString(),
        foodtype: singleUser["food_type"].toString(),
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
          title: Text("VIEW FOOD"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.brown],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(image: NetworkImage("https://thumbs.dreamstime.com/b/processed-canned-food-long-shelf-life-vegetables-fish-vertically-277791435.jpg"))
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
                          color: Colors.white38,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text(
                                        snapshot.data[index].user_id,style: TextStyle(color:Colors.yellowAccent,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].foodname,style: TextStyle(color:Colors.tealAccent,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].foodtype,style: TextStyle(color:Colors.red,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].date,style: TextStyle(color:Colors.blueAccent,fontSize: 25),
                                      ),
                                    ],
                                  ),
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
}