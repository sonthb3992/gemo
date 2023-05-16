import 'package:coffee_shop/domain/concrete/enums.dart';

import './order.dart';

class DrinkOrder extends Order {
  DrinkOrder(MenuOption menuOption) : super(menuOption);

  DrinkTypeOption drinkTypeOption = DrinkTypeOption.none;

  DrinkSizeOption _drinkSizeOption = DrinkSizeOption.none;

  DrinkSizeOption get drinkSizeOption => _drinkSizeOption;

  set drinkSizeOption(DrinkSizeOption value) {
    if (drinkTypeOption.hasSize(value)) {
      _drinkSizeOption = value;
    }
  }

  @override
  double getPrice() {
    double price = super.getPrice();
    price += drinkSizeOption.basePrice;
    price += drinkTypeOption.basePrice;
    return price;
  }

  @override
  String getDescription() {
    return "${super.getDescription()} , ${drinkTypeOption.name}, size ${drinkSizeOption.name}";
  }
}
