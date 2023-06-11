import 'package:coffee_shop/controls/checkbox_option_item.dart';
import 'package:coffee_shop/controls/number_option_item.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../domain/base/oder_base.dart';

class ToppingSelector extends StatelessWidget {
  final OrderBase order;
  const ToppingSelector(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    var viewmodel = Provider.of<NewOrderState>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "topping".tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          if (viewmodel.selectedToppings != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewmodel.selectedToppings!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return (viewmodel.selectedToppings![index].keys.first.maxCount >
                        1)
                    ? NumberOptionItem(
                        option: viewmodel.selectedToppings![index].keys.first,
                        selectedOption: viewmodel.selectedToppings![index],
                        max: viewmodel
                            .selectedToppings![index].keys.first.maxCount,
                        onChanged: (value) => {
                              viewmodel.setSelectedTopping(
                                  viewmodel.selectedToppings![index],
                                  viewmodel.selectedToppings![index].keys.first,
                                  value)
                            })
                    : CheckBoxOptionItem(
                        option: viewmodel.selectedToppings![index].keys.first,
                        selectedOption: viewmodel.selectedToppings![index],
                        onChanged: (value) {
                          if (value == false) {
                            viewmodel.unsetSelectedTopping(
                                viewmodel.selectedToppings![index],
                                viewmodel.selectedToppings![index].keys.first);
                          } else {
                            viewmodel.setSelectedTopping(
                                viewmodel.selectedToppings![index],
                                viewmodel.selectedToppings![index].keys.first,
                                1);
                          }
                        });
              },
            )
        ],
      ),
    );
  }
}
