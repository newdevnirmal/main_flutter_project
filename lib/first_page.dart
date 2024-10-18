import 'package:flutter/material.dart';
import 'package:main_project/ADMIN/admin_splashscreen.dart';
import 'package:main_project/USER/user_splashscreen.dart';
import 'package:main_project/registration_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the page
      body: Center(
        child: Container(
          width: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_of_ui.jpg"),
              // image:NetworkImage("https://1.bp.blogspot.com/-c8R21J1ICrE/Xo3IU-19nmI/AAAAAAAAARY/YPyDsVoNz5gJuTbZ2N1nCU3rNUtkyxMagCLcBGAsYHQ/s1600/background_of_ui.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                SizedBox(height: 40), // Spacing between the text and buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            //Admin_Dashboard(data_passing_admin: null,)
                            admin_splashscreen()));
                    // Handle Admin button press
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    primary: Colors.blueGrey.shade600, // Background color of the button
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Admin'),
                ),
                SizedBox(height: 20), // Spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            //Admin_Dashboard(data_passing_admin: null,)
                            user_splashscreen()));
                    // Handle User button press
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    primary: Colors.deepOrangeAccent, // Background color of the button
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('User'),
                ),
                SizedBox(height: 20), // Spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>(registration_page())));
                    // Handle User button press
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    primary: Colors.cyan.shade100, // Background color of the button
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
