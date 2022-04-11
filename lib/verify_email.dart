import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_project/add_location.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/home_pageNU.dart';
import 'package:my_project/utils/snackbar.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print('is email verified:' + isEmailVerified.toString());
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final User user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      print(canResendEmail);
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(showSnackBar(context, e.code));
    } catch (e) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(showSnackBar(context, e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const AddLocation()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Email Verification'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'A verifcation email has been sent to your device...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: canResendEmail ? sendVerificationEmail : null,
                icon: const Icon(Icons.email),
                label: const Text('Resend email'),
              ),
              TextButton(
                  onPressed: () async {
                    await AuthMethods().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginView', (route) => false);
                  },
                  child: const Text('Cancel'))
            ],
          ),
        );
}
