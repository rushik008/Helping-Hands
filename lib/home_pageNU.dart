import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_project/add_location.dart';
import 'package:my_project/home_screen.dart';
import 'package:my_project/models/auth_models.dart' as models;
import 'package:my_project/notifications_page.dart';
import 'package:my_project/profile_page.dart';
import 'package:my_project/provider/user_provider.dart';
import 'package:my_project/services/push_notification.dart';
import 'package:my_project/settings_page.dart';
import 'package:my_project/update_location.dart';
import 'package:provider/provider.dart';

class HomePageNU extends StatefulWidget {
  const HomePageNU({Key? key}) : super(key: key);

  @override
  State<HomePageNU> createState() => _HomePageNUState();
}

class _HomePageNUState extends State<HomePageNU> {
  late PageController pageController;
  int _page = 0;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    addData();
    pageController = PageController();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      print('fcm message received');
      LocalNotificationService.display(event);
    });
    LocalNotificationService.initialize(context);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      print(message);
      // Navigator.of(context).pushNamed('/hotel_add');
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   automaticallyImplyLeading: false,
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).pushNamed('/add_location');
      //         },
      //         child: const Icon(Icons.add),
      //       ),
      //     ),
      //   ],
      // ),
      body: PageView(
        children: [
          user.isRestaurant == false
              ? const HomeScreenFeed()
              : const notifications_page(),
          const UpdateLocation(),
          const profile_page(),
        ],
        // physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white10,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.purple : Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
              color: _page == 1 ? Colors.purple : Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.notifications,
          //     color: _page == 2 ? Colors.purple : Colors.black,
          //   ),
          //   label: '',
          //   backgroundColor: Colors.white,
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 2 ? Colors.purple : Colors.black,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.settings,
          //     color: _page == 4 ? Colors.purple : Colors.black,
          //   ),
          //   label: '',
          //   backgroundColor: Colors.white,
          // ),
        ],
        onTap: navigationTapped,
      ),
      // body: Column(
      //   children: [
      //     Text(user.addressLine1),
      //     Text(user.addressLine2),
      //     Text(user.city),
      //     Text(user.name),
      //   ],
      // ),
    );
  }
}
