import 'package:coffee_shop/domain/concrete/option_topping.dart';
import 'package:get/get.dart';

import '../base/oder_base.dart';
import '../base/order_decorators_base.dart';

class ToppingDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  ToppingDecorator(OrderBase orderBase, this.toppingMap) : super(orderBase);

  final Map<ToppingOption, int> toppingMap;

  @override
  String getDescription() {
    var en = Get.locale?.countryCode == "en";
    ToppingOption option = toppingMap.keys.first;
    int count = toppingMap.values.first;

    String result =
        "${decoratedOrder.getDescription()}, ${en ? option.nameEn : option.nameVi}";
    if (count > 1) {
      result += "($count)";
    }
    return result;
  }

  @override
  double getPrice() {
    ToppingOption option = toppingMap.keys.first;
    int count = toppingMap.values.first;
    return decoratedOrder.getPrice() + option.getCountPrice(count);
  }
}
