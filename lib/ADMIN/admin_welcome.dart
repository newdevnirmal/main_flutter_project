import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/ADMIN/admin_view_events.dart';
import 'package:main_project/ADMIN/admin_view_food.dart';
import 'package:main_project/ADMIN/admin_view_orders.dart';
import 'package:main_project/ADMIN/admin_view_payments.dart';
import 'package:main_project/ADMIN/admin_view_user.dart';
import 'package:main_project/PRODUCT/register_product.dart';
import 'package:main_project/PRODUCT/view_product.dart';
import 'package:main_project/first_page.dart';
import 'package:main_project/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admindata.dart';

class admin_welcome extends StatefulWidget {
  const admin_welcome({Key? key}) : super(key: key);
  @override
  State<admin_welcome> createState() => _admin_welcomeState();
}
class _admin_welcomeState extends State<admin_welcome> {
  var data='';
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("     WELCOME ADMIN"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
                actions: [
          IconButton(onPressed: (){
logout();
          }, icon: Icon(Icons.logout_rounded,size: 40,))
        ],
      ),
      drawer:Drawer(
        child: ListView(
          children: [
            Container(
                height: 50,
                color: Colors.red,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(admindata())));
                }, child: Text("Profile"))
            ),
            Container(
                height: 50,
                color: Colors.deepOrange,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(admin_view_payments())));
                }, child: Text("Payments"))
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/admin_background.jpg"),
            // image:NetworkImage("https://1.bp.blogspot.com/-c8R21J1ICrE/Xo3IU-19nmI/AAAAAAAAARY/YPyDsVoNz5gJuTbZ2N1nCU3rNUtkyxMagCLcBGAsYHQ/s1600/background_of_ui.jpg"),
            fit: BoxFit.fill,
          ),
        ),
         child: Column(
           children: [
             Container(
               child: Padding(
                 padding: const EdgeInsets.all(50.0),
                 child: Row(
                   children: [
                     Text("    Welcome   ", style: TextStyle(fontSize: 30)),
                     Text(data, style: TextStyle(fontSize: 30)),
                   ],
                 ),
               ),
             ),
             Container(
               height: 500,
               width: 450,
               child: GridView.count(
                 crossAxisCount: 2, // Number of columns in the grid
                 crossAxisSpacing: 10, // Space between columns
                 mainAxisSpacing: 10, // Space between rows
                 padding: EdgeInsets.all(10),
                 childAspectRatio: 1.2, // Adjust the aspect ratio to make tiles smaller
                 children: [
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.lightGreenAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height: 39,),
                           ListTile(
                             leading: Icon(Icons.supervised_user_circle, size: 40,color: Colors.lightGreenAccent), // Reduced icon size
                             title: Text("Users", style: TextStyle(fontSize: 35,color: Colors.lightGreenAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => admin_view_user()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.lightBlueAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height:39),
                           ListTile(
                             leading: Icon(Icons.add_business, size: 40,color: Colors.lightBlueAccent), // Reduced icon size
                             title: Text("Add Products", style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => productregister()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.tealAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height: 39,),
                           ListTile(
                             leading: Icon(Icons.preview, size: 30,color: Colors.tealAccent), // Reduced icon size
                             title: Text("View Products", style: TextStyle(fontSize: 20,color: Colors.tealAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => view_product()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.greenAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height: 39,),
                           ListTile(
                             leading: Icon(Icons.view_array_outlined, size: 30,color: Colors.greenAccent), // Reduced icon size
                             title: Text("View Events", style: TextStyle(fontSize: 20,color: Colors.greenAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => admin_view_events()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.limeAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height: 39,),
                           ListTile(
                             leading: Icon(Icons.food_bank, size: 30,color: Colors.limeAccent), // Reduced icon size
                             title: Text("View Food", style: TextStyle(fontSize: 20,color: Colors.limeAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => admin_view_food()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                   GridTile(
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.transparent,
                         border: Border.all(color: Colors.deepOrangeAccent),
                         borderRadius: BorderRadius.circular(10),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Column(
                         children: [
                           SizedBox(height: 39,),
                           ListTile(
                             leading: Icon(Icons.add_business, size: 30,color: Colors.deepOrangeAccent), // Reduced icon size
                             title: Text("View Orders", style: TextStyle(fontSize: 20,color: Colors.deepOrangeAccent)), // Reduced text size
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => admin_view_orders()));
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             )
           ],
         )
      ),
    );
  }
  Future getdata() async{
    final preflog= await SharedPreferences.getInstance();
    setState(() {
      data=preflog.getString('aname')!;
    });
    print("******************");
    print(data);
  }
  Future<void> logout() async {
    final preflog = await SharedPreferences.getInstance();
    await preflog.remove('id');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstPage()),
    );
  }
}
