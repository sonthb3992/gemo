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
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Serving Style",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  drinkType = DrinkTypeOption.hot;
                  if (drinkType != null) {
                    orderState.setDrinkType(drinkType!);
                  }
                });
              },
              child: Row(
                children: [
                  Radio<DrinkTypeOption>(
                    value: DrinkTypeOption.hot,
                    groupValue: drinkType,
                    onChanged: (value) {
                      setState(() {
                        drinkType = value;
                        if (drinkType != null) {
                          orderState.setDrinkType(drinkType!);
                        }
                      });
                    },
                  ),
                  const Expanded(
                      child: Text(
                    "Hot",
                    style: TextStyle(fontSize: 18),
                  )),
                  Text(
                    "+\$${(DrinkTypeOption.hot.basePrice).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  drinkType = DrinkTypeOption.cold;
                  if (drinkType != null) {
                    orderState.setDrinkType(drinkType!);
                  }
                });
              },
              child: Row(
                children: [
                  Radio<DrinkTypeOption>(
                    value: DrinkTypeOption.cold,
                    groupValue: drinkType,
                    onChanged: (value) {
                      setState(() {
                        drinkType = value;
                        if (drinkType != null) {
                          orderState.setDrinkType(drinkType!);
                        }
                      });
                    },
                  ),
                  const Expanded(
                      child: Text(
                    "Cold",
                    style: TextStyle(fontSize: 18),
                  )),
                  Text(
                    "+\$${(DrinkTypeOption.cold.basePrice).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  drinkType = DrinkTypeOption.blended;
                  if (drinkType != null) {
                    orderState.setDrinkType(drinkType!);
                  }
                });
              },
              child: Row(
                children: [
                  Radio<DrinkTypeOption>(
                    value: DrinkTypeOption.blended,
                    groupValue: drinkType,
                    onChanged: (value) {
                      setState(() {
                        drinkType = value;
                        if (drinkType != null) {
                          orderState.setDrinkType(drinkType!);
                        }
                      });
                    },
                  ),
                  const Expanded(
                      child: Text(
                    "Blended",
                    style: TextStyle(fontSize: 18),
                  )),
                  Text(
                      "+\$${(DrinkTypeOption.blended.basePrice).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
