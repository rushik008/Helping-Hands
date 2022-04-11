import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String ruid;
  final String addressLine1;
  final String addressLine2;
  final String name;
  final String numberOfPeople;
  final String pincode;
  final bool isConfirmed;
  final String email;
  final String resName;
  final String uid;

  const Order({
    required this.ruid,
    required this.addressLine1,
    required this.addressLine2,
    required this.name,
    required this.numberOfPeople,
    required this.pincode,
    required this.isConfirmed,
    required this.email,
    required this.resName,
    required this.uid,
  });

  static Order fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Order(
      addressLine1: snap['addressline1'],
      addressLine2: snap['addressline2'],
      name: snap['name'],
      numberOfPeople: snap['numberofpeople'],
      pincode: snap['pincode'],
      ruid: snap['ruid'],
      isConfirmed: snap['isconfirmed'],
      email: snap['email'],
      resName: snap['resname'],
      uid: snap['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'addressline1': addressLine1,
        'addressline2': addressLine2,
        'pincode': pincode,
        'numberofpeople': numberOfPeople,
        'name': name,
        'ruid': ruid,
        'isconfirmed': isConfirmed,
        'email': email,
        'resname': resName,
        'uid': uid,
      };
}
