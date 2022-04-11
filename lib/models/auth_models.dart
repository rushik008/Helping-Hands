import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final bool isRestaurant;
  final String name;
  final String numberOfPeople;
  final String pincode;
  final String uid;
  final String email;

  const User({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.isRestaurant,
    required this.name,
    required this.numberOfPeople,
    required this.pincode,
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'addressline1': addressLine1,
        'addressline2': addressLine2,
        'city': city,
        'pincode': pincode,
        'numberofpeople': numberOfPeople,
        'name': name,
        'uid': uid,
        'isRestaurant': isRestaurant,
        'email': email,
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
      addressLine1: snap['addressline1'],
      addressLine2: snap['addressline2'],
      city: snap['city'],
      isRestaurant: snap['isRestaurant'],
      name: snap['name'],
      numberOfPeople: snap['numberofpeople'],
      pincode: snap['pincode'],
      uid: snap['uid'],
      email: snap['email'],
    );
  }
}
