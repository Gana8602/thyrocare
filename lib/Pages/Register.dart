import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thyrocare/main_navigation/mainpage.dart';

import '../utils/colors.dart';

class RegisterPage extends StatefulWidget {
  final String phoneNumber;
  RegisterPage({super.key, required this.phoneNumber});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _firstName;
  String? _lastName;
  String? _email;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> createPatient() async {
    final String apiUrl =
        'http://ban58.thyroreport.com/api/Patient/CreatePatient';

    _firstName = _firstNameController.text;
    _lastName = _lastNameController.text;
    _email = _emailController.text;

    Map<String, dynamic> patientData = {
      "patientID": 0,
      "firstName": _firstName,
      "lastName": _lastName,
      "emailID": _email,
      "phoneNo": widget.phoneNumber,
      "isEnabled": "Y"
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the Content-Type
        },
        body: json.encode(patientData), // Convert the patient data to JSON
      );

      if (response.statusCode == 201) {
        // Handle the success response

        print(response.body);
        final jsonResponse = json.decode(response.body);
        final patientID = jsonResponse['patientID'];
        await savePatientIDLocally(patientID);

        saveSession();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPAge(
              name: _firstNameController.text,
              onNavigation: (value) => 0,
            ),
          ),
        );
        print("Patient created successfully");
      } else if (response.statusCode == 500) {
        print('json response : ${response.body}');
      } else {
        // Handle error response
        print("Failed to create patient. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      // Handle other exceptions
    }
  }

  Future<void> saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> savePatientIDLocally(int patientID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('patientID', patientID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AC.BC,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // padding: const EdgeInsets.only(left: 150.0, top: 50),
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
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 3, bottom: 20),
                  child: Text(
                    "Ready to unlock new opportunities? Let's get you registered!",
                    style: TextStyle(color: AC.TC, fontSize: 15),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10),
                  child: Text(
                    'Enter Your First Name',
                    style: TextStyle(color: AC.TC),
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
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'First Name',
                        fillColor: Colors.grey,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 155, 80, 75),
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10),
                  child: Text(
                    'Enter Your Last Name',
                    style: TextStyle(color: AC.TC),
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
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Last Name',
                        fillColor: Colors.grey,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 155, 80, 75),
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10),
                  child: Text(
                    'Enter Your Email',
                    style: TextStyle(color: AC.TC),
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'E-mail',
                        fillColor: Colors.grey,
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 155, 80, 75),
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
                      createPatient();
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
                          'Next',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
