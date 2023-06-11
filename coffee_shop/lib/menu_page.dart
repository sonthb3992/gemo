import 'package:coffee_shop/menu_page_item.dart';
import 'package:coffee_shop/menu_page_total.dart';
import 'package:coffee_shop/viewmodels/menu_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

  void setTitle() {
    setState(() {
      title = filter.tr;
    });
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: const [
            Text('Popup Content'),
            // Add additional widgets as needed
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuPageViewmodel>(builder: (context, viewmodel, _) {
      return Scaffold(
        appBar: AppBar(title: Text(title), actions: [
          LanguageButton(setTitle),
          FilledButton.icon(
              onPressed: () => _openBottomSheet(context),
              icon: const Icon(Icons.lock_open),
              label: const Text("Test"))
        ]),
        drawer: CustomDrawer(
          //headerTitle: headerTitle,
          headerTitle: 'drawer_header'.tr,
          filter: filter,
          onItemTap: (String newHeaderTitle, String newFilter) {
            setState(() {
              // title = newFilter.tr;
              // filter = newFilter;
              // filteredOptions = options
              //     .where((element) =>
              //         element.type == filter || filter == "all_items")
              //     .toList();
            });
            Navigator.pop(context);
          },
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: viewmodel.menuOption == null
                  ? Container()
                  : SizedBox(
                      width: 600,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: viewmodel.menuOption.length,
                        itemBuilder: (context, index) {
                          return SingleItemDisplay(viewmodel.menuOption[index]);
                        },
                      ),
                    ),
            );
          },
        ),
        floatingActionButton: const OrderTotal(),
      );
    });
  }
}
