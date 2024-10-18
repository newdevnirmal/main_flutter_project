import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
//Creating a class user to store the data;

class login_model3 {
  final String id;
  final String order_id;
  final String cid;
  final String craftname;
  final String photo;
  final String description;
  final String price;
  final String quantity;
  login_model3({
    required this.id,
    required this.order_id,
    required this.cid,
    required this.craftname,
    required this.photo,
    required this.description,
    required this.price,
    required this.quantity,
  });
}
class admin_view_orders extends StatefulWidget {
  @override
  _admin_view_ordersState createState() => _admin_view_ordersState();
}
class _admin_view_ordersState extends State<admin_view_orders> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/admin/admin_view_order.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model3> users = [];
    for (var singleUser in responseData) {
      login_model3 user = login_model3(
        id:singleUser ['oid'].toString(),
        order_id: singleUser ['order_id'].toString(),
        cid:singleUser ['craft_id'].toString(),
        photo:singleUser ['photo'].toString(),
        description: singleUser["description"].toString(),
        craftname: singleUser["craft_name"].toString(),
        quantity: singleUser["qty"].toString(),
        price: singleUser["price"].toString(),
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
          title: Text("VIEW ORDERS"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data.isNotEmpty) {
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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          snapshot.data[index].photo,
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].cid,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].craftname,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].description,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].quantity,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].price,style: TextStyle(color:Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 135.0),
                                child: Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      delrecord(snapshot.data[index].id);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  admin_view_orders()));
                                    }, icon: Icon(Icons.delete,color: Colors.red,size: 35,)),

                                    IconButton(onPressed: (){
                                      accept(snapshot.data[index].id);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  admin_view_orders()));
                                    }, icon: Icon(Icons.done,color: Colors.lightGreenAccent,size: 35,)),
                                  ],
                                ),
                              )
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
                else
                {
                  return Container(
                    child: Stack(
                      children: [
                        Container(
                          height: 1000,
                          // child: Image.network("https://media3.giphy.com/media/1a88wypaZjARiv0ggy/giphy.gif?cid=790b76110c1de5bed7c8eab0f458f803851f33cdd7bd9097&rid=giphy.gif&ct=s"),
                          child: Image.asset("assets/images/mr bean.jpeg",fit: BoxFit.fill,),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            "No Oders Yet For Today",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
      ),
    );
  }
  Future<void> delrecord(String id) async {
    print(id);
    String url =
        "http://$ip/mainflutterdata/admin/admin_reject_order.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
  Future<void> accept(String id) async {
    print(id);
    String url =
        "http://$ip/mainflutterdata/admin/admin_accept_order.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
}