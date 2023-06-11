import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/add_drink_viewmodel.dart';

class ToppingSupportSelector extends StatelessWidget {
  const ToppingSupportSelector({super.key});

  void toggleSupportSize(AddDrinkViewModel viewModel, bool value) {
    viewModel.setSupportSize(value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDrinkViewModel>(builder: (context, viewmodel, _) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              viewmodel.setSupportTopping(!viewmodel.supportTopping);
            },
            child: Row(
              children: [
                Checkbox(
                  value: viewmodel.supportTopping,
                  onChanged: (value) => viewmodel.setSupportTopping(value!),
                ),
                const Text(
                  "Has toppings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (viewmodel.supportTopping)
            Column(children: [
              for (var option in viewmodel.allToppings!)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      viewmodel.setHasTopping(option, !option.values.first);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: option.values.first,
                          onChanged: (value) {
                            viewmodel.setHasTopping(option, value);
                          },
                        ),
                        Text(
                          option.keys.first.nameEn,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
            ]),
        ],
      );
    });
  }
}
