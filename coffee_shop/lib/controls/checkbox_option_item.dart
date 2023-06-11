import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxOptionItem extends StatelessWidget {
  final OptionBase? option;
  final Map<OptionBase, int>? selectedOption;
  final Function(bool) onChanged;

  const CheckBoxOptionItem({
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
              onChanged(!(selectedOption![option]! > 0));
            },
            child: Row(
              children: [
                Checkbox(
                    value: selectedOption![option]! > 0,
                    onChanged: (value) =>
                        onChanged(!(selectedOption![option]! > 0))),
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
