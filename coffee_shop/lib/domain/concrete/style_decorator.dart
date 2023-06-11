import 'package:coffee_shop/domain/concrete/option_style.dart';
import 'package:get/get.dart';

import '../base/oder_base.dart';
import '../base/order_decorators_base.dart';

class StyleDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  StyleDecorator(OrderBase orderBase, this.style) : super(orderBase);

  final StyleOption style;

  @override
  String getDescription() {
    var en = Get.locale?.countryCode == "en";
    return "${decoratedOrder.getDescription()}, ${en ? style.nameEn : style.nameVi}";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + style.basePrice;
  }
}
