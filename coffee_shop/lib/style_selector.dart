import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/base/oder_base.dart';
import 'domain/concrete/enums.dart';

class StyleSelector extends StatefulWidget {
  final OrderBase order;
  const StyleSelector(this.order, {super.key});

  @override
  State<StyleSelector> createState() => _StyleSelectorState();
}

class _StyleSelectorState extends State<StyleSelector> {
  DrinkTypeOption? drinkType = DrinkTypeOption.hot;

  @override
  Widget build(BuildContext context) {
    var orderState = Provider.of<NewOrderState>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            "Serving Style",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                DrinkTypeOption option = DrinkTypeOption.none;
                if (index == 0) {
                  option = DrinkTypeOption.hot;
                } else if (index == 1) {
                  option = DrinkTypeOption.cold;
                } else if (index == 2) {
                  option = DrinkTypeOption.blended;
                }
                return DrinkOptionItem(
                  option: option,
                  selectedOption: drinkType,
                  onChanged: (value) {
                    setState(() {
                      drinkType = value;
                      if (drinkType != null) {
                        orderState.setDrinkType(drinkType!);
                      }
                    });
                  },
                );
              })
        ],
      ),
    );
  }
}

class DrinkOptionItem extends StatelessWidget {
  final DrinkTypeOption option;
  final DrinkTypeOption? selectedOption;
  final Function(DrinkTypeOption?) onChanged;

  const DrinkOptionItem({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(option);
      },
      child: Row(
        children: [
          Radio<DrinkTypeOption>(
            value: option,
            groupValue: selectedOption,
            onChanged: onChanged,
          ),
          Expanded(
            child: Text(
              option.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Text(
            "+\$${option.basePrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
