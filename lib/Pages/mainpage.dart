import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thyrocare/Pages/AppBar.dart';
import 'package:thyrocare/Pages/Contact.dart';
import 'package:thyrocare/Pages/Login.dart';
import 'package:thyrocare/Pages/Mainpage.dart';
import 'package:thyrocare/Pages/Monthly_offer.dart';
import 'package:thyrocare/Pages/Report.dart';
import 'package:thyrocare/Pages/Test_Rate.dart';
import 'package:thyrocare/Pages/cashback.dart';
import 'package:http/http.dart' as http;
import 'package:thyrocare/Pages/offer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class MainPAge extends StatefulWidget {
  final String name;

  final ValueChanged<int> onNavigation;

  const MainPAge({
    required this.name,
    required this.onNavigation,
  });

  @override
  State<MainPAge> createState() => _MainPAgeState();

  static of(BuildContext context) {}
}

class _MainPAgeState extends State<MainPAge> {
  int _myCurrentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      homePage(navigationKey: navigationKey),
      Report(),
      Cashback(),
      Offers(),
      ContactUs(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text(
            'Thyro Report',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: SafeArea(
              child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0033cc),
            ),
          )),
        ),
      ),
      drawer: MyDrawer(
        changePage: (index) {
          setState(() {
            _myCurrentIndex = index;
          });
        },
        text: widget.name,
      ),
      body: pages[_myCurrentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        index: _myCurrentIndex,
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
            Icons.wallet,
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
            _myCurrentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final String text;
  final void Function(int) changePage;
  const MyDrawer({required this.text, required this.changePage});

  makePhoneCall(String phoneNumber) async {
    if (await launchUrlString('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
        (route) => false, // Clear the navigation stack
      );
    } catch (e) {
      print("Error during logout: $e");
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
                  text,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPAge(
                            name: text,
                            onNavigation: (int value) {},
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.book_sharp),
            title: Text('My Report'),
            onTap: () {
              changePage(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.money_outlined),
            title: Text('Cashback'),
            onTap: () {
              changePage(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.thermometer),
            title: Text('Test Rate'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestRate()));
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.rays),
            title: Text('Offers'),
            onTap: () {
              changePage(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_outlined),
            title: Text('Contact Us'),
            onTap: () {
              Get.to(makePhoneCall('9739100747'));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}

class homePage extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> navigationKey;
  const homePage({
    super.key,
    required this.navigationKey,
  });

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String? patientID;
  List<Map<String, dynamic>> testData = [];
  @override
  void initState() {
    super.initState();
    GetIamges();
    retrieveUserData();
    retrieveCashbackData();
    fetchAndSetTestData();
  }

  Future<List<Map<String, dynamic>>> fetchTestData() async {
    final response = await http.get(
        Uri.parse('http://ban58.thyroreport.com/api/LabTest/GetActiveTest'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAndSetTestData() async {
    try {
      List<Map<String, dynamic>> data = await fetchTestData();
      setState(() {
        testData = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> GetLocalTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      patientID = prefs.getString('patientID');
      print('patientid = $patientID');
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://ban58.thyroreport.com/api/Cashback/GetCashbackByPatientID?PatientID=$patientID'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(response.body);
      List<Map<String, dynamic>> availableResponses = data
          .where((item) => item['isExpired'].trim() == "Available")
          .toList()
          .cast<Map<String, dynamic>>();
      return availableResponses;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to load cashback data');
    }
  }

  Future<void> retrieveCashbackData() async {
    try {
      if (patientID != null) {
        List<Map<String, dynamic>> data = await fetchData();
        setState(() {
          availableResponses = data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      patientID = prefs.getString('patientID');
      print('patientID = $patientID');
      if (patientID != null) {
        retrieveCashbackData();
      }
    });
  }

  final String imgPath =
      'http://ban58files.thyroreport.com/UploadedFiles/OfferPackage/';
  Future<void> GetIamges() async {
    final url = 'http://ban58.thyroreport.com/api/Package/GetAllPackage';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      print(response.body);
      if (jsonData.isNotEmpty) {
        setState(() {
          Imagess = jsonData;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userData', json.encode(jsonData));
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  List<String> getImageUrls() {
    return Imagess.map<String>((dynamic image) {
      String imageName = image['packageFileName'];
      String imageUrl = imgPath + imageName;
      return imageUrl;
    }).toList();
  }

  List<Map<String, dynamic>> availableResponses = [];
  List<Map<String, dynamic>> cashbackData = [];
  List<dynamic> Imagess = [];
  final List<IconData> icons1 = [
    // Icons.home,
    Icons.book_sharp,
    Icons.wallet,
    CupertinoIcons.rays,
    Bootstrap.toggle_off,
  ];
  final List<IconData> icons2 = [
    Iconsax.whatsapp,
    Icons.contact_phone_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = getImageUrls();
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 350,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/wave.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Available Cashhback',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                availableResponses.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 15.0, bottom: 10.0),
                        child: Text(
                          '₹ ${availableResponses.first['cashbackAmt']}', // Adjust this line
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'You have no cashback yet...',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60),
                        ),
                      ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 8,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                    ),
                    items: imageUrls.map((dynamic imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.fill)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridItemWidget(
                index: index + 0,
                iconData: icons1[index],
                navigationKey: widget.navigationKey,
              );
            },
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridItemWidget2(
                index: index + 0,
                iconData: icons2[index],
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Monthly Offers',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 200,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Test Rate',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Container(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: testData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              testData[index]['testName'],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              testData[index]['cost'].toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final int index;
  final IconData iconData;
  final GlobalKey<CurvedNavigationBarState> navigationKey;
  const GridItemWidget({
    required this.index,
    required this.navigationKey,
    required this.iconData,
  });

  void _makePhoneCall(String phoneNumber) async {
    if (await launchUrlString('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  launchWhatsAppString() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+91 8248596881',
      text: "Hey! I'm inquiring about the apartment listing",
    );

    await launchUrlString('$link');
  }

  @override
  Widget build(BuildContext context) {
    List<String> Title = [
      'My Reports',
      'Cashback',
      'Offers',
      'Monthly Offers',
    ];

    return Center(
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              final navigationState = navigationKey.currentState!;
              navigationState.setPage(1);

            case 1:
              final navigationState = navigationKey.currentState!;
              navigationState.setPage(2);

              break;
            case 2:
              final navigationState = navigationKey.currentState!;
              navigationState.setPage(3);

              break;
            case 3:
              Get.to(const MonthlyOffer());

              break;

            default:
              break;
          }
        },
        child: Container(
          height: 60,
          width: 180,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                Title[index],
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItemWidget2 extends StatelessWidget {
  final int index;
  final IconData iconData;
  const GridItemWidget2({required this.index, required this.iconData});

  makePhoneCall(String phoneNumber) async {
    if (await launchUrlString('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  launchWhatsAppString() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+91 9739100747',
      text: "Hey! I'm inquiring about the apartment listing",
    );

    await launchUrlString('$link');
  }

  @override
  Widget build(BuildContext context) {
    List<String> Title = [
      'Whatsapp',
      'Call Us',
    ];
    List<Color> Colour = [
      Colors.green,
      Colors.red,
    ];

    return Center(
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Get.to(launchWhatsAppString());

              break;
            case 1:
              Get.to(makePhoneCall('9739100747'));

              break;

            default:
              break;
          }
        },
        child: Container(
          height: 60,
          width: 180,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 30,
                color: Colour[index],
              ),
              const SizedBox(width: 10),
              Text(
                Title[index],
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
