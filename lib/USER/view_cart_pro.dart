import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
var operation='';
// var quantity='';
class user_view_cart_pro extends StatefulWidget {
  @override
  _user_view_cart_proState createState() => _user_view_cart_proState();
}
class _user_view_cart_proState extends State<user_view_cart_pro> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    getdata();
    String url = "http://$ip/mainflutterdata/cart/view_cart.php?user_id=$data";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    // print("*********");
    // print(responseData);
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
title: Text("CART"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data.isNotEmpty) {
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 90.0),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                UpdateQuantity(snapshot.data[index].id,"increase",snapshot.data[index].quantity);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => user_view_cart_pro()),
                                                );
                                              },
                                              icon:Icon(Icons.add_box_outlined,color: Colors.purpleAccent.shade200,size: 50),
                                            ),
                                            SizedBox(height: 5,width: 30,),
                                            IconButton(
                                              onPressed: () {
                                                UpdateQuantity(snapshot.data[index].id,"decrease",snapshot.data[index].quantity);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => user_view_cart_pro()),
                                                );
                                              },
                                              icon:Icon(Icons.remove_circle_outline,color: Colors.purpleAccent.shade200,size: 50),
                                            ),
                                          ],
                                        ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0,right: 20),
                      child: Container(
                        child:   Column(
                          children: [
                            Text(
                              'Total Price: ${calculateTotalprice(snapshot.data)}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                              ),),
                            IconButton(
                              onPressed: () {
                                place_order();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => user_view_cart_pro()),
                                );
                              },
                              icon:Icon(Icons.shopping_cart,color: Colors.lightGreenAccent,size: 50),
                            ),
                          ],
                        ) ,
                      ),
                    )
                  ],
                );
              }
              else
              {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset("assets/images/emptycart.png",fit: BoxFit.cover,),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Cart Is Empty",
                          style: TextStyle(fontSize: 35),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void> place_order() async {
    // print(id);
    String url =
        "http://$ip/mainflutterdata/order/add_order.php?user_id=$data";
    var res = await http.post(Uri.parse(url), body: {
      // "id": id,
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
      totalprice += int.parse(item.price)*int.parse(item.quantity);
    }
    return totalprice;
  }
  Future<void> UpdateQuantity(String id,String operation,quantity) async {
    print(operation);
    String url =
        "http://$ip/mainflutterdata/cart/update_quantity.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "quantity":quantity,
      "operation": operation,
  });
  }
}