import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/utils/snackbar.dart';

class edit_profile_page extends StatefulWidget {
  const edit_profile_page({Key? key}) : super(key: key);

  @override
  State<edit_profile_page> createState() => _edit_profile_pageState();
}

class _edit_profile_pageState extends State<edit_profile_page> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _passwrod;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _passwrod = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _passwrod.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Container(
        height: double.infinity,
        // margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: Colors.limeAccent.withOpacity(0.5),
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Enter details you want to update below to edit your profile',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            labelText: 'Edit your name',
                            // prefix: Icon(Icons.person),
                            filled: true,
                            // fillColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          // onChanged: (value) => title1 = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            labelText: 'Edit your email',
                            // prefix: Icon(Icons.mail),
                            filled: true,
                            // fillColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          // onChanged: (value) => title1 = value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          controller: _passwrod,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            labelText: ' Password',
                            fillColor: Colors.grey,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            // prefix: Icon(Icons.password),
                            labelStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white),
                            // primary: Color.fromRGBO(1, 84, 150, 1),
                            // side: BorderSide(width: 3, color: Colors.brown),
                            elevation: 05,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 10, bottom: 10)),
                        onPressed: () async {
                          String res = 'error';
                          res = await AuthMethods().updateUserDetails(
                              email: _email.text.trim(),
                              name: _name.text,
                              password: _passwrod.text);
                          if (res == 'success') {
                            showSnackBar(context, res);
                          } else {
                            showSnackBar(context, res);
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
