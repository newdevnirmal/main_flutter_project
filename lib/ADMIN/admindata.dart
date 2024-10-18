import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'admin_edit.dart';
import 'admin_login.dart';
//Creating a class user to store the data;

class login_model2 {
  final String id;
  final String adminname;
  final String file;
  final String phone;
  final String email;
  final String password;
  login_model2({
    required this.id,
    required this.adminname,
    required this.file,
    required this.phone,
    required this.email,
    required this.password,
  });
}
var data='';
class admindata extends StatefulWidget {
  @override
  _admindataState createState() => _admindataState();
}
class _admindataState extends State<admindata> {
//Applying get request.
  Future<List<login_model2>> getRequest() async {
    getdata();
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/admin/admin_login_view.php?id=$data";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model2> users = [];
    for (var singleUser in responseData) {
      login_model2 user = login_model2(
        file: singleUser["File"].toString(),
        id:singleUser ['id'].toString(),
        adminname:singleUser ['admin_name'].toString(),
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
          title: Text("PROFILE"),
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
                                      Container(
                                        child: Image.network(snapshot.data[index].file),
                                      ),
                                      Text(
                                        snapshot.data[index].adminname,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].phone,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].email,style: TextStyle(color:Colors.black),
                                      ),
                                    ],
                                  ),
                                  leading:  GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  admin_edit(login_user: snapshot.data[index],)));
                                      },
                                      child: Icon(Icons.edit,color: Colors.red.shade900,size: 40,)),
                                  trailing: GestureDetector(
                                      onTap: (){
                                        delrecord(snapshot.data[index].id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  admin_login()));
                                      },
                                      child: Icon(Icons.delete,color: Colors.red.shade900,size: 40,)),
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
        "http://$ip/mainflutterdata/admin/admin_delete.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
}