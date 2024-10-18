import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class donate extends StatefulWidget {
  const donate({Key? key}) : super(key: key);
  @override
  State<donate> createState() => _donateState();
}
class _donateState extends State<donate> {
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController accountnocontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  var data='';
  var Date;
  late bool status;
  late String message;
  @override
  void initState() {
    unamecontroller= TextEditingController();
    bankcontroller=TextEditingController();
    amountcontroller=TextEditingController();
    accountnocontroller=TextEditingController();
    phonecontroller=TextEditingController();
    placecontroller=TextEditingController();
    status = false;
    message = "";
    super.initState();
    getdata();
  }
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => user_login()));
          }, icon:Icon(Icons.login))
        ],
        title: Text("DONATE"),
        backgroundColor: Colors.purple.shade600,
        centerTitle: true,
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://w0.peakpx.com/wallpaper/155/132/HD-wallpaper-gradient-background-gradient-background-lockscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:  SingleChildScrollView(
          child: Form(
            key:_formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 2,
                  width: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: unamecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter User Name",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: bankcontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Bank Name",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: amountcontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: accountnocontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Account Number",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: phonecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Phone Number",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: placecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                        ),
                        hintText: "Enter Place",
                        hintStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.only(
                        left: 60, right: 60, top: 20, bottom: 20),
                  ),
                  onPressed: () {
                    Submit();
                  },
                  child: Text("SUBMIT"),
                )
              ],
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
  Future Submit() async {
    print(data);
    var uri=Uri.parse("http://$ip/mainflutterdata/money/donate.php?user_id=$data");
    var request=http.MultipartRequest("POST",uri);
    request.fields['name']=unamecontroller.text;
    request.fields['bank']=bankcontroller.text;
    request.fields['amount']=amountcontroller.text;
    request.fields['account_no']=accountnocontroller.text;
    request.fields['phone']=phonecontroller.text;
    request.fields['place']=placecontroller.text;
    request.send();
  }
}

