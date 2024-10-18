import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_project/USER/user_view_orders.dart';
import 'package:main_project/USER/user_welcome.dart';
import 'package:main_project/USER/view_cart_pro.dart';
class bottomnav extends StatefulWidget {
  const bottomnav({Key? key}) : super(key: key);

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int currentindex=0;
  final screens=[
    user_welcome(),
    user_view_cart_pro(),
    user_view_orders()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize:15 ,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: currentindex,
        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "View Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_sharp),
              label: "Orders"),
        ],

      ),
    );
  }
}
