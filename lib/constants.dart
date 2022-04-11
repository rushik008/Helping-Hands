import 'package:flutter/material.dart';
import 'package:my_project/add_location.dart';
import 'package:my_project/bnb_page.dart';
import 'package:my_project/edit_profile_page.dart';
import 'package:my_project/forgot_password_view.dart';
import 'package:my_project/home_pageNU.dart';
import 'package:my_project/hotel_view_on_notif.dart';
import 'package:my_project/login_view.dart';
import 'package:my_project/notifications_page.dart';
import 'package:my_project/profile_page.dart';
import 'package:my_project/settings_page.dart';
import 'package:my_project/signup_page.dart';
import 'package:my_project/verify_email.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/loginView': (context) => const LoginView(),
    '/registerView': (context) => const SignUpView(),
    '/home_page': (context) => const HomePageNU(),
    '/notification_page': (context) => const notifications_page(),
    '/add_location': (context) => const AddLocation(),
    '/hotel_add': (context) => const hotel_ad_page(),
    '/verify_email': (context) => const VerifyEmailView(),
    '/forgot_password': (context) => const ForgotPassword(),
    '/edit_profile': (context) => const edit_profile_page(),
    '/settings': (context) => const settings_page(),
  };
}
