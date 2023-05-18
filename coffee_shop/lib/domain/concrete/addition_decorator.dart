// import 'package:get/get.dart';

// import '../base/oder_base.dart';
// import '../base/order_decorators_base.dart';

// class AdditionDecorator extends OrderDecorator {
//   // Define an array with "sandwich"
//   final double eachPrice;
//   final String name;
//   final String nameVi;
//   final int maxCount;
//   final int freeCount;

//   AdditionDecorator(OrderBase orderBase, this.name, this.nameVi, this.eachPrice,
//       this.maxCount, this.freeCount)
//       : super(orderBase);

//   @override
//   String getDescription() {
//     var en = Get.locale?.countryCode == "en";
//     return "${decoratedOrder.getDescription()}, ${en ? name : nameVi}";
//   }

//   @override
//   double getPrice() {
//     return decoratedOrder.getPrice() + eachPrice * (max());
//   }
// }
