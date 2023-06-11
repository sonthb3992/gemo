import 'package:coffee_shop/controls/option_item.dart';
import 'package:coffee_shop/domain/concrete/option_style.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../domain/base/oder_base.dart';

class StyleSelector extends StatefulWidget {
  final OrderBase order;
  const StyleSelector(this.order, {super.key});

  @override
  State<StyleSelector> createState() => _StyleSelectorState();
}

class _StyleSelectorState extends State<StyleSelector> {
  StyleOption? drinkType;

  @override
  Widget build(BuildContext context) {
    var viewmodel = Provider.of<NewOrderState>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "serving_style".tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          if (viewmodel.availableStyles != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewmodel.availableStyles!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return RadioOptionItem(
                    option: viewmodel.availableStyles![index],
                    selectedOption: viewmodel.selectedStyle,
                    onChanged: (value) {
                      viewmodel.selectedStyle = value as StyleOption?;
                    });
              },
            )
        ],
      ),
    );
  }
}
