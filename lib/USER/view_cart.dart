import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
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
var data='';
class user_view_cart extends StatefulWidget {
  @override
  _user_view_cartState createState() => _user_view_cartState();
}
class _user_view_cartState extends State<user_view_cart> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    getdata();
    String url = "http://$ip/mainflutterdata/cart/view_cart.php?user_id=$data";
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
        craftname:singleUser ['craft_name'].toString(),
        description: singleUser["description"].toString(),
        price: singleUser["price"].toString(),
        quantity: singleUser["quantity"].toString(),
      );
      users.add(user);
    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

        ),
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
                  return Column(
                    children: [

                      Flexible(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              Card(
                                elevation: 18,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.red, Colors.blue],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                                      crossAxisAlignment: CrossAxisAlignment.center, // Center text horizontally
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
                                        SizedBox(height: 10),
                                        Text(
                                          snapshot.data[index].craftname,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto',
                                          ),
                                          textAlign: TextAlign.center, // Center the text
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          snapshot.data[index].price,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Roboto',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          snapshot.data[index].quantity,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Roboto',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            delrecord(snapshot.data[index].id);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => user_view_cart()),
                                            );
                                          },
                                          icon:Icon(Icons.remove_shopping_cart_outlined,color: Colors.purpleAccent.shade200,size: 50),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        child:   Text(
                          'Total Price: ${calculateTotalprice(snapshot.data)}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                          ),) ,
                      )
                    ],
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
        "http://$ip/mainflutterdata/cart/remove_cart_items.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
  Future getdata() async{
    final preflog= await SharedPreferences.getInstance();
    setState(() {
      data=preflog.getString('id')!;
    });
  }
  int calculateTotalprice(List data) {
    int totalprice = 0;
    for (var item in data) {
      totalprice += int.parse(item.price);
    }
    return totalprice;
  }
}