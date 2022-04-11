// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/models/order_model.dart';
import 'package:my_project/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_project/models/auth_models.dart' as model;

class hotel_ad_page extends StatefulWidget {
  const hotel_ad_page({Key? key}) : super(key: key);

  @override
  State<hotel_ad_page> createState() => _hotel_ad_pageState();
}

class _hotel_ad_pageState extends State<hotel_ad_page> {
  addData() async {
    OrderProvider orderProvider = Provider.of(context, listen: false);
    await orderProvider.refreshOrder();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Order order = Provider.of<OrderProvider>(context).getOrder;
    var addressline1 = order.addressLine1;
    var addressline2 = order.addressLine2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order accept"),
        // automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () async {
            await Navigator.of(context)
                .pushNamedAndRemoveUntil('/home_page', (route) => false);
          },
        ),
      ),

// -------------------------------------------------------------------------------------------
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          // -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text('Name:' + order.name), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
          // -------------------------------------------------------------------------------------------
          // -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text('Name:' + order.email), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
          // -------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text("Address line 1 : $addressline1 "), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text("Address line 2 : $addressline2 "), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text('Pincode:' + order.pincode), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          Card(
            child: ListTile(
              title: Text("No. of people " + order.numberOfPeople), // backend
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
// -------------------------------------------------------------------------------------------
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
            child: Text(
              "Your one click can feed many !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  // color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("Decline".toUpperCase(),
                    style: const TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(11)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                onPressed: () async {
                  await AuthMethods().deleteOrderIfNotConfirmed();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home_page', (route) => false);
                },
              ),
              const SizedBox(
                width: 40,
              ),
              ElevatedButton(
                child: Text("Accept".toUpperCase(),
                    style: const TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
                onPressed: () async {
                  await AuthMethods().confirmOrder(
                      ruid: order.ruid,
                      isConfirmed: true,
                      numberOfPeople: int.parse(order.numberOfPeople),
                      uuid: order.uid);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home_page', (route) => false);
                },
              ),
            ],
          ),

// -------------------------------------------------------------------------------------------
          // ElevatedButton(
          //   child: const Text("Accept"),
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     textStyle: const TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // OutlineButton(
          //   child: const Text(
          //     "Decline",
          //     style: TextStyle(
          //       fontSize: 20,
          //     ),
          //   ),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //   onPressed: () {},
          // ),
// -------------------------------------------------------------------------------------------
        ],
      ),
    );
  }
} // stateless widget
