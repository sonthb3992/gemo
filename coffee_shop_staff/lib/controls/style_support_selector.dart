import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/add_drink_viewmodel.dart';

class StyleSupportSelector extends StatelessWidget {
  const StyleSupportSelector({super.key});

  void toggleSupportStyle(AddDrinkViewModel viewModel, bool value) {
    viewModel.setSupportStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDrinkViewModel>(builder: (context, viewmodel, _) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              viewmodel.setSupportStyle(!viewmodel.supportStyle);
            },
            child: Row(
              children: [
                Checkbox(
                  value: viewmodel.supportStyle,
                  onChanged: (value) => viewmodel.setSupportStyle(value!),
                ),
                const Text(
                  "Has serving styles",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (viewmodel.supportStyle)
            Column(children: [
              for (var option in viewmodel.allStyles!)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      viewmodel.setHasStyle(option, !option.values.first);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: option.values.first,
                          onChanged: (value) {
                            viewmodel.setHasStyle(option, value);
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
