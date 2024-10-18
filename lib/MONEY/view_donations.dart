import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/MONEY/edit_donation_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class login_model6 {
  final String user_id;
  final String username;
  final String bank;
  final String amount;
  final String accountnumber;
  final String phone;
  final String place;
  final String id;
  login_model6({
    required this.user_id,
    required this.username,
    required this.bank,
    required this.amount,
    required this.accountnumber,
    required this.phone,
    required this.place,
    required this.id,
  });
}
class view_donations extends StatefulWidget {
  @override
  _view_donationsState createState() => _view_donationsState();
}
var data='';
class _view_donationsState extends State<view_donations> {
//Applying get request.
  Future<List<login_model6>> getRequest() async {
    //replace your restFull API here.
    getdata();
    String url = "http://$ip/mainflutterdata/money/view_donation.php?userid=$data";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    print("*********");
    print(responseData);
    List<login_model6> users = [];
    for (var singleUser in responseData) {
      login_model6 user = login_model6(
        id:singleUser ['id'].toString(),
        user_id:singleUser ['user_id'].toString(),
        username:singleUser ['name'].toString(),
        bank: singleUser["bank"].toString(),
        amount: singleUser["amount"].toString(),
        accountnumber: singleUser["account_no"].toString(),
        phone: singleUser["phone"].toString(),
        place: singleUser["place"].toString(),
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
        body: Scaffold(
          appBar: AppBar(
            title: Text("Donation History",style: TextStyle(color: Colors.orangeAccent),),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.amber.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(image: NetworkImage("https://thumbs.dreamstime.com/b/money-coins-rain-falling-down-to-glass-jar-215843581.jpg"))
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
                                        snapshot.data[index].username,style: TextStyle(color:Colors.black,fontSize: 30),
                                      ),
                                      Text(
                                        snapshot.data[index].bank,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].amount,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].accountnumber,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].phone,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                      Text(
                                        snapshot.data[index].place,style: TextStyle(color:Colors.black,fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  leading:  GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  edit_donation(login_user: snapshot.data[index],)));
                                      },
                                      child: Icon(Icons.edit,color: Colors.red.shade900,size: 40,)),
                                  trailing: GestureDetector(
                                      onTap: (){
                                        delrecord(snapshot.data[index].id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  view_donations()));
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
        "http://$ip/mainflutterdata/money/reject_donation.php?id=$id";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
}