import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/EVENTS/add_events.dart';
import 'package:main_project/EVENTS/view_events.dart';
import 'package:main_project/FOOD/view_food.dart';
import 'package:main_project/MONEY/view_donations.dart';
import 'package:main_project/USER/user_view_product.dart';
import 'package:main_project/USER/userdata.dart';
import 'package:main_project/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FOOD/add_food.dart';
import '../MONEY/donate.dart';

class user_welcome extends StatefulWidget {
  const user_welcome({Key? key}) : super(key: key);
  @override
  State<user_welcome> createState() => _user_welcomeState();
}
class _user_welcomeState extends State<user_welcome> {
  var data='';
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("        WELCOME"),
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
            }, icon:Icon(Icons.logout,size: 40,) )
          ],
      ),
      drawer:Drawer(
        child: ListView(
          children: [
            Container(
                height: 50,
                color: Colors.red,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(userdata())));
                }, child: Text("PROFILE"))
            ),
            Container(
                height: 50,
                color: Colors.redAccent,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(add_event())));
                }, child: Text("ADD EVENTS"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade900,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(view_events())));
                }, child: Text("VIEW EVENTS"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade800,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(add_food())));
                }, child: Text("ADD FOOD"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade700,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(view_food())));
                }, child: Text("VIEW FOOD"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade600,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => donate()));
                }, child: Text("DONATE"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade500,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>(view_donations())));
                }, child: Text("DONATION HISTORY"))
            ),
            Container(
                height: 50,
                color: Colors.red.shade400,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => user_view_product()));
                }, child: Text("BUY PRODUCTS"))
            ),
          ],
        ),
      ),
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/admin_background.jpg"),
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
                    Text("    Welcome   ",style: TextStyle(fontSize: 30),),
                    Text(data,style: TextStyle(fontSize: 30)),
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
                        image: const DecorationImage(
                          image:NetworkImage("https://www.wtcmanila.com.ph/wp-content/uploads/2022/08/rear-view-of-audience-in-the-conference-hall-or-se-2021-08-30-06-51-57-utc-1.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.supervised_user_circle, size: 40,color:Colors.lightGreenAccent,), // Reduced icon size
                            title: Text("Add Events", style: TextStyle(fontSize: 20,color: Colors.lightGreenAccent)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => add_event()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  GridTile(
                    child: Stack(
                      children: [
                        Container(
                          height:160,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.yellowAccent),
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
                          child:ClipRect(
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.network(
                                "https://i.pinimg.com/originals/48/89/38/488938d6eec996de2365b072357aac16.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 39,),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: ListTile(
                            leading: Icon(Icons.add_business, size: 40, color: Colors.yellowAccent,), // Reduced icon size
                            title: Text("View Events", style: TextStyle(fontSize: 20, color: Colors.yellowAccent)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => view_events()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.cyanAccent),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: const DecorationImage(
                          image:NetworkImage("https://th.bing.com/th/id/OIP.9kGAzVBcETtnnD1LaeRhBQHaE8?rs=1&pid=ImgDetMain"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.food_bank, size: 30,color: Colors.cyanAccent,), // Reduced icon size
                            title: Text("Add Food", style: TextStyle(fontSize: 20,color: Colors.cyanAccent)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => add_food()));
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
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: const DecorationImage(
                          image:NetworkImage("https://th.bing.com/th/id/OIP.9kGAzVBcETtnnD1LaeRhBQHaE8?rs=1&pid=ImgDetMain"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.food_bank_outlined, size: 30,color: Colors.white,), // Reduced icon size
                            title: Text("View Food", style: TextStyle(fontSize: 20,color: Colors.white)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => view_food()));
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
                        image: const DecorationImage(
                          image:NetworkImage("https://th.bing.com/th/id/R.00fd365908428faa0891ca4e84fb3c3d?rik=HS3J%2feSqDzqY1g&riu=http%3a%2f%2fassets.nerdwallet.com%2fblog%2fwp-content%2fuploads%2f2012%2f09%2fbest-ways-to-donate-to-charity.jpg&ehk=tHoeMgD3eI8T1rCYRcloPkBiEn4NjsTENfAZX62XcfA%3d&risl=&pid=ImgRaw&r=0"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.money, size: 30,color: Colors.limeAccent), // Reduced icon size
                            title: Text("Donate", style: TextStyle(fontSize: 20,color: Colors.limeAccent)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => donate()));
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
                        image: const DecorationImage(
                          image:NetworkImage("https://hart.ca/wp-content/uploads/2015/10/Donation-Pie-Chart.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.attach_money, size: 30,color: Colors.lightBlueAccent), // Reduced icon size
                            title: Text("View Donation History", style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => view_donations()));
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
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: const DecorationImage(
                          image:NetworkImage("https://www.vintagemillwerks.com/wp-content/uploads/2020/11/tSRJI8bdqmIKmXFGS8xUohNL95netAJO1606168370.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 39,),
                          ListTile(
                            leading: Icon(Icons.shopping_cart, size: 30,color: Colors.white), // Reduced icon size
                            title: Text("Buy Product", style: TextStyle(fontSize: 20,color: Colors.white)), // Reduced text size
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => user_view_product()));
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
        ),
      ),
    );
  }
  Future getdata() async{
    final preflog= await SharedPreferences.getInstance();
    setState(() {
      data=preflog.getString('name')!;
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
