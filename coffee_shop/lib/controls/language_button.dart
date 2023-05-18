import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageButton extends StatelessWidget {
  final void Function() setTitle;

  const LanguageButton(
    this.setTitle, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (Get.locale!.languageCode == "en") {
          Locale newLocale = const Locale("vi", "VN");
          Get.updateLocale(newLocale);
        } else {
          Locale newLocale = const Locale("en", "US");
          Get.updateLocale(newLocale);
        }
        setTitle();
      },
      child: (Get.locale!.languageCode == "en")
          ? Flag.fromCode(
              FlagsCode.VN,
              width: 20,
            )
          : Flag.fromCode(
              FlagsCode.US,
              width: 20,
            ),
    );
  }
}
