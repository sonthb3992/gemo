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
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Size",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  drinkSize = DrinkSizeOption.s;
                  orderState.setDrinkSize(drinkSize!);
                });
              },
              child: Row(
                children: [
                  Radio<DrinkSizeOption>(
                    value: DrinkSizeOption.s,
                    groupValue: drinkSize,
                    onChanged: (value) {
                      setState(() {
                        drinkSize = value;
                        orderState.setDrinkSize(drinkSize!);
                      });
                    },
                  ),
                  const Expanded(
                      child: Text(
                    "Size S",
                    style: TextStyle(fontSize: 18),
                  )),
                  Text(
                    "+\$${(DrinkSizeOption.s.basePrice).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  drinkSize = DrinkSizeOption.m;
                  orderState.setDrinkSize(drinkSize!);
                });
              },
              child: Row(
                children: [
                  Radio<DrinkSizeOption>(
                    value: DrinkSizeOption.m,
                    groupValue: drinkSize,
                    onChanged: (value) {
                      setState(() {
                        drinkSize = value;
                        orderState.setDrinkSize(drinkSize!);
                      });
                    },
                  ),
                  const Expanded(
                      child: Text(
                    "Size M",
                    style: TextStyle(fontSize: 18),
                  )),
                  Text(
                    "+\$${(DrinkSizeOption.m.basePrice).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            if (orderState.getDrinkType() == DrinkTypeOption.cold ||
                orderState.getDrinkType() == DrinkTypeOption.blended)
              InkWell(
                onTap: () {
                  setState(() {
                    drinkSize = DrinkSizeOption.l;
                    orderState.setDrinkSize(drinkSize!);
                  });
                },
                child: Row(
                  children: [
                    Radio<DrinkSizeOption>(
                      value: DrinkSizeOption.l,
                      groupValue: drinkSize,
                      onChanged: (value) {
                        setState(() {
                          drinkSize = value;
                          orderState.setDrinkSize(drinkSize!);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Size L",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                        "+\$${(DrinkSizeOption.l.basePrice).toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
              ),
            if (orderState.getDrinkType() == DrinkTypeOption.cold ||
                orderState.getDrinkType() == DrinkTypeOption.blended)
              InkWell(
                onTap: () {
                  setState(() {
                    drinkSize = DrinkSizeOption.xl;
                    orderState.setDrinkSize(drinkSize!);
                  });
                },
                child: Row(
                  children: [
                    Radio<DrinkSizeOption>(
                      value: DrinkSizeOption.xl,
                      groupValue: drinkSize,
                      onChanged: (value) {
                        setState(() {
                          drinkSize = value;
                          orderState.setDrinkSize(drinkSize!);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Size XL",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                        "+\$${(DrinkSizeOption.xl.basePrice).toStringAsFixed(2)}",
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
