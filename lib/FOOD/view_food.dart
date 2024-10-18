import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/FOOD/change_food.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
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
class view_food extends StatefulWidget {
  @override
  _view_foodState createState() => _view_foodState();
}
var data='';
class _view_foodState extends State<view_food> {
//Applying get request.
  Future<List<login_model5>> getRequest() async {
    //replace your restFull API here.
    getdata();
    String url = "http://$ip/mainflutterdata/food/view_food.php?userid=$data";
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
              image: const DecorationImage(image: NetworkImage("https://wallpapers.com/images/featured/bo1znbqxu6zxgfh3.jpg"))
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
                                        snapshot.data[index].foodname,style: TextStyle(color:Colors.black,fontSize: 30),
                                      ),
                                      Text(
                                        snapshot.data[index].foodtype,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].date,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  leading: GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  change_food(login_user: snapshot.data[index],)));
                                      },
                                      child: Icon(Icons.edit,color: Colors.red.shade900,size: 40,)),

                                  trailing: GestureDetector(
                                      onTap: (){
                                        delrecord(snapshot.data[index].id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  view_food()));
                                      },
                                      child: Icon(Icons.free_cancellation_sharp,color: Colors.red.shade900,size: 40,)),
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
Future<void> delrecord(String id) async {
  print(id);
  String url =
      "http://$ip/mainflutterdata/food/cancel_food.php?id=$id";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
  });
  var resoponse = jsonDecode(res.body);
  if (resoponse["success"] == "true") {
    print("success");
  }
}
}