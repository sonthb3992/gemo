import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/base/order_decorators_base.dart';

class TurkeyDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  static List<String> validItems = ["Sandwich"];
  static double price = 1;

  TurkeyDecorator(OrderBase orderBase) : super(orderBase) {
    if (!validItems.contains(orderBase.getBaseItem().name)) {
      throw Exception('Invalid base item for TurkeyDecorator');
    }
    basePrice = price;
  }

  @override
  String getDescription() {
    return "${decoratedOrder.getDescription()}, with turkey";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + basePrice;
  }
}

class EggDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  static List<String> validItems = ["Sandwich"];
  static double price = 0;

  EggDecorator(OrderBase orderBase) : super(orderBase) {
    if (!validItems.contains(orderBase.getBaseItem().name)) {
      throw Exception('Invalid base item for EggDecorator');
    }
    basePrice = price;
  }

  @override
  String getDescription() {
    return "${decoratedOrder.getDescription()}, with egg";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + basePrice;
  }
}

class ChesseCreamDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  static List<String> validItems = ["Bagel"];
  static double price = 0.5;

  ChesseCreamDecorator(OrderBase orderBase) : super(orderBase) {
    if (!validItems.contains(orderBase.getBaseItem().name)) {
      throw Exception('Invalid base item for ChesseCreamDecorator');
    }
    basePrice = price;
  }

  @override
  String getDescription() {
    return "${decoratedOrder.getDescription()}, with chese cream";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + basePrice;
  }
}

class ButterDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  static List<String> validItems = ["Bagel"];
  static double price = 0;

  ButterDecorator(OrderBase orderBase) : super(orderBase) {
    if (!validItems.contains(orderBase.getBaseItem().name)) {
      throw Exception('Invalid base item for ButterDecorator');
    }
    basePrice = price;
  }

  @override
  String getDescription() {
    return "${decoratedOrder.getDescription()}, with butter";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + basePrice;
  }
}
