import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/fetch_restaurant_card.dart';
import 'package:my_project/models/auth_models.dart' as model;
import 'package:my_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenFeed extends StatelessWidget {
  const HomeScreenFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Helping Hands'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/notification_page');
                  },
                  child: const Icon(Icons.notifications)),
            ),
          ],
        ),
        body: StreamBuilder(
          stream:
              // FirebaseFirestore.instance.collection('users').where('city', isEqualTo: 'Anand').snapshots(),
              FirebaseFirestore.instance
                  .collection(user.city.toLowerCase())
                  .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) =>
                  FetchRestaurantCard(snap: snapshot.data!.docs[index].data()),
              itemCount: snapshot.data!.size,
            );
          },
        ));
  }
}
