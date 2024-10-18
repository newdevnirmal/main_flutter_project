import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/PRODUCT/edit_product.dart';

import '../main.dart';
//Creating a class user to store the data;

class login_model3 {
  final String id;
  final String cid;
  final String craftname;
  final String photo;
  final String description;
  final String price;
  final String quantity;
  login_model3({
    required this.id,
    required this.cid,
    required this.craftname,
    required this.photo,
    required this.description,
    required this.price,
    required this.quantity,
  });
}
class view_product extends StatefulWidget {
  @override
  _view_productState createState() => _view_productState();
}
class _view_productState extends State<view_product> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/view_product.php";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model3> users = [];
    for (var singleUser in responseData) {
      login_model3 user = login_model3(
        photo: singleUser["photo"].toString(),
        id:singleUser ['id'].toString(),
        cid:singleUser ['craft_id'].toString(),
        craftname:singleUser ['craf_tname'].toString(),
        description: singleUser["description"].toString(),
        price: singleUser["price"].toString(),
        quantity: singleUser["quantity"].toString(),
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
          title: Text("Products"),
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
              image: const DecorationImage(image: NetworkImage("https://th.bing.com/th/id/OIP.BG-mXQA5bDVji55QNNpzkgHaQD?w=1080&h=2340&rs=1&pid=ImgDetMain"))
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
                          color: Colors.white24,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Container(
                                        child: Image.network(snapshot.data[index].photo),
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
                                        snapshot.data[index].price,style: TextStyle(color:Colors.black),
                                      ),
                                      Text(
                                        snapshot.data[index].quantity,style: TextStyle(color:Colors.black),
                                      ),
                                    ],
                                  ),
                                  leading:  GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  edit_product(login_user: snapshot.data[index],)));
                                      },
                                      child: Icon(Icons.edit,color: Colors.red.shade900,size: 40,)),
                                  trailing: GestureDetector(
                                      onTap: (){
                                        delrecord(snapshot.data[index].id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  view_product()));
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
Future<void> delrecord(String id) async {
  print(id);
  String url =
      "http://$ip/mainflutterdata/delete_product.php?id=$id";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
  });
  var resoponse = jsonDecode(res.body);
  if (resoponse["success"] == "true") {
    print("success");
  }
}
}