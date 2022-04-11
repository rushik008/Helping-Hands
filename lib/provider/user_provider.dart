import 'package:flutter/material.dart';
import 'package:my_project/auth/auth_methods.dart';
import 'package:my_project/models/auth_models.dart';
import 'package:my_project/models/order_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

class OrderProvider extends ChangeNotifier {
  Order? _order;
  final AuthMethods _authMethods = AuthMethods();
  Order get getOrder => _order!;

  Future<void> refreshOrder() async {
    Order order = await _authMethods.getOrderDetails();
    _order = order;
    notifyListeners();
  }
}
