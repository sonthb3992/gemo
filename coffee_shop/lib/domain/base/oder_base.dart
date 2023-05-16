import '../concrete/enums.dart';

/// Abstract class that represents an order.
abstract class OrderBase {
  /// Gets the description of the order.
  ///
  /// Returns:
  ///   The description of the order.
  String getDescription();

  /// Gets the price of the order.
  ///
  /// Returns:
  ///   The price of the order.
  double getPrice();

  /// Gets the type of the order.
  ///
  /// Returns:
  ///   The type of the order.
  String getType();

  /// Gets the base item of the order.
  ///
  /// Returns:
  ///   The base item of the order.
  MenuOption getBaseItem();
}
