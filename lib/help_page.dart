import 'package:flutter/material.dart';

class help_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context); // to go back to the previous page
          },
        ),
        title: Text("Help Center"),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                // leading: Icon(Icons.list),
                // trailing: Icon(icon.add),
                title: Text("Help Center Page"));
          }),
    );
  }
}
