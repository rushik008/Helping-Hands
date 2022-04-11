// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/models/auth_models.dart' as model;
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/provider/user_provider.dart';
import 'package:my_project/utils/snackbar.dart';
import 'package:provider/provider.dart';

import 'bnb_page.dart';
import 'package:flutter/material.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({Key? key}) : super(key: key);

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  // String title1 = '';
  // String title2 = '';
  // String title3 = '';
  // // final pincode = TextEditingController();
  // String pintitle = '';
  // String pincode = '';
  // String address = "";
  // String addressline2 = '';
  // String city = '';

  late final TextEditingController _addressLine1;
  late final TextEditingController _addressLine2;
  late final TextEditingController _city;
  late final TextEditingController _pincode;
  late final TextEditingController _numberOfPeople;

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    _addressLine1 = TextEditingController();
    _addressLine2 = TextEditingController();
    _city = TextEditingController();
    _pincode = TextEditingController();
    _numberOfPeople = TextEditingController();
    addData();
    super.initState();
  }

  @override
  void dispose() {
    _addressLine1.dispose();
    _addressLine2.dispose();
    _city.dispose();
    _pincode.dispose();
    _numberOfPeople.dispose();
    super.dispose();
  }

  void clearTextController() {
    _addressLine1.clear();
    _addressLine2.clear();
    _city.clear();
    _pincode.clear();
    _numberOfPeople.clear();
  }

  // void _setText() {
  //   setState(() {
  //     address = title1;
  //     addressline2 = title3;
  //     city = title2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Location"),
      ),
      body: Container(
        height: double.infinity,
        // margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: Colors.limeAccent.withOpacity(0.5),
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      // child: Text(
                      //   'Update Your Location',
                      //   style: TextStyle(fontSize: 15),
                      // ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _addressLine1,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Address Line 1',
                              prefix: Icon(Icons.home_filled),
                              filled: true,
                              // fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          // onChanged: (value) => title1 = value,
                        ),
                      ),
                      // SizedBox(
                      //   height: 05,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _addressLine2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Address Line 2',
                              prefix: Icon(Icons.add_road_rounded),
                              filled: true,
                              // fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                          // onChanged: (value) => title3 = value,
                        ),
                      ),
                      // SizedBox(
                      //   height: 05,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _city,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              labelText: 'Village/City',
                              prefix: Icon(Icons.add_location_rounded),
                              filled: true,
                              // fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                          // onChanged: (value) => title2 = value,
                        ),
                      ),
                      // SizedBox(
                      //   height: 05,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _pincode,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Pincode',
                            prefix: Icon(Icons.pin_rounded),
                            filled: true,
                            // fillColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          // onChanged: (value) => pincode = value,
                        ),
                      ),
                      SizedBox(
                        height: 08,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _numberOfPeople,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: 'Number of People',
                            prefix: Icon(Icons.pin_rounded),
                            filled: true,
                            // fillColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          // onChanged: (value) => pincode = value,
                        ),
                      ),
                      SizedBox(
                        height: 08,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white),
                            // primary: Color.fromRGBO(1, 84, 150, 1),
                            // side: BorderSide(width: 3, color: Colors.brown),
                            elevation: 05,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 10, bottom: 10)),
                        onPressed: () async {
                          String res = await AuthMethods().addExtraInfo(
                            addressLine1: _addressLine1.text,
                            addressLine2: _addressLine2.text,
                            city: _city.text,
                            pincode: _pincode.text,
                            numberOfPeople: _numberOfPeople.text,
                            isRestaurant: user.isRestaurant,
                            name: user.name,
                          );
                          if (res == 'success') {
                            clearTextController();
                            showSnackBar(context, res);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home_page', (route) => false);
                          } else {
                            showSnackBar(context, res);
                          }
                        },
                        child: Text('Submit'),
                      ),

                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Divider(
                      //   thickness: 5,
                      //   color: Colors.grey.withOpacity(0.6),
                      // ),
                      // Text('Address: ' +
                      //     address +
                      //     ' ' +
                      //     addressline2 +
                      //     ' ' +
                      //     city +
                      //     ' ' +
                      //     pincode),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text(' City: ' + city),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Text('Pincode: ' + pincode),
                      // Divider(
                      //   thickness: 5,
                      //   color: Colors.grey.withOpacity(0.6),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      //   ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         textStyle:
                      //             TextStyle(fontSize: 20, color: Colors.white),
                      //         // primary: Color.fromRGBO(1, 84, 150, 1),
                      //         // side: BorderSide(width: 3, color: Colors.brown),
                      //         elevation: 05,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(17),
                      //         ),
                      //         padding: EdgeInsets.only(
                      //             left: 30, right: 30, top: 10, bottom: 10)),
                      //     onPressed: () {},
                      //     child: Text('Show Nearby Restaurants'),
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
