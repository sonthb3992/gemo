import 'package:flutter/material.dart';

import '../domain/concrete/menu_option.dart';

class MenuPageViewmodel extends ChangeNotifier {
  // Your state variables

  MenuPageViewmodel(this.context) {
    loadMenuItems();
  }

  final BuildContext context;

  List<MenuOption>? _menuOptions;
  get menuOption => _menuOptions;

  void loadMenuItems() async {
    _menuOptions = await MenuOption.getAll();
    notifyListeners();
  }
}
