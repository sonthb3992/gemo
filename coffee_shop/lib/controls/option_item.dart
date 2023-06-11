import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadioOptionItem extends StatelessWidget {
  final OptionBase? option;
  final OptionBase? selectedOption;
  final Function(OptionBase?) onChanged;

  const RadioOptionItem({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isEn = Get.locale!.languageCode == "en";
    return option == null
        ? Container()
        : InkWell(
            onTap: () {
              onChanged(option);
            },
            child: Row(
              children: [
                Radio<OptionBase>(
                  value: option!,
                  groupValue: selectedOption,
                  onChanged: onChanged,
                ),
                Expanded(
                  child: Text(
                    isEn ? option!.getName()! : option!.getNameVi()!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Text(
                  "+\$${option!.getBasePrice().toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
  }
}
