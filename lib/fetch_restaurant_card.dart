import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/models/auth_models.dart' as model;

class FetchRestaurantCard extends StatelessWidget {
  final snap;
  const FetchRestaurantCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'Flutter_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAdu-eucI:APA91bE2UrLx4fZEZ033GM02hAm1joamLYKTqk59QOMAxWavwY1O-xqSjCLSA8KxoHw9xI8MGuZ2_u5o1waHMicj4uMxHrs4PwzTSHfFYPubFX0a4JcY3tNaM5FNdLLbk-0ttgjQrUYH',
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': 'Order received'
                },
                'priority': 'high',
                'data': data,
                'to': token,
              }));

      if (response.statusCode == 200) {
        print('Notification is sent');
      } else {
        print('Error');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ).copyWith(right: 0),
                child: Row(
                  children: [
                    //fetch image from their profile pic
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?s=612x612'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap['name'] ?? 'Restaurant Name',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        snap['addressline1'] ?? 'addressline1',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snap['addressline2'] ?? 'addressline2',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snap['city'] ?? 'city',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snap['numberofpeople'] ?? '0',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                model.User user =
                                    await AuthMethods().getUserDetails();
                                // print(user.email);
                                // print(user.addressLine1);
                                // print(user.numberOfPeople);
                                String? token;
                                token = snap['token'] ?? 'token';
                                if (token != null) {
                                  sendNotification('request received', token);
                                  await AuthMethods().addOrder(
                                    ruid: snap['uid'],
                                    address1: user.addressLine1,
                                    address2: user.addressLine2,
                                    name: user.name,
                                    numberOfPeople: user.numberOfPeople,
                                    pincode: user.pincode,
                                    email: user.email,
                                    isConfirmed: false,
                                  );
                                }
                              },
                              child: const Text('Request for food'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
