import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/models/auth_models.dart' as model;
import 'package:my_project/models/order_model.dart';
import 'package:my_project/notification_card.dart';
import 'package:my_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

class notifications_page extends StatefulWidget {
  const notifications_page({Key? key}) : super(key: key);

  @override
  State<notifications_page> createState() => _notifications_pageState();
}

class _notifications_pageState extends State<notifications_page> {
  // Order? orderr;

  List<Order>? _orderList;

  Future getOrderDetailsList() async {
    final model.User user = await AuthMethods().getUserDetails();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('order')
        .get();

    setState(() {
      _orderList = List.from(data.docs.map((doc) => Order.fromSnap(doc)));
    });
  }

  @override
  void didChangeDependencies() {
    getOrderDetailsList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    OrderProvider _orderProvider = Provider.of(context, listen: false);
    await _orderProvider.refreshOrder();
    await _userProvider.refreshUser();
    // orderr = await AuthMethods().getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('order')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          print(snapshot.hasData);
          // if (snapshot.data!.docs.isNotEmpty) {
          //   if (snapshot.connectionState == ConnectionState.waiting) {
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   }

          if (!snapshot.hasData || _orderList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //  Order? order = Provider.of<OrderProvider>(context).getOrder;

          return ListView.builder(
            itemBuilder: (context, index) => NotificationCard(
                snap: snapshot.data!.docs[index].data(),
                order: _orderList![index],
                user: user),
            itemCount: snapshot.data!.size,
          );

          // return const Text('No orders received yet');
        },
      ),
    );
  }
}
