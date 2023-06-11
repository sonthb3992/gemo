import 'package:coffee_shop/controls/number_select.dart';
import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberOptionItem extends StatefulWidget {
  final OptionBase? option;
  final Map<OptionBase, int>? selectedOption;
  final Function(int) onChanged;

  final int max;
  final int min;

  const NumberOptionItem({
    super.key,
    required this.option,
    required this.selectedOption,
    this.max = 10,
    this.min = 0,
    required this.onChanged,
  });

  @override
  State<NumberOptionItem> createState() => _NumberOptionItemState();
}

class _NumberOptionItemState extends State<NumberOptionItem> {
  int currentCount = 0;
  bool isEn = Get.locale!.languageCode == "en";
  @override
  Widget build(BuildContext context) {
    print(isEn);

    return widget.option == null
        ? Container()
        : Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    isEn
                        ? widget.option!.getName()!
                        : widget.option!.getNameVi()!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              NumericStepButton(
                maxValue: widget.max,
                minValue: widget.min,
                onChanged: (int value) {
                  widget.onChanged(value);
                  setState(() {
                    currentCount = value;
                  });
                },
              ),
              Text(
                "+\$${widget.option!.getCountPrice(currentCount).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          );
  }
}
