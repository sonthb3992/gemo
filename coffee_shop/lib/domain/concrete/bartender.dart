import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/concrete/breakfast_decorator.dart';
import 'package:coffee_shop/domain/concrete/breakfast_order.dart';
import 'package:coffee_shop/domain/concrete/drink_decorators.dart';
import 'package:coffee_shop/domain/concrete/drink_order.dart';
import 'package:coffee_shop/domain/concrete/enums.dart';

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

  static OrderBase? buildOrder(
      MenuOption menuOption,
      DrinkTypeOption? drinkType,
      DrinkSizeOption? drinkSize,
      bool? hasWhippcream,
      String milk,
      bool? hasChocolateSauce,
      int pumps,
      bool? hasTurkey,
      bool? hasCheeseCream) {
    OrderBase? order;

    //Build drink orders
    if (menuOption.type == "drink") {
      var drink = DrinkOrder(menuOption);
      drink.drinkTypeOption = drinkType!;
      drink.drinkSizeOption = drinkSize!;
      order = drink;
      order = hasWhippcream == true ? WhippedCreamDecorator(order) : order;
      order = milk == "" ? order : MilkDecorator(order, milk == "almond");
      order = hasChocolateSauce == true
          ? ChocolateSauceDecorator(order, pumps)
          : order;
    }

    bool hasEgg = hasTurkey == null || hasTurkey == false;
    bool hasButter = hasCheeseCream == null || hasCheeseCream == false;

    //Build breakfast orders
    if (menuOption.type == "breakfast") {
      var breakfast = BreakfastOrder(menuOption);
      order = breakfast;
      if (TurkeyDecorator.validItems.contains(order.getBaseItem().name)) {
        order = hasTurkey == true ? TurkeyDecorator(order) : (order);
      }
      if (EggDecorator.validItems.contains(order.getBaseItem().name)) {
        order = hasEgg == true ? EggDecorator(order) : (order);
      }
      if (ChesseCreamDecorator.validItems.contains(order.getBaseItem().name)) {
        order = hasCheeseCream == true ? ChesseCreamDecorator(order) : (order);
      }
      if (ButterDecorator.validItems.contains(order.getBaseItem().name)) {
        order = hasButter == true ? ButterDecorator(order) : (order);
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
