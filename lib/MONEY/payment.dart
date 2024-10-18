import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/USER/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
class payment extends StatefulWidget {
   payment({required this.money, required this.id});
 var money;
 var id;
  @override
  State<payment> createState() => _paymentState();
}
class _paymentState extends State<payment> {
  TextEditingController unamecontroller = TextEditingController();
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController accountnocontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  var data='';
  var Date;
  late bool status;
  late String message;
  // var totalprice=widget.qty*widget.money;
  @override
  void initState() {
    unamecontroller= TextEditingController();
    bankcontroller=TextEditingController();
    amountcontroller=TextEditingController(text:widget.money);
    accountnocontroller=TextEditingController();
    phonecontroller=TextEditingController();
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
        title: Text("PAY"),
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage("https://w0.peakpx.com/wallpaper/433/86/HD-wallpaper-android-apps-929-app-gray-grey-icon-logo-minimal-neutral-pattern.jpg"),
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
                    style: TextStyle(color: Colors.lightGreenAccent),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter User Name",
                        hintStyle: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.lightGreenAccent),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter Bank Name",
                        hintStyle: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.lightGreenAccent),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.lightGreenAccent),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter Account Number",
                        hintStyle: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.lightGreenAccent),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter Phone Number",
                        hintStyle: TextStyle(color: Colors.black),
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
    print(widget.id);
    var uri=Uri.parse("http://$ip/mainflutterdata/payment/payment.php?user_id=$data");
    var request=http.MultipartRequest("POST",uri);
    request.fields['order_id']=widget.id;
    request.fields['name']=unamecontroller.text;
    request.fields['bank']=bankcontroller.text;
    request.fields['amount']=amountcontroller.text;
    request.fields['account_no']=accountnocontroller.text;
    request.fields['phone']=phonecontroller.text;
    request.send();
  }
}



