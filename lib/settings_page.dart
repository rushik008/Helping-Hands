import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/login_view.dart';
import 'package:my_project/policy_dialog.dart';
import 'change_theme_button_widget.dart';
import 'help_page.dart';

// ignore: camel_case_types
class settings_page extends StatelessWidget {
  const settings_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // for changing theme dynamically
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
// -------------------------------------------------------------------------------------------
            Card(
                child: ListTile(
              title: const Text("Dark Theme"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChangeThemeButtonWidget(),
                ],
              ),
            )),

// -------------------------------------------------------------------------------------------
            Card(
              child: ListTile(
                title: const Text("Privacy Policy"),
                onTap: () {
                  showModal(
                    context: context,
                    configuration: const FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                        key: null,
                      );
                    },
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModal(
                          context: context,
                          configuration:
                              const FadeScaleTransitionConfiguration(),
                          builder: (context) {
                            return PolicyDialog(
                              mdFileName: 'privacy_policy.md',
                              key: null,
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.policy_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
// -------------------------------------------------------------------------------------------
            Card(
              child: ListTile(
                title: const Text("Terms & Conditions"),
                onTap: () {
                  showModal(
                    context: context,
                    configuration: const FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terms_and_conditions.md',
                        key: null,
                      );
                    },
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModal(
                          context: context,
                          configuration:
                              const FadeScaleTransitionConfiguration(),
                          builder: (context) {
                            return PolicyDialog(
                              mdFileName: 'terms_and_conditions.md',
                              key: null,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.terminal_sharp),
                    ),
                  ],
                ),
              ),
            ),

// -------------------------------------------------------------------------------------------

            Card(
              child: ListTile(
                  title: const Text("About Us"),
                  onTap: () {
                    showModal(
                      context: context,
                      configuration: const FadeScaleTransitionConfiguration(),
                      builder: (context) {
                        return PolicyDialog(
                          mdFileName: 'about_us.md',
                          key: null,
                        );
                      },
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModal(
                              context: context,
                              configuration:
                                  const FadeScaleTransitionConfiguration(),
                              builder: (context) {
                                return PolicyDialog(
                                  mdFileName: 'about_us.md',
                                  key: null,
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.info_outline)),
                    ],
                  )),
            ),
// -------------------------------------------------------------------------------------------

            Card(
              child: ListTile(
                  title: const Text("Contact Us"),
                  onTap: () {
                    showModal(
                      context: context,
                      configuration: const FadeScaleTransitionConfiguration(),
                      builder: (context) {
                        return PolicyDialog(
                          mdFileName: 'contact_us.md',
                          key: null,
                        );
                      },
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModal(
                              context: context,
                              configuration:
                                  const FadeScaleTransitionConfiguration(),
                              builder: (context) {
                                return PolicyDialog(
                                  mdFileName: 'contact_us.md',
                                  key: null,
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.phone_outlined)),
                    ],
                  )),
            ),

// -------------------------------------------------------------------------------------------

            // Card(
            //   child: ListTile(
            //       title: const Text("Help Center"),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => help_page()),
            //         );
            //       },
            //       trailing: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           IconButton(
            //               onPressed: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => help_page()),
            //                 );
            //               },
            //               icon: const Icon(Icons.help_center_outlined)),
            //         ],
            //       )),
            // ),

// -------------------------------------------------------------------------------------------
            Card(
              child: ListTile(
                  title: const Text("Log Out"),
                  onTap: () async {
                    await AuthMethods().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginView', (route) => false);
                  }, // backend
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await AuthMethods().logOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/loginView', (route) => false);
                        }, // backend
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
} // stateless 
