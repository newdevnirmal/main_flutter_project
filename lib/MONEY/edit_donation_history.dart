import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/MONEY/view_donations.dart';

import '../main.dart';

class edit_donation extends StatefulWidget {
  final login_model6 login_user;
  edit_donation({required this.login_user});
  @override
  _edit_donationState createState() => _edit_donationState();
}
class _edit_donationState extends State<edit_donation> {
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController accountnocontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  late bool status;
  late String message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    unamecontroller= TextEditingController(text: widget.login_user.username);
    bankcontroller=TextEditingController(text: widget.login_user.bank);
    amountcontroller=TextEditingController(text: widget.login_user.amount);
    accountnocontroller=TextEditingController(text: widget.login_user.accountnumber);
    phonecontroller=TextEditingController(text: widget.login_user.phone);
    placecontroller=TextEditingController(text: widget.login_user.place);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "EDIT",
        ),
        backgroundColor: Colors.brown.shade300,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, color: Colors.lightBlueAccent,
            size: 35, // add custom icons also
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://wallpapercave.com/wp/wp11016562.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: unamecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter User Name",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: bankcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Bank Name",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: amountcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Amount",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: accountnocontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Account Number",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: phonecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: TextFormField(
                          controller: placecontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Your Place",
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.blue),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 20, bottom: 20),
                    ),
                    onPressed: () {
                      submit();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>view_donations()));
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
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
  Future<void> submit() async {
    var ID = widget.login_user.id;
    print(ID);
    var uri = Uri.parse("http://$ip/mainflutterdata/money/edit_donation_history.php?id=$ID");

    var response = await http.post(
      uri,
      body: {
        'name': unamecontroller.text,
        'bank': bankcontroller.text,
        'amount': amountcontroller.text,
        'account_no': accountnocontroller.text,
        'phone': phonecontroller.text,
        'place': placecontroller.text,
      },
    );
    //
    if (response.statusCode == 200) {
      print('Request successful');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
