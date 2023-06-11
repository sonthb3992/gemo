import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/add_drink_viewmodel.dart';

class TypeOfItemSelector extends StatelessWidget {
  const TypeOfItemSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDrinkViewModel>(builder: (context, viewmodel, _) {
      return Column(
        children: [
          for (var option in viewmodel.allMenuItemTypes!)
            InkWell(
              onTap: () {
                viewmodel.setSelectedMenuItemType(option);
              },
              child: Row(
                children: [
                  Radio(
                      value: option,
                      groupValue: viewmodel.selectedMenuItemType,
                      onChanged: (value) =>
                          viewmodel.setSelectedMenuItemType(value)),
                  Text(
                    option.nameEn,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
        ],
      );
    });
  }
}
