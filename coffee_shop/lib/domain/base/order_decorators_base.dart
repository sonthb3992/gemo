// Importing the 'OrderBase' class from the 'order_base.dart' file.
import "package:coffee_shop/domain/concrete/enums.dart";

import "./oder_base.dart";

/// This abstract class represents a base for order decorators. These decorators
/// are used for modifying existing orders. This class implements the 'OrderBase'
/// interface.
abstract class OrderDecorator implements OrderBase {
  /// This variable is used to store a reference to the order that is being
  /// decorated. This may be `null`, hence the use of the nullable type.
  OrderBase decoratedOrder;

  /// This variable is used to store the base price of the decorator. It is
  /// initialized to 0 and is final, meaning it cannot be changed after it's
  /// initialized.
  double basePrice = 0;

  /// This is the constructor for the 'OrderDecorator' class. It requires an
  /// 'OrderBase' object as an argument, which is then assigned to the
  /// '_decoratedOrder' variable.
  OrderDecorator(this.decoratedOrder);

  /// This method overrides the 'getDescription' method of the 'OrderBase'
  /// interface. It returns the description of the decorated order, or an
  /// empty string if the decorated order is `null`.
  @override
  String getDescription() {
    return decoratedOrder.getDescription();
  }

  /// This method overrides the 'getPrice' method of the 'OrderBase' interface.
  /// It returns the sum of the price of the decorated order and the base price
  /// of the decorator. If the decorated order is `null`, it defaults to the
  /// '_basePrice'.
  @override
  double getPrice() {
    return (decoratedOrder.getPrice()) + basePrice;
  }

  @override
  String getType() {
    return decoratedOrder.getType();
  }

  @override
  MenuOption getBaseItem() => decoratedOrder.getBaseItem();
}
