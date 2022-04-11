import 'package:flutter/material.dart';
import 'package:my_project/models/auth_models.dart' as model;
import 'package:my_project/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'edit_profile_page.dart';
import 'settings_page.dart';

class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      // appBar: AppBar(
      //   title: const Text("My Profile"),
      //   // automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.person),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => settings_page()),
      //           );
      //         },
      //         icon: const Icon(Icons.settings)),
      //   ],
      // ),

// -------------------------------------------------------------------------------------------
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),

          Container(
            child: Container(
              width: double.infinity,
              height: 120,
              child: Container(
                alignment: const Alignment(0.0, 0.0),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/images/avatar_image2.png"), // backend code
                  // NetworkImage("assets/images/avatar_image2.png"),
                  radius: 75.0,
                  // child: Icon(Icons.add), // to change the profile picture
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text(user.name), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
                ],
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text(user.email), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
                ],
              ),
            ),
          ),

// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: const Text("Edit Profile"),
              onTap: () {
                Navigator.of(context).pushNamed('/edit_profile');
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/edit_profile');
                      },
                      icon: const Icon(Icons.edit)),
                ],
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: const Text("Settings"),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/settings');
                      },
                      icon: const Icon(Icons.settings)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} // stateless widget
