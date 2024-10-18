import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
class admin_view_user extends StatefulWidget {
  @override
  _admin_view_userState createState() => _admin_view_userState();
}
class _admin_view_userState extends State<admin_view_user> {
//Applying get request.
  Future<List<login_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/admin/admin_view_user.php";
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
          title: Text("USERS"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(image: NetworkImage("https://i.pinimg.com/originals/fe/e5/ea/fee5eab30a698c169dc4fd5752359c2c.jpg"))
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
                                      Container(
                                        child: Image.network(snapshot.data[index].file),
                                      ),
                                      Text(
                                        snapshot.data[index].username,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].phone,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].email,style: TextStyle(color:Colors.black),
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