import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../USER/user_view_product.dart';
import '../USER/userdata.dart';
import '../main.dart';

class user_view_detailed_product extends StatefulWidget {
  @override
  final login_model3 login_user;
  user_view_detailed_product({required this.login_user});

  _user_view_detailed_productState createState() => _user_view_detailed_productState();
}
class _user_view_detailed_productState extends State<user_view_detailed_product> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("PRODUCT DETAILS"),
          backgroundColor: Colors.purple.shade600,
          centerTitle: true,
        ),
        body: Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: 30,bottom: 100),
            child: Card(
              color: Colors.blueAccent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListTile(
                      title: Column(
                        children: [
                          Container(
                            child: Image.network(widget.login_user.photo),
                          ),
                          Text(
                            widget.login_user.cid,style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            widget.login_user.craftname,style: TextStyle(fontSize: 40,color:Colors.red),
                          ),
                          Text(
                            widget.login_user.description,style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.login_user.price,style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            widget.login_user.quantity,style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          addtocart(widget.login_user.id);
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
                          color: Colors.red.shade900,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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