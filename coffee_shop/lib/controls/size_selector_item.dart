import 'package:coffee_shop/domain/concrete/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrinkSizeItem extends StatelessWidget {
  final DrinkSizeOption option;
  final DrinkSizeOption? selectedOption;
  final Function(DrinkSizeOption?) onChanged;
  final bool isEn = Get.locale!.languageCode == "en";

  DrinkSizeItem({
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
          Radio<DrinkSizeOption>(
            value: option,
            groupValue: selectedOption,
            onChanged: onChanged,
          ),
          Expanded(
            child: Text(
              "${'size'.tr} ${isEn ? option.name : option.nameVi}",
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
