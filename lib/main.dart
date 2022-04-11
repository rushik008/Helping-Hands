// @dart=2.9

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/constants.dart';
import 'package:my_project/firebase_options.dart';
import 'package:my_project/add_location.dart';
import 'package:my_project/home_pageNU.dart';
import 'package:my_project/hotel_view_on_notif.dart';
import 'package:my_project/login_view.dart';
import 'package:my_project/notifications_page.dart';
import 'package:my_project/provider/user_provider.dart';
import 'package:my_project/services/push_notification.dart';
import 'package:my_project/theme_provider.dart';
import 'package:my_project/verify_email.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: themeProvider.themeMode,
                // themeMode: ThemeMode.system,
                // themeMode: ThemeMode.light, // it will always show the light theme
                theme: MyTheme.lightTheme,
                darkTheme: MyTheme.darkTheme,

                // home: const splash_screen(),
                // home: const bnb_page(),
                home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return const VerifyEmailView();
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    return const LoginView();
                  },
                ),
                // home: const LoginView(),
                // home: const home_pageNU(),
                routes: Navigate.routes,
                onUnknownRoute: (settings) => MaterialPageRoute(
                  builder: (context) => const HomePageNU(),
                ),
                // initialRoute: '/loginView',
              );
            },
          ),
        ],
      );
}
