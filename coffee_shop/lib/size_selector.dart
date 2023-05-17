import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/base/oder_base.dart';
import 'domain/concrete/enums.dart';

class SizeSelector extends StatefulWidget {
  final OrderBase order;

  const SizeSelector(this.order, {super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  DrinkSizeOption? drinkSize = DrinkSizeOption.s;

  @override
  Widget build(BuildContext context) {
    var orderState = Provider.of<NewOrderState>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            "Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DrinkSizeOption option = DrinkSizeOption.none;
              if (index == 0) {
                option = DrinkSizeOption.s;
              } else if (index == 1) {
                option = DrinkSizeOption.m;
              } else if (index == 2) {
                option = orderState.getDrinkType().name.toLowerCase() == "hot"
                    ? DrinkSizeOption.none
                    : DrinkSizeOption.l;
              } else if (index == 3) {
                option = orderState.getDrinkType().name.toLowerCase() == "hot"
                    ? DrinkSizeOption.none
                    : DrinkSizeOption.xl;
              }
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
    );
  }
}

class DrinkSizeItem extends StatelessWidget {
  final DrinkSizeOption option;
  final DrinkSizeOption? selectedOption;
  final Function(DrinkSizeOption?) onChanged;

  const DrinkSizeItem({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onChanged(option);
        },
        child: Row(
          children: [
            Radio<DrinkSizeOption>(
              value: option,
              groupValue: selectedOption,
              onChanged: onChanged,
            ),
            Expanded(
              child: Text(
                "Size ${option.name}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Text(
              "+\$${option.basePrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
