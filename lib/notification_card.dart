import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/hotel_view_notification_card.dart';
import 'package:my_project/models/auth_models.dart';
import 'package:my_project/models/order_model.dart';

class NotificationCard extends StatelessWidget {
  final snap;
  final Order order;
  final User user;

  const NotificationCard({
    Key? key,
    required this.snap,
    required this.order,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        order.isConfirmed == false && user.isRestaurant == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelAddPageFromNoti(order: order),
                ))
            : null;
      },
      onDoubleTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Order Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(user.isRestaurant == true
                      ? 'Order from ' + order.name
                      : 'Order to ' + order.resName),
                ],
              ),
              Row(
                children: [
                  Text(user.isRestaurant == true
                      ? order.isConfirmed == false
                          ? 'Click to open details about the order'
                          : 'Order accepted'
                      : order.isConfirmed == false
                          ? 'Order has been successfully sent'
                          : 'Order has been confirmed by restaurant!'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      order.isConfirmed == false
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HotelAddPageFromNoti(order: order),
                              ))
                          : null;
                    },
                    icon: order.isConfirmed == true && user.isRestaurant == true
                        ? const Icon(Icons.check)
                        : const Icon(null),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
