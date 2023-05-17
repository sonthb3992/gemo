import 'package:coffee_shop/domain/concrete/breakfast_decorator.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/base/oder_base.dart';
import 'domain/concrete/drink_decorators.dart';
import 'domain/concrete/enums.dart';

class ToppingSelector extends StatefulWidget {
  final OrderBase order;
  const ToppingSelector(this.order, {super.key});

  @override
  State<ToppingSelector> createState() => _ToppingSelectorState();
}

class _ToppingSelectorState extends State<ToppingSelector> {
  DrinkTypeOption? drinkType = DrinkTypeOption.hot;
  bool hasWhippcream = false;
  bool hasMilk = false;
  bool hasAlmondMilk = false;
  bool hasChocolateSauce = false;
  bool hasTurkey = false;
  bool hasEgg() => !hasTurkey;
  bool hasCheeseCream = false;
  bool hasButter() => !hasCheeseCream;
  double pumps = 1;

  @override
  Widget build(BuildContext context) {
    var orderState = Provider.of<NewOrderState>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Toppings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            if (orderState.getBaseItem().type == "drink")
              InkWell(
                onTap: () {
                  setState(() {
                    hasWhippcream = !hasWhippcream;
                    orderState.setWhippedCream(hasWhippcream);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasWhippcream,
                      onChanged: (value) {
                        setState(() {
                          hasWhippcream = value ?? false;
                          orderState.setWhippedCream(hasWhippcream);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Whipped cream",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(WhippedCreamDecorator.price).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().type == "drink")
              InkWell(
                onTap: () {
                  setState(() {
                    hasMilk = !hasMilk;
                    if (hasMilk) hasAlmondMilk = false;
                    orderState.setMilk(
                        hasMilk ? "milk" : (hasAlmondMilk ? "almond" : ""));
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasMilk,
                      onChanged: (value) {
                        setState(() {
                          hasMilk = value ?? false;
                          if (hasMilk) hasAlmondMilk = false;
                          orderState.setMilk(hasMilk
                              ? "milk"
                              : (hasAlmondMilk ? "almond" : ""));
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Milk",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(MilkDecorator.milkPrice).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().type == "drink")
              InkWell(
                onTap: () {
                  setState(() {
                    hasAlmondMilk = !hasAlmondMilk;
                    if (hasAlmondMilk) hasMilk = false;
                    orderState.setMilk(
                        hasMilk ? "milk" : (hasAlmondMilk ? "almond" : ""));
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasAlmondMilk,
                      onChanged: (value) {
                        setState(() {
                          hasAlmondMilk = value ?? false;
                          if (hasAlmondMilk) hasMilk = false;
                          orderState.setMilk(hasMilk
                              ? "milk"
                              : (hasAlmondMilk ? "almond" : ""));
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Almond Milk",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(MilkDecorator.almondPrice).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().type == "drink" &&
                orderState.getDrinkType() == DrinkTypeOption.hot)
              InkWell(
                onTap: () {
                  setState(() {
                    hasChocolateSauce = !hasChocolateSauce;
                    if (!hasChocolateSauce) pumps = 1;
                    orderState.setHasChocolateSauce(hasChocolateSauce);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasChocolateSauce,
                      onChanged: (value) {
                        setState(() {
                          hasChocolateSauce = value ?? false;
                          if (!hasChocolateSauce) pumps = 1;
                          orderState.setHasChocolateSauce(hasChocolateSauce);
                        });
                      },
                    ),
                    Expanded(
                        child: Text(
                      "Chocolate sauce (${pumps.round()} pumps)",
                      style: const TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${ChocolateSauceDecorator.calculatePrice(pumps.round()).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().type == "drink" &&
                orderState.hasChocolateSauce() == true)
              InkWell(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Pumps: ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                          value: pumps,
                          min: 1,
                          max: 6,
                          divisions: 5,
                          onChanged: (value) {
                            setState(() {
                              pumps = value;
                              orderState.setPumps(pumps.round());
                            });
                          }),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().name == "Sandwich")
              InkWell(
                onTap: () {
                  setState(() {
                    hasTurkey = !hasTurkey;
                    orderState.setHasTurkey(hasTurkey);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasTurkey,
                      onChanged: (value) {
                        setState(() {
                          hasTurkey = value ?? false;
                          orderState.setHasTurkey(hasTurkey);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Turkey",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(TurkeyDecorator.price).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().name == "Sandwich")
              InkWell(
                onTap: () {
                  setState(() {
                    hasTurkey = !hasTurkey;
                    orderState.setHasTurkey(hasTurkey);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: !hasTurkey,
                      onChanged: (value) {
                        setState(() {
                          hasTurkey = !(value ?? false);
                          orderState.setHasTurkey(hasTurkey);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Egg",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(EggDecorator.price).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().name == "Bagel")
              InkWell(
                onTap: () {
                  setState(() {
                    hasCheeseCream = !hasCheeseCream;
                    orderState.setHasCheeseCream(hasCheeseCream);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: hasCheeseCream,
                      onChanged: (value) {
                        setState(() {
                          hasCheeseCream = value ?? false;
                          orderState.setHasCheeseCream(hasCheeseCream);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Cheese cream",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(ChesseCreamDecorator.price).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            if (orderState.getBaseItem().name == "Bagel")
              InkWell(
                onTap: () {
                  setState(() {
                    hasCheeseCream = !hasCheeseCream;
                    orderState.setHasCheeseCream(hasCheeseCream);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: !hasCheeseCream,
                      onChanged: (value) {
                        setState(() {
                          hasCheeseCream = !(value ?? false);
                          orderState.setHasCheeseCream(hasCheeseCream);
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      "Butter",
                      style: TextStyle(fontSize: 18),
                    )),
                    Text(
                      "+\$${(ButterDecorator.price).toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
