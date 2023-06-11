import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/add_drink_viewmodel.dart';

class SizeSupportSelector extends StatelessWidget {
  const SizeSupportSelector({super.key});

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
              viewmodel.setSupportSize(!viewmodel.supportSize);
            },
            child: Row(
              children: [
                Checkbox(
                  value: viewmodel.supportSize,
                  onChanged: (value) => viewmodel.setSupportSize(value!),
                ),
                const Text(
                  "Has multiple sizes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (viewmodel.supportSize)
            Column(children: [
              for (var option in viewmodel.allSizes!)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      viewmodel.setHasSize(option, !option.values.first);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: option.values.first,
                          onChanged: (value) {
                            viewmodel.setHasSize(option, value);
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
