import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:coffee_shop/domain/concrete/bartender.dart';
import 'package:coffee_shop/domain/concrete/enums.dart';
import 'package:flutter/material.dart';

class NewOrderState extends ChangeNotifier {
  // Your state variables

  NewOrderState(this._baseOption);

  final MenuOption _baseOption;
  MenuOption getBaseItem() => _baseOption;

  DrinkTypeOption _type = DrinkTypeOption.hot;
  DrinkTypeOption getDrinkType() => _type;
  void setDrinkType(DrinkTypeOption newValue) {
    if (_type != newValue) {
      _type = newValue;
      notifyListeners();
    }
  }

  DrinkSizeOption _size = DrinkSizeOption.s;
  DrinkSizeOption getDrinkSize() => _size;
  void setDrinkSize(DrinkSizeOption newValue) {
    if (_size != newValue) {
      if (newValue == DrinkSizeOption.s ||
          newValue == DrinkSizeOption.m ||
          _type == DrinkTypeOption.cold ||
          _type == DrinkTypeOption.blended) {
        _size = newValue;
        notifyListeners();
      } else {
        throw Exception("Unable to set size");
      }
    }
  }

  bool? _hasWhippedCream;
  bool? getHasWhippedCream() => _hasWhippedCream;
  void setWhippedCream(bool? value) {
    if (getBaseItem().type != "drink") {
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
    if (_type != DrinkTypeOption.hot) {
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
      _type,
      _size,
      getHasWhippedCream(),
      getMilk(),
      hasChocolateSauce(),
      getPumps(),
      getHasTurkey(),
      getHasCheeseCream());

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
    if (getBaseItem().type != "breakfast") {
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
    if (getBaseItem().type != "breakfast") {
      _hasCheeseCream = null;
      notifyListeners();
      return;
    }
    _hasCheeseCream = value;
    notifyListeners();
  }
}
