import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  final String headerTitle;
  final String filter;
  final Function(String, String) onItemTap;

  const CustomDrawer(
      {super.key,
      required this.headerTitle,
      required this.filter,
      required this.onItemTap});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // This is where you put the logic for the Drawer

  // Get the current filter from the widget
  String get currentFilter => widget.filter;

  // Get the current headerTitle from the widget
  String get currentHeaderTitle => widget.headerTitle;

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    // This is where you put the UI for the Drawer
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 65,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.orangeAccent),
              child: Text(
                "drawer_header".tr,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // Here we use widget.onItemTap instead of directly manipulating the state
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            contentPadding: const EdgeInsets.all(8),
            selected: currentFilter == "",
            title: Text(
              "all_items".tr,
              style: style1,
            ),
            onTap: () => widget.onItemTap("All items", "all_items"),
          ),
          ListTile(
            leading: const Icon(Icons.local_cafe),
            contentPadding: const EdgeInsets.all(8),
            selected: currentFilter == "drink",
            title: Text(
              "drink".tr,
              style: style1,
            ),
            onTap: () => widget.onItemTap("Drink", "drink"),
          ),
          ListTile(
            leading: const Icon(Icons.bakery_dining),
            contentPadding: const EdgeInsets.all(8),
            selected: currentFilter == "breakfast",
            title: Text(
              "breakfast".tr,
              style: style1,
            ),
            onTap: () => widget.onItemTap("Breakfast", "breakfast"),
          ),
        ],
      ),
    );
  }
}
