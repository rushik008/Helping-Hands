import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_project/models/auth_models.dart' as model;
import 'package:my_project/models/order_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User user = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(user.uid).get();

    return model.User.fromSnap(snap);
  }

  //edit profile

  Future<String> updateUserDetails({
    required String email,
    required String name,
    required String password,
  }) async {
    String res = 'error';
    try {
      var doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      var city = doc['city'];
      var isRestaurant = doc['isRestaurant'];
      print(city);
      print(isRestaurant);

      if (isRestaurant == true) {
        await _firestore
            .collection(city.toString().toLowerCase())
            .doc(_auth.currentUser!.uid)
            .set({
          'name': name,
        }, SetOptions(merge: true));
      }
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.updateEmail(email);
      await _auth.currentUser!.updatePassword(password);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set(
        {
          'name': name,
        },
        SetOptions(merge: true),
      );

      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (_) {
      res = 'Error occured';
    }
    return res;
  }

  Future<void> confirmOrder(
      {required String ruid,
      required bool isConfirmed,
      required String uuid,
      required int numberOfPeople}) async {
    print(uuid);
    await _firestore
        .collection('users')
        .doc(uuid)
        .collection('order')
        .doc(ruid)
        .set({
      'isconfirmed': isConfirmed,
    }, SetOptions(merge: true));

    await _firestore
        .collection('users')
        .doc(ruid)
        .collection('order')
        .doc(uuid)
        .set({
      'isconfirmed': isConfirmed,
    }, SetOptions(merge: true));

    var coll = _firestore.collection('users');
    var snap = await coll.get();
    var rNumberOfPeople;
    var city;

    var data = await _firestore.collection('users').doc(ruid).get();
    rNumberOfPeople = int.parse(data['numberofpeople']);
    city = data['city'];

    rNumberOfPeople = rNumberOfPeople - numberOfPeople;

    String r = rNumberOfPeople.toString();

    await _firestore.collection('users').doc(ruid).set({
      'numberofpeople': r,
    }, SetOptions(merge: true));

    await _firestore.collection(city.toString().toLowerCase()).doc(ruid).set({
      'numberofpeople': r,
    }, SetOptions(merge: true));
  }

  Future<void> deleteOrderIfNotConfirmed() async {
    var uuid;
    var collection = _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('order');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      uuid = data['uid'];
    }
    print(uuid);
    await _firestore
        .collection('users')
        .doc(uuid)
        .collection('order')
        .doc(_auth.currentUser!.uid)
        .delete();

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('order')
        .doc(uuid)
        .delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNotification() async {
    var data = await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('order')
        .get();

    return data;
  }

  Future<Order> getOrderDetails() async {
    var isRestaurant;
    var ruid;
    var uuid;
    var collection = _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('order');
    Map<String, dynamic> data;
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      data = queryDocumentSnapshot.data();
      uuid = data['uid'];
    }

    var doc = _firestore.collection('users').doc(_auth.currentUser!.uid);
    var snapshot = await doc.get();
    isRestaurant = snapshot['isRestaurant'];
    print(ruid);
    print(uuid);

    if (isRestaurant == true) {
      DocumentSnapshot snap = await _firestore
          .collection('users')
          .doc(ruid)
          .collection('order')
          .doc(uuid)
          .get();
      print('sent order info');
      return Order.fromSnap(snap);
    }

    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(uuid)
        .collection('order')
        .doc(ruid)
        .get();

    print('sent order info');

    return Order.fromSnap(snap);
  }

  //store to firebase on notification
  Future<void> addOrder({
    required String ruid,
    required String address1,
    required String address2,
    required String name,
    required String numberOfPeople,
    required String pincode,
    required String email,
    required bool isConfirmed,
  }) async {
    var docSnap = await _firestore.collection('users').doc(ruid).get();

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('order')
        .doc(ruid)
        .set({
      'ruid': ruid,
      'addressline1': address1,
      'addressline2': address2,
      'pincode': pincode,
      'numberofpeople': numberOfPeople,
      'name': name,
      'email': email,
      'isconfirmed': isConfirmed,
      'uid': _auth.currentUser!.uid,
      'resname': docSnap['name'],
    });

    await _firestore
        .collection('users')
        .doc(ruid)
        .collection('order')
        .doc(_auth.currentUser!.uid)
        .set({
      'ruid': ruid,
      'addressline1': address1,
      'addressline2': address2,
      'pincode': pincode,
      'numberofpeople': numberOfPeople,
      'name': name,
      'email': email,
      'isconfirmed': isConfirmed,
      'uid': _auth.currentUser!.uid,
      'resname': docSnap['name'],
    });
  }

  //add token

  Future<void> addToken(
      {required String city, required bool isRestaurant}) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();

    if (token != null && isRestaurant == true) {
      await _firestore
          .collection(city.toLowerCase())
          .doc(_auth.currentUser!.uid)
          .set({
        'token': token,
      }, SetOptions(merge: true));
    }

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'token': token,
    }, SetOptions(merge: true));
  }

  //address information
  Future<String> addExtraInfo({
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String pincode,
    required String numberOfPeople,
    required bool isRestaurant,
    required String name,
  }) async {
    String res = 'Enter Proper Value';
    final user = _auth.currentUser;
    try {
      if (user != null) {
        if (addressLine1.isNotEmpty &&
            addressLine2.isNotEmpty &&
            city.isNotEmpty &&
            pincode.isNotEmpty &&
            numberOfPeople.isNotEmpty) {
          final int peoplecount = int.parse(numberOfPeople);
          if (pincode.length == 6 && peoplecount > 0) {
            if (isRestaurant == false) {
              await _firestore.collection('users').doc(user.uid).update({
                'addressline1': addressLine1,
                'addressline2': addressLine2,
                'city': city,
                'pincode': pincode,
                'numberofpeople': numberOfPeople,
              });
            } else {
              await _firestore.collection('users').doc(user.uid).update({
                'addressline1': addressLine1,
                'addressline2': addressLine2,
                'city': city,
                'pincode': pincode,
                'numberofpeople': numberOfPeople,
              });

              var collection = _firestore.collection(city.toLowerCase());
              var querySnapshot = await collection.get();
              var resCity;
              var uId;
              for (var queryDocumentSnapshot in querySnapshot.docs) {
                Map<String, dynamic> data = queryDocumentSnapshot.data();
                resCity = data['city'];
                uId = data['uid'];
              }
              print(resCity);
              print(uId);
              if (resCity.toString().toLowerCase() == city.toLowerCase() &&
                  user.uid == uId) {
                await _firestore
                    .collection(city.toLowerCase())
                    .doc(user.uid)
                    .update({
                  'uid': user.uid,
                  'addressline1': addressLine1,
                  'addressline2': addressLine2,
                  'name': name,
                  'city': city,
                  'numberofpeople': numberOfPeople,
                });
              } else {
                await _firestore
                    .collection(city.toLowerCase())
                    .doc(user.uid)
                    .set({
                  'uid': user.uid,
                  'addressline1': addressLine1,
                  'addressline2': addressLine2,
                  'name': name,
                  'city': city,
                  'numberofpeople': numberOfPeople,
                });
              }
            }

            res = 'success';
          } else if (pincode.length < 6 || pincode.length > 6) {
            res = 'Enter Valid Pincode';
          } else if (peoplecount <= 0) {
            res = 'Enter valid number of people';
          }
        } else {
          res = 'Some field are empty, please fill them';
        }
      }
    } catch (_) {
      res = 'Error Occured';
    }

    return res;
  }

//signUp
  Future<String> signUp({
    required String email,
    required String password,
    required String name,
    required bool isRestaurant,
  }) async {
    String res = 'Error Occured';
    try {
      if (email.isNotEmpty || name.isNotEmpty || password.isNotEmpty) {
        final userCred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(userCred.user!.uid).set({
          'name': name,
          'uid': userCred.user!.uid,
          'email': userCred.user!.email!,
          'isRestaurant': isRestaurant,
        });

        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'Please enter a stronger passwrod';
      } else if (e.code == 'email-already-in-use') {
        res = 'Email already in use';
      } else if (e.code == 'invalid-email') {
        res = 'Please enter a valid email';
      } else {
        res = 'Authentication error';
      }
    } catch (_) {
      res = 'Error occured';
    }
    return res;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found, please sign up first';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password entered';
      } else {
        res = 'Authentication error';
      }
    } catch (_) {
      res = 'Error Occured';
    }
    return res;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
