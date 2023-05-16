import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/base/order_decorators_base.dart';
import 'dart:math';

/// This class represents a Whipped Cream Decorator, which is used to add whipped cream to an order.
/// It extends the 'OrderDecorator' class and thus, must provide concrete implementations of the
/// 'getDescription', 'getPrice', and 'getType' methods.
class WhippedCreamDecorator extends OrderDecorator {
  static double price = 0.5;

  /// The constructor for the 'WhippedCreamDecorator' class. It requires an 'OrderBase' object as an argument.
  /// The 'OrderBase' object is passed to the superclass constructor. The 'basePrice' is then set to 0.5.
  WhippedCreamDecorator(OrderBase orderBase) : super(orderBase) {
    basePrice = WhippedCreamDecorator.price;
  }

  /// This method overrides the 'getDescription' method of the 'OrderBase' interface. It returns the description
  /// of the decorated order, appended with "whipped cream".
  @override
  String getDescription() {
    return "${decoratedOrder.getDescription()}, whipped cream";
  }

  /// This method overrides the 'getPrice' method of the 'OrderBase' interface. It returns the sum of the price
  /// of the decorated order and the base price for adding whipped cream.
  @override
  double getPrice() {
    return (decoratedOrder.getPrice()) + basePrice;
  }

  /// This method overrides the 'getType' method of the 'OrderBase' interface. It returns the type of the
  /// decorated order.
  @override
  String getType() {
    return decoratedOrder.getType();
  }
}

/// This class represents a Milk Decorator, which is used to add milk (either regular or almond) to an order.
/// It extends the 'OrderDecorator' class and thus, must provide concrete implementations of the
/// 'getDescription', 'getPrice', and 'getType' methods.
class MilkDecorator extends OrderDecorator {
  static const double milkPrice = 0;
  static const double almondPrice = 0.5;

  /// The 'useAlmondMilk' variable is a boolean that indicates whether almond milk (true) or regular milk (false)
  /// is to be added to the order.
  bool useAlmondMilk;

  /// The constructor for the 'MilkDecorator' class. It requires an 'OrderBase' object and
  /// a boolean value indicating whether to use almond milk as arguments. The 'OrderBase' object is passed to the
  /// superclass constructor, and the 'useAlmondMilk' variable is assigned the value of the second argument.
  /// The 'basePrice' is then updated based on the type of milk used.
  MilkDecorator(OrderBase orderBase, this.useAlmondMilk) : super(orderBase) {
    basePrice = useAlmondMilk ? almondPrice : milkPrice;
  }

  /// This method overrides the 'getDescription' method of the 'OrderBase' interface. It returns the description
  /// of the decorated order, appended with the description of the type of milk added.
  @override
  String getDescription() =>
      "${decoratedOrder.getDescription()}, ${useAlmondMilk ? "almond milk" : "milk"}";

  /// This method overrides the 'getPrice' method of the 'OrderBase' interface. It returns the sum of the price
  /// of the decorated order and the price of the milk added.
  @override
  double getPrice() => (decoratedOrder.getPrice()) + basePrice;
}

/// This class represents a Chocolate Sauce Decorator, which is used to add chocolate sauce to an order.
/// It extends the 'OrderDecorator' class and thus, must provide concrete implementations of the
/// 'getDescription', 'getPrice', and 'getType' methods.
class ChocolateSauceDecorator extends OrderDecorator {
  static const double pricePerPump = 0.5;
  static const double freePumps = 2;
  static const int maxPumps = 6;

  /// The 'pumps' variable stores the number of chocolate sauce pumps added to the order.
  int pumps;

  /// The constructor for the 'ChocolateSauceDecorator' class. It requires an 'OrderBase' object and
  /// the number of chocolate sauce pumps as arguments. The 'OrderBase' object is passed to the superclass
  /// constructor, and the 'pumps' variable is assigned the value of the second argument. The 'basePrice'
  /// is then updated based on the number of pumps.
  ChocolateSauceDecorator(OrderBase orderBase, this.pumps) : super(orderBase) {
    if (pumps > 6) pumps = 6;
    basePrice = max(0, pumps - freePumps) * pricePerPump;
  }

  /// This method overrides the 'getDescription' method of the 'OrderBase' interface. It returns the description
  /// of the decorated order, appended with the description of the chocolate sauce pumps added.
  @override
  String getDescription() =>
      "${decoratedOrder.getDescription()}, chocolate sauce $pumps pump(s)";

  /// This method overrides the 'getPrice' method of the 'OrderBase' interface. It returns the sum of the price
  /// of the decorated order and the price of the chocolate sauce pumps added.
  @override
  double getPrice() => (decoratedOrder.getPrice()) + basePrice;

  static double calculatePrice(int p) => max(0, p - freePumps) * pricePerPump;
}
