import 'package:coffee_shop/domain/concrete/enums.dart';
import 'package:coffee_shop/menu_page_item.dart';
import 'package:coffee_shop/menu_page_total.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_drawer.dart';

class MenuPageWeb extends StatefulWidget {
  const MenuPageWeb({super.key});

  @override
  State<MenuPageWeb> createState() => _MenuPageWebState();
}

class _MenuPageWebState extends State<MenuPageWeb> {
  String filter = "all_items";
  String title = 'all_items'.tr;
  static const List<MenuOption> options = [
    MenuOption.coffee,
    MenuOption.milkTea,
    MenuOption.sandwich,
    MenuOption.bagel,
  ];
  List<MenuOption> filteredOptions = options;

  void handleItemTap(String newHeaderTitle, String newFilter) {
    setState(() {
      title = newFilter.tr;
      filter = newFilter;
      filteredOptions = options
          .where((element) => element.type == filter || filter == "all_items")
          .toList();
    });
    if (!isBigSize()) {
      Navigator.pop(context);
    }
  }

  void changeLocale() {
    if (Get.locale!.languageCode == "en") {
      Locale newLocale = const Locale("vi", "VN");
      Get.updateLocale(newLocale);
    } else {
      Locale newLocale = const Locale("en", "US");
      Get.updateLocale(newLocale);
    }
    setState(() {
      title = filter.tr;
    });
  }

  bool isBigSize() {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Uncle & Ant coffee shop"), actions: [
        FilledButton(
          onPressed: changeLocale,
          child: (Get.locale!.languageCode == "en")
              ? Flag.fromCode(
                  FlagsCode.VN,
                  width: 20,
                )
              : Flag.fromCode(
                  FlagsCode.US,
                  width: 20,
                ),
        ),
      ]),
      drawer: isBigSize()
          ? null
          : CustomDrawer(
              headerTitle: 'drawer_header'.tr,
              filter: filter,
              onItemTap: handleItemTap,
            ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return isBigSize()
              ? Row(
                  children: [
                    CustomDrawer(
                      headerTitle: 'drawer_header'.tr,
                      filter: filter,
                      onItemTap: handleItemTap,
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 600,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: filteredOptions.length,
                            itemBuilder: (context, index) {
                              return SingleItemDisplay(filteredOptions[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 600,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: filteredOptions.length,
                      itemBuilder: (context, index) {
                        return SingleItemDisplay(filteredOptions[index]);
                      },
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: const OrderTotal(),
    );
  }
}
