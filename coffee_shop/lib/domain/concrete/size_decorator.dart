import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:get/get.dart';

import '../base/oder_base.dart';
import '../base/order_decorators_base.dart';

class SizeDecorator extends OrderDecorator {
  // Define an array with "sandwich"
  SizeDecorator(OrderBase orderBase, this.size) : super(orderBase);

  final SizeOption size;

  @override
  String getDescription() {
    var en = Get.locale?.countryCode == "en";
    return "${decoratedOrder.getDescription()}, ${'size'.tr} ${en ? size.nameEn : size.nameVi}";
  }

  @override
  double getPrice() {
    return decoratedOrder.getPrice() + size.basePrice;
  }
}
