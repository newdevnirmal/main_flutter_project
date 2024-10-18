import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_edit.dart';
import 'package:main_project/USER/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
//Creating a class user to store the data;

class login_model {
  final String id;
  final String username;
  final String file;
  final String phone;
  final String email;
  final String password;
  login_model({
    required this.id,
    required this.username,
    required this.file,
    required this.phone,
    required this.email,
    required this.password,
  });
}
var data='';
class userdata extends StatefulWidget {
  @override
  _userdataState createState() => _userdataState();
}
class _userdataState extends State<userdata> {
//Applying get request.
  Future<List<login_model>> getRequest() async {
    getdata();
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/user/user_login_view.php?id=$data";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model> users = [];
    for (var singleUser in responseData) {
      login_model user = login_model(
        file: singleUser["File"].toString(),
        id:singleUser ['id'].toString(),
        username:singleUser ['user_name'].toString(),
        phone: singleUser["phone"].toString(),
        email: singleUser["email"].toString(),
        password: singleUser["password"].toString(),
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
          title: Text("Profile"),
        ),
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
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Colors.tealAccent,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  snapshot.data[index].file,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].username,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(snapshot.data[index].phone),
                                    Text(snapshot.data[index].email),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => user_edit(
                                            login_user: snapshot.data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.red.shade900,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      delrecord(snapshot.data[index].id);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => user_login(),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade900,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
        "http://$ip/mainflutterdata/user/user_delete.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
}
