import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:thyrocare/Pages/Monthly_offer.dart';
import 'package:thyrocare/Pages/mainpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final List<String> Images = [
    'assets/ban1.png',
    'assets/ban2.jpg',
    'assets/ban3.png',
  ];
  final List<IconData> icons = [
    // Icons.home,
    Icons.book_sharp,
    Icons.wallet,
    CupertinoIcons.rays,
    Iconsax.whatsapp,
    Bootstrap.toggle_off,
    Icons.contact_phone_outlined
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              autoPlay: true,
            ),
            items: Images.map((String image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Images.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(Images[index]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 150,
                    width: 350,
                  ),
                );
              },
            ),
          ),

          // Container(
          //   height: 150,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: const BoxDecoration(color: Colors.red),
          //   child: const Carousel(
          //     hasBorderRadius: false,
          //     dotSize: 4.5,
          //     dotPosition: DotPosition.bottomCenter,
          //     dotColor: Colors.blue,
          //     animationDuration: Duration(microseconds: 300),
          //     dotBgColor: Colors.transparent,
          //     images: [
          //       ExactAssetImage(),
          //       ExactAssetImage('assets/ban2.jpg'),
          //       ExactAssetImage('assets/ban3.png'),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Light grey shadow
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                        0, 4), // Changes the position of the shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: TextButton(
              child: const Text(
                'Available Cashback : ₹ 100',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Home(
                //               name: '',
                //               // myCurrentIndex: 2,
                //             )));
              },
            )),
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
              childAspectRatio: 2.0, // Adjust this as needed
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridItemWidget(
                index: index + 0,
                iconData: icons[index],
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Light grey shadow
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(
                        0, 4), // Changes the position of the shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              'Monthly Offers',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 200,
                      width: 180,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/banner.png'),
                              fit: BoxFit.cover)),
                    ),
                  )
              ],
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     for (int i = 0; i < 3; i++)
          //       Container(
          //         height: 60,
          //         width: 80,
          //         color: Colors.red,
          //       )
          //   ],
          // )
        ],
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final int index;
  final IconData iconData;
  const GridItemWidget({required this.index, required this.iconData});

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
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launchUrlString" method is part of "url_launcher_string".
    await launchUrlString('$link');
  }

  @override
  Widget build(BuildContext context) {
    List<String> Title = [
      'My Reports',
      'Cashback',
      'Offers',
      'Whatsapp',
      'Monthly Offers',
      'Call Us',
      'contact',
    ];

    return Center(
      child: GestureDetector(
        onTap: () {
          // Example navigation logic based on the index
          switch (index) {
            case 0:
              // Navigate to My Reports
              // Example using GetX
              Get.to(const Home(
                name: '',
              ));
              // or Navigator.push for Flutter
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MyReportsPage()));
              break;
            case 1:
              // Navigate to Cashback
              // Example using GetX
              Get.to(const Home(
                name: '',
              ));
              // or Navigator.push for Flutter
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CashbackPage()));
              break;
            case 2:
              // Navigate to Cashback
              // Example using GetX
              Get.to(const Home(
                name: '',
              ));
              // or Navigator.push for Flutter
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CashbackPage()));
              break;
            case 3:
              // Navigate to Cashback
              // Example using GetX
              launchWhatsAppString();
              // or Navigator.push for Flutter
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CashbackPage()));
              break;

            // Add cases for other items as needed
            default:
              break;
          }
        },
        child: Container(
          height: 80,
          width: 180,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Light grey shadow
                spreadRadius: 2,
                blurRadius: 4,
                offset:
                    const Offset(0, 4), // Changes the position of the shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          // margin: EdgeInsets.all(5),
          // Container background color
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData, // Replace with your desired icon
                size: 30,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 10),
              Text(
                Title[index], // Replace with your desired title
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
