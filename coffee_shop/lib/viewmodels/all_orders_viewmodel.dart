import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/concrete/bartender.dart';
import 'package:flutter/material.dart';

class AllOrdersState extends ChangeNotifier {
  // Your state variables

  AllOrdersState();

  Bartender bartender = Bartender();

  Bartender getBartender() => bartender;

  double getTotal() => bartender.getTotal();

  int getCount() => bartender.getOrderCount();

  void addOrder(OrderBase order) {
    bartender.addOrder(order);
    notifyListeners();
  }

  List<OrderBase> getAllOrders() => bartender.getAllOrders();

  void resetOrders() {
    bartender.resetOrder();
    notifyListeners();
  }

  double getTax() => bartender.getTax();

  double getGrandTotal() => bartender.getGrandTotal();
}
