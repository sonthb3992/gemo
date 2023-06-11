import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:coffee_shop/domain/concrete/option_style.dart';
import 'package:coffee_shop/domain/concrete/order.dart';
import 'package:coffee_shop/domain/concrete/size_decorator.dart';
import 'package:coffee_shop/domain/concrete/style_decorator.dart';
import 'package:coffee_shop/domain/concrete/topping_decorator.dart';

import 'menu_option.dart';
import 'option_topping.dart';

class Bartender {
  var orders = List<OrderBase>.empty(growable: true);

  static const double taxRate = 0.0725;

  Bartender._privateConstructor();

  static final Bartender _instance = Bartender._privateConstructor();

  factory Bartender() => _instance;

  int getOrderCount() => orders.length;

  double getTotal() {
    double sum = 0;
    for (var element in orders) {
      sum += element.getPrice();
    }
    return sum;
  }

  static OrderBase? buildOrder(MenuOption menuOption, StyleOption? style,
      SizeOption? size, List<Map<ToppingOption, int>>? toppings) {
    OrderBase order = Order(menuOption);
    if (style != null) {
      order = StyleDecorator(order, style);
    }
    if (size != null) {
      order = SizeDecorator(order, size);
    }
    if (toppings != null) {
      for (var map in toppings) {
        if (map.keys.first != ToppingOption.empty) {
          order = ToppingDecorator(order, map);
        }
      }
    }
    return order;
  }

  void addOrder(OrderBase order) {
    orders.add(order);
  }

  List<OrderBase> getAllOrders() => orders;

  void resetOrder() {
    orders = List<OrderBase>.empty(growable: true);
  }

  double getTax() => getTotal() * taxRate;

  double getGrandTotal() => getTotal() + getTax();
}
