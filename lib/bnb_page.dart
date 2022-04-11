import 'package:flutter/material.dart';
import 'package:my_project/help_page.dart';
import 'add_location.dart';
import 'profile_page.dart';
import 'notifications_page.dart';

class bnb_page extends StatefulWidget {
  const bnb_page({Key? key}) : super(key: key);

  @override
  State<bnb_page> createState() => _bnb_pageState();
}

class _bnb_pageState extends State<bnb_page> {
  int _currentIndex = 0;

  final tabs = [
    const AddLocation(),
    // home_page(),
    const notifications_page(),
    profile_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const Icon(Icons.home_filled),
      //   title: const Text('Home'),

      // ),

      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My Profile'),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'profile_page.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:helping_hands/ui/background/background.dart';
// // import 'package:helping_hands/ui/forms/login_screen_ui.dart';

// class home_page extends StatefulWidget {
//   const home_page({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<home_page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.home),
//         ),
//         title: const Text("Helping Hands"),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
//         ],
//         // backgroundColor: Color(0xff1bccba)
//       ),
//       body: SafeArea(
//         child: Material(
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.home),
//                     ),
//                     const SizedBox(
//                       width: 110,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => profile_page()),
//                           );
//                         },
//                         icon: const Icon(Icons.person)),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

