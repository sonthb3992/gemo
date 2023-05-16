import 'package:coffee_shop/domain/base/oder_base.dart';
import 'enums.dart';

/// This class represents an order in a coffee shop. The class extends the 'OrderBase' abstract class,
/// so it needs to provide concrete implementations of the 'getDescription' and 'getPrice' methods.
class Order extends OrderBase {
  /// This variable stores a 'MenuOption' object, which represents a menu option in the coffee shop.
  /// Each 'Order' object has a menu option associated with it.
  final MenuOption _menuOption;

  /// This is the constructor for the 'Order' class. It requires a 'MenuOption' object as an argument,
  /// which is then assigned to the '_menuOption' variable.
  Order(this._menuOption);

  /// This method overrides the 'getDescription' method of the 'OrderBase' interface.
  /// It returns the name of the menu option associated with this order.
  @override
  String getDescription() {
    return _menuOption.name;
  }

  /// This method overrides the 'getPrice' method of the 'OrderBase' interface.
  /// It returns the base price of the menu option associated with this order.
  @override
  double getPrice() {
    return _menuOption.basePrice;
  }

  /// This method overrides the 'getType' method of the 'OrderBase' interface.
  /// It returns the type of the menu option associated with this order.
  @override
  String getType() {
    return _menuOption.type;
  }

  @override
  MenuOption getBaseItem() => _menuOption;
}
