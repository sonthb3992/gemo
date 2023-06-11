import 'package:coffee_shop/domain/concrete/menu_option.dart';
import 'package:coffee_shop/domain/concrete/option_menu_item_type.dart';
import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:coffee_shop/domain/concrete/option_style.dart';
import 'package:coffee_shop/domain/concrete/option_topping.dart';
import 'package:flutter/widgets.dart';

class AddDrinkViewModel extends ChangeNotifier {
  // Your state variables
  List<MenuItemTypeOption>? allMenuItemTypes;
  List<Map<StyleOption, bool>>? allStyles;
  List<Map<SizeOption, bool>>? allSizes;
  List<Map<ToppingOption, bool>>? allToppings;
  MenuItemTypeOption? selectedMenuItemType;
  late MenuOption newOption;

  AddDrinkViewModel() {
    loadMenuItemTypeOptions();
    newOption = MenuOption();
  }

  BuildContext? _context;
  get context => _context;
  set context(value) {
    _context = value;
  }

  Future<String?> createMenuOption(
      String nameEn, String nameVi, double basePrice, String imageUrl) async {
    newOption.nameEn = nameEn;
    newOption.nameVi = nameVi;
    newOption.basePrice = basePrice;
    newOption.imageUrl = imageUrl;

    newOption.type = selectedMenuItemType!.nameEn;

    if (allSizes != null) {
      newOption.availableSizes = allSizes!
          .where((element) => element.values.first)
          .map((e) => e.keys.first.nameEn)
          .toList();
    }
    if (allStyles != null) {
      newOption.availableStyles = allStyles!
          .where((element) => element.values.first)
          .map((e) => e.keys.first.nameEn)
          .toList();
    }
    if (allStyles != null) {
      newOption.availableToppings = allToppings!
          .where((element) => element.values.first)
          .map((e) => e.keys.first.nameEn)
          .toList();
    }

    return await MenuOption.pushToFirebase(newOption);
  }

  void loadMenuItemTypeOptions() async {
    allMenuItemTypes = await MenuItemTypeOption.getAllMenuTypeOptions();
    if (allMenuItemTypes != null && allMenuItemTypes!.isNotEmpty) {
      selectedMenuItemType = allMenuItemTypes!.first;
      notifyListeners();
    }
  }

  setSelectedMenuItemType(MenuItemTypeOption? option) {
    selectedMenuItemType = option;
    notifyListeners();
  }

  bool supportStyle = false;
  setSupportStyle(bool value) async {
    supportStyle = value;
    await loadStyleOptions();
    notifyListeners();
  }

  loadStyleOptions() async {
    List<StyleOption> styles = await StyleOption.getAll();
    allStyles = styles.map((style) => {style: false}).toList();
    notifyListeners();
  }

  void setHasStyle(Map<StyleOption, bool> option, bool? value) {
    value = value ?? false;
    option[option.keys.first] = value;
    notifyListeners();
  }

  bool supportSize = false;
  setSupportSize(bool value) async {
    supportSize = value;
    await loadSizeOptions();
    notifyListeners();
  }

  loadSizeOptions() async {
    List<SizeOption> styles = await SizeOption.getAll();
    allSizes = styles.map((size) => {size: false}).toList();
    notifyListeners();
  }

  void setHasSize(Map<SizeOption, bool> option, bool? value) {
    value = value ?? false;
    option[option.keys.first] = value;
    notifyListeners();
  }

  bool supportTopping = false;
  setSupportTopping(bool value) async {
    supportTopping = value;
    await loadToppingOptions();
    notifyListeners();
  }

  loadToppingOptions() async {
    List<ToppingOption> toppings = await ToppingOption.getAll();
    allToppings = toppings.map((topping) => {topping: false}).toList();
    notifyListeners();
  }

  void setHasTopping(Map<ToppingOption, bool> option, bool? value) {
    value = value ?? false;
    option[option.keys.first] = value;
    notifyListeners();
  }
}
