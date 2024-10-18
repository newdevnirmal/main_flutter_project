import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_view_detailed_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../USER/userdata.dart';
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
class user_view_product extends StatefulWidget {
  @override
  _user_view_productState createState() => _user_view_productState();
}
class _user_view_productState extends State<user_view_product> {
//Applying get request.
  Future<List<login_model3>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip/mainflutterdata/user/user_view_products.php";
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
          title: Text("BUY PRODUCTS"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan, Colors.pinkAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        body: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(image:NetworkImage("https://wallpaperaccess.com/full/2518421.jpg"),fit: BoxFit.fill)
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
                          elevation: 10, // Adds elevation (shadow)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Rounded corners
                            side: BorderSide(
                              color: Colors.white12, // Border color
                              width: 20, // Border width
                            ),
                          ),
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
                                        snapshot.data[index].craftname,
                                        style: GoogleFonts.b612(
                                          textStyle: TextStyle(color: Colors.black87,fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                  leading: GestureDetector(
                                    onTap: () {
                                      addtocart(snapshot.data[index].id);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Item Added'),
                                            content: Text('This item has been added to your cart.'),
                                            actions: [
                                              TextButton(
                                                child: Text('Close'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.shopping_cart_checkout,
                                      color: Colors.white24,
                                      size: 40,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => user_view_detailed_product(
                                            login_user: snapshot.data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.info_outline, size: 50),
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
  Future<void> addtocart(String id) async {
    print(id);
    getdata();
    print(data);
    String url =
        "http://$ip/mainflutterdata/cart/add_to_cart.php";
    var res = await http.post(Uri.parse(url), body: {
      "craft_id":id,
      "user_id":data,
    });
    print(res);
    // var resoponse = jsonDecode(res.body);
    // if (resoponse["success"] == "true") {
    //   print("success");
    // }
  }
  Future getdata() async{
    final preflog= await SharedPreferences.getInstance();
    setState(() {
      data=preflog.getString('id')!;
    });
  }
}