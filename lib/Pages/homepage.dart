import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.red),
            child: const Carousel(
              hasBorderRadius: false,
              dotSize: 4.5,
              dotPosition: DotPosition.bottomCenter,
              dotColor: Colors.blue,
              animationDuration: Duration(microseconds: 300),
              dotBgColor: Colors.transparent,
              images: [
                ExactAssetImage('assets/ban1.png'),
                ExactAssetImage('assets/ban2.jpg'),
                ExactAssetImage('assets/ban3.png'),
              ],
            ),
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
              'Available Cashback : ₹ 100',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0, // Adjust this as needed
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridItemWidget(index: index + 0);
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
  const GridItemWidget({required this.index});

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
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Light grey shadow
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4), // Changes the position of the shadow
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
            const Icon(
              Icons.ac_unit, // Replace with your desired icon
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
    );
  }
}
