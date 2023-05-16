import 'package:coffee_shop/domain/concrete/enums.dart';
import 'package:coffee_shop/menu_page_item.dart';
import 'package:coffee_shop/menu_page_total.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_drawer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String filter = "all_items";
  String title = 'all_items'.tr;
  static const List<MenuOption> options = [
    MenuOption.coffee,
    MenuOption.milkTea,
    MenuOption.sandwich,
    MenuOption.bagel,
  ];
  List<MenuOption> filteredOptions = options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        FilledButton(
          onPressed: () {
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
        ),
      ]),
      drawer: CustomDrawer(
        //headerTitle: headerTitle,
        headerTitle: 'drawer_header'.tr,
        filter: filter,
        onItemTap: (String newHeaderTitle, String newFilter) {
          setState(() {
            title = newFilter.tr;
            filter = newFilter;
            filteredOptions = options
                .where((element) =>
                    element.type == filter || filter == "all_items")
                .toList();
          });
          Navigator.pop(context);
        },
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
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
