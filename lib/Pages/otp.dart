import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thyrocare/Pages/Register.dart';
import 'package:thyrocare/Pages/homepage.dart';
import 'package:thyrocare/Pages/mainpage.dart';
import 'dart:convert';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  // final String name;
  final String phoneNumber;
  final String verificationId;
  final int codeLenth;
  const OtpPage(
      {super.key,
      // required this.name,
      required this.phoneNumber,
      required this.codeLenth,
      required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();
  bool _isOtpWrong = false;
  // final _smsCodeController = TextEditingController();

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // Duration the toast will be visible
      gravity: ToastGravity.BOTTOM, // Position of the toast message
      timeInSecForIosWeb: 1, // Duration for iOS only
      backgroundColor: Colors.red, // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }

  Future<void> verifyOTP(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: _otpController.text.trim(),
    );

    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final url =
            'http://ban58.thyroreport.com/api/Patient/GetPatientByPhoneNo?phoneNo=${widget.phoneNumber}';
        final response = await http.get(
          Uri.parse(url),
        );
        // Navigate to the next screen after successful verification
        if (response.statusCode == 200) {
          // Assuming the response is a JSON array as mentioned earlier
          List<dynamic> jsonResponse = json.decode(response.body);
          print("Received JSON Response: $jsonResponse");
          if (jsonResponse.isNotEmpty) {
            // User has an account, navigate to the Home screen
            final user = jsonResponse.first;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('patientID', user['patientID'].toString());
            prefs.setString('userName', user['firstName']);
            prefs.setString('userEmail', user['emailID']);
            prefs.setString('userPhone', user['phoneNo']);
            // Navigate based on user existence
            navigateBasedOnUser(prefs);
          } else {
            navigateBasedOnUser(null);
          }
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isOtpWrong = true;
      });
      // Handle verification failure or invalid OTP
      print("Failed to verify OTP: ${e.message}");
      _showToast('Failed to verify OTP: ${e.message}');
    }
  }

  void navigateBasedOnUser(SharedPreferences? prefs) {
    if (prefs != null && prefs.containsKey('userName')) {
      saveSession();
       final homeState = MainPAge.of(context);
        homeState?.onNavigation(0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    }
  }

  Future<void> saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AC.BC,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // padding: const EdgeInsets.only(
                  //   left: 150.0,
                  // ),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/logo.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5.0, top: 20),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: AC.TC,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 3, bottom: 20),
                  child: Text(
                    "We have Sent a OTP to Your Phone Number, You Entered +91 ${widget.phoneNumber},  to edit go back",
                    style: const TextStyle(color: AC.TC, fontSize: 15),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10),
                  child: Text(
                    'Enter Your Otp',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.5), // Light grey shadow
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(
                              0, 4), // Changes the position of the shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: AC.BC,
                    ),
                    child: TextFormField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Otp',
                        fillColor: Colors.grey,
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: _isOtpWrong
                                ? const Color.fromARGB(255, 236, 32, 17)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      verifyOTP(context);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
