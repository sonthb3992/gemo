import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/concrete/bartender.dart';
import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:coffee_shop/domain/concrete/option_style.dart';
import 'package:coffee_shop/domain/concrete/option_topping.dart';
import 'package:flutter/material.dart';

import '../domain/concrete/menu_option.dart';

class NewOrderState extends ChangeNotifier {
  // Your state variables

  NewOrderState(this._baseOption) {
    loadAvailableStyles();
    loadAvailableSizes();
    loadAvailableToppings();
  }

  final MenuOption _baseOption;
  MenuOption get baseOption => _baseOption;

  List<StyleOption>? _availableStyles;
  List<StyleOption>? get availableStyles => _availableStyles;

  void loadAvailableStyles() async {
    if (baseOption.availableStyles == null) {
      return;
    }
    var allOptions = await StyleOption.getAll();

    _availableStyles = allOptions
        .where((element) =>
            baseOption.availableStyles!.any((style) => style == element.nameEn))
        .toList();
    notifyListeners();
  }

  StyleOption? _selectedStyle;
  StyleOption? get selectedStyle => _selectedStyle;
  set selectedStyle(StyleOption? newValue) {
    if (_selectedStyle != newValue) {
      _selectedStyle = newValue;
      notifyListeners();
    }
  }

  List<SizeOption>? _availableSizes;
  List<SizeOption>? get availableSizes => _availableSizes;
  void loadAvailableSizes() async {
    if (baseOption.availableSizes == null) {
      return;
    }

    var allOptions = await SizeOption.getAll();

    _availableSizes = allOptions
        .where((element) =>
            baseOption.availableSizes!.any((style) => style == element.nameEn))
        .toList();

    notifyListeners();
  }

  SizeOption? _selectedSize;
  SizeOption? get selectedSize => _selectedSize;
  set selectedSize(SizeOption? newValue) {
    if (_selectedSize != newValue) {
      _selectedSize = newValue;
      notifyListeners();
    }
  }

  List<ToppingOption>? _availableToppings;
  List<ToppingOption>? get availableToppings => _availableToppings;
  List<Map<ToppingOption, int>>? _selectedToppings;
  List<Map<ToppingOption, int>>? get selectedToppings => _selectedToppings;

  void loadAvailableToppings() async {
    if (baseOption.availableToppings == null) {
      return;
    }
    var allOptions = await ToppingOption.getAll();

    _availableToppings = allOptions
        .where((topping) => baseOption.availableToppings!
            .any((toppingName) => toppingName == topping.nameEn))
        .toList();

    _selectedToppings = _availableToppings!.map((e) => {e: 0}).toList();
    notifyListeners();
  }

  bool? _hasWhippedCream;
  bool? getHasWhippedCream() => _hasWhippedCream;
  void setWhippedCream(bool? value) {
    if (baseOption.type != "drink") {
      _hasWhippedCream = null;
      notifyListeners();
      return;
    }
    _hasWhippedCream = value;
    notifyListeners();
  }

  String _milk = "";
  String getMilk() => _milk;
  void setMilk(String value) {
    _milk = value;
    notifyListeners();
  }

  bool? _hasChocolateSauce;
  bool? hasChocolateSauce() => _hasChocolateSauce;
  void setHasChocolateSauce(bool? value) {
    if (_selectedStyle!.nameEn == "hot") {
      _hasChocolateSauce = null;
      notifyListeners();
      return;
    }
    _hasChocolateSauce = value;
    if (_hasChocolateSauce == null || _hasChocolateSauce == false) _pumps = 0;
    notifyListeners();
  }

  int _pumps = 0;
  int getPumps() => _pumps;
  void setPumps(int value) {
    _pumps = value;
    notifyListeners();
  }

  double getTotal() {
    var order = getOrder();
    return order == null ? 0 : order.getPrice();
  }

  OrderBase? getOrder() => Bartender.buildOrder(
      _baseOption,
      _selectedStyle,
      _selectedSize,
      _selectedToppings?.where((element) => element.values.first > 0).toList());

  void sendToBartender() {
    var order = getOrder();
    if (order != null) {
      Bartender bar = Bartender();
      bar.addOrder(order);
    }
  }

  bool? _hasTurkey;
  bool? getHasTurkey() => _hasTurkey;
  void setHasTurkey(bool? value) {
    if (baseOption.type != "breakfast") {
      _hasTurkey = null;
      notifyListeners();
      return;
    }
    _hasTurkey = value;
    notifyListeners();
  }

  bool? _hasCheeseCream;
  bool? getHasCheeseCream() => _hasCheeseCream;
  void setHasCheeseCream(bool? value) {
    if (baseOption.type != "breakfast") {
      _hasCheeseCream = null;
      notifyListeners();
      return;
    }
    _hasCheeseCream = value;
    notifyListeners();
  }

  void setSelectedTopping(
      Map<ToppingOption, int> map, ToppingOption topping, int count) {
    map[topping] = count;
    notifyListeners();
  }

  void unsetSelectedTopping(
      Map<ToppingOption, int> map, ToppingOption topping) {
    map[topping] = 0;
    notifyListeners();
  }
}
