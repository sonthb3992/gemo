import 'package:coffee_shop/domain/concrete/enums.dart';
import 'package:coffee_shop/menu_page_item.dart';
import 'package:coffee_shop/menu_page_total.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controls/language_button.dart';
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

  void setTitle() {
    setState(() {
      title = filter.tr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        LanguageButton(setTitle),
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
