import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:thyrocare/Pages/Contact.dart';
import 'package:thyrocare/Pages/Login.dart';
import 'package:thyrocare/Pages/Report.dart';
import 'package:thyrocare/Pages/cashback.dart';
import 'package:thyrocare/Pages/homepage.dart';
import 'package:thyrocare/Pages/offer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final String name;
  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myCurrentIndex = 0;
  List pages = const [homePage(), Report(), Cashback(), Offers(), ContactUs()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ThyroCare',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyDrawer(text: widget.name),
      body: pages[myCurrentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Color(0xFF121e19),
          ),
          Icon(
            Icons.book_sharp,
            size: 30,
            color: Color(0xFF121e19),
          ),
          Icon(
            Icons.money_outlined,
            size: 30,
            color: Color(0xFF121e19),
          ),
          Icon(
            CupertinoIcons.rays,
            size: 30,
            color: Color(0xFF121e19),
          ),
          Icon(
            Icons.contact_phone_outlined,
            size: 30,
            color: Color(0xFF121e19),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final String text;
  const MyDrawer({super.key, required this.text});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the Login page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
        (route) => false, // Clear the navigation stack
      );
    } catch (e) {
      // Handle error during logout
      print("Error during logout: $e");
      // You can show an error message or take any other action here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage('assets/profile.png'),
                          fit: BoxFit.cover)),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.book_sharp),
            title: Text('My Report'),
            onTap: () {
              // Add your action here when the "Settings" option is selected.
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more list items for other menu options
          ListTile(
            leading: Icon(Icons.money_outlined),
            title: Text('Cashback'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.thermometer),
            title: Text('Test Rate'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.rays),
            title: Text('Offers'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_outlined),
            title: Text('Contact Us'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              // Add your action here when the "Home" option is selected.
              // For example, you can navigate to the home page.
              _logout(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
