import 'package:coffee_shop/controls/size_selector_item.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../domain/base/oder_base.dart';
import '../domain/concrete/enums.dart';

class SizeSelector extends StatefulWidget {
  final OrderBase order;

  const SizeSelector(this.order, {super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  DrinkSizeOption? drinkSize = DrinkSizeOption.s;

  DrinkSizeOption _getDrinkSizeOption(int index, String drinkType) {
    if (index == 0) {
      return DrinkSizeOption.s;
    } else if (index == 1) {
      return DrinkSizeOption.m;
    } else if (index == 2 && drinkType != "hot") {
      return DrinkSizeOption.l;
    } else if (index == 3 && drinkType != "hot") {
      return DrinkSizeOption.xl;
    }
    return DrinkSizeOption.none;
  }

  @override
  Widget build(BuildContext context) {
    var orderState = Provider.of<NewOrderState>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
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
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DrinkSizeOption option = _getDrinkSizeOption(
                    index, orderState.getDrinkType().name.toLowerCase());

                return option == DrinkSizeOption.none
                    ? Container()
                    : DrinkSizeItem(
                        option: option,
                        selectedOption: drinkSize,
                        onChanged: (value) {
                          setState(() {
                            drinkSize = value;
                            if (drinkSize != null) {
                              orderState.setDrinkSize(drinkSize!);
                            }
                          });
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
