import 'package:coffee_shop/controls/option_item.dart';
import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../domain/base/oder_base.dart';

class SizeSelector extends StatelessWidget {
  final OrderBase order;
  const SizeSelector(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    var viewmodel = Provider.of<NewOrderState>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "size".tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          if (viewmodel.availableSizes != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewmodel.availableSizes!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RadioOptionItem(
                    option: viewmodel.availableSizes![index],
                    selectedOption: viewmodel.selectedSize,
                    onChanged: (value) {
                      viewmodel.selectedSize = value as SizeOption?;
                    });
              },
            )
        ],
      ),
    );
  }
}

// class _SizeSelectorState extends State<SizeSelector> {
//   StyleOption? drinkType;

//   @override
//   Widget build(BuildContext context) {
//     var orderState = Provider.of<NewOrderState>(context);
//     return FutureBuilder<List<StyleOption>?>(
//       future: orderState.availableStyles,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<StyleOption>?> snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const CircularProgressIndicator();
//           default:
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "serving_style".tr,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     if (snapshot.data != null)
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return DrinkOptionItem(
//                               option: snapshot.data![index],
//                               selectedOption: orderState.style,
//                               onChanged: (value) {
//                                 orderState.style = value;
//                               });
//                         },
//                       )
//                   ],
//                 ),
//               );
//             }
//         }
//       },
//     );
//   }
// }

// class DrinkOptionItem extends StatelessWidget {
//   final StyleOption? option;
//   final StyleOption? selectedOption;
//   final Function(StyleOption?) onChanged;

//   const DrinkOptionItem({
//     super.key,
//     required this.option,
//     required this.selectedOption,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChanged(option);
//       },
//       child: Row(
//         children: [
//           Radio<StyleOption>(
//             value: option!,
//             groupValue: selectedOption,
//             onChanged: onChanged,
//           ),
//           Expanded(
//             child: Text(
//               option != null ? option!.nameEn : "",
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//           Text(
//             "+\$${option!.basePrice.toStringAsFixed(2)}",
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }
