import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
    call();
  }

  Future<void> call() async {
    Future.delayed(const Duration(seconds: 1), () {
      String tel = '+911234567890';
      void _makePhoneCall(String tel) async {
        if (await canLaunch('tel:$tel')) {
          await launch('tel:$tel');
        } else {
          throw 'Could not launch $tel';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  for (int i = 0; i < 6; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 150,
                        width: 350,
                        color: Colors.red,
                        child: Center(child: Text('hafb')),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
