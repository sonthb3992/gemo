import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/foundation.dart';

class MenuOption extends OptionBase {
  String nameEn = '';
  String nameVi = '';
  String type = '';
  double basePrice = 0;
  String imageUrl = '';
  List<String>? availableStyles;
  List<String>? availableSizes;
  List<String>? availableToppings;

  MenuOption({
    this.nameEn = '',
    this.nameVi = '',
    this.type = '',
    this.basePrice = 0,
    this.imageUrl = '',
    this.availableStyles,
    this.availableSizes,
    this.availableToppings,
  });

  factory MenuOption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    List<String>? styles;
    if (data?['availableStyles'] != null) {
      List<dynamic> availableStyles = data?['availableStyles'];
      styles = availableStyles.map((e) => e.toString()).toList();
    }
    List<String>? sizes;
    if (data?['availableSizes'] != null) {
      List<dynamic> availableSizes = data?['availableSizes'];
      sizes = availableSizes.map((e) => e.toString()).toList();
    }
    List<String>? toppings;
    if (data?['availableToppings'] != null) {
      List<dynamic> availableToppings = data?['availableToppings'];
      toppings = availableToppings.map((e) => e.toString()).toList();
    }

    return MenuOption(
        nameEn: data?['nameEn'],
        nameVi: data?['nameVi'],
        basePrice: double.parse(data!['basePrice'].toString()),
        type: data['type'],
        imageUrl: data['imageUrl'],
        availableStyles: styles,
        availableSizes: sizes,
        availableToppings: toppings);
  }

  static Map<String, dynamic> toFirestore(MenuOption option) {
    return {
      "nameEn": option.nameEn,
      "nameVi": option.nameVi,
      "basePrice": option.basePrice,
      "type": option.type,
      "imageUrl": option.imageUrl,
      "availableStyles": option.availableStyles,
      "availableSizes": option.availableSizes,
      "availableToppings": option.availableToppings
    };
  }

  static Future<String> pushToFirebase(MenuOption option) async {
    try {
      final CollectionReference<Map<String, dynamic>> menuOptionCollection =
          FirebaseFirestore.instance.collection('menu_options');

      final QuerySnapshot<Map<String, dynamic>> existingOptionsSnapshot =
          await menuOptionCollection
              .where('nameEn', isEqualTo: option.nameEn)
              .get();
      if (existingOptionsSnapshot.docs.isEmpty) {
        await menuOptionCollection.add(toFirestore(option));
        return "success";
      } else {
        return 'Menu option with the same name already exists';
      }
    } catch (e) {
      return 'Error adding Menu option to Firestore: $e';
    }
  }

  static Future<List<MenuOption>> getAll() async {
    try {
      final Query<Map<String, dynamic>> menuOptionsCollection =
          FirebaseFirestore.instance
              .collection('menu_options')
              .orderBy("type")
              .orderBy("nameEn");

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await menuOptionsCollection.get();

      final List<MenuOption> menuOptions = snapshot.docs
          .map((doc) => MenuOption.fromFirestore(doc, null))
          .toList();
      return menuOptions;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Menu options from Firestore: $e');
      }
      return [];
    }
  }

  @override
  String? getName() => nameEn;

  @override
  String? getNameVi() => nameVi;

  @override
  double getBasePrice() => basePrice;

  @override
  double getCountPrice(int count) => basePrice;
}
  // static const coffee = MenuOption(
  //     name: "Coffee",
  //     nameVi: "Cà phê",
  //     type: "drink",
  //     basePrice: 2,
  //     imageUrl:
  //         "https://minio.thecoffeehouse.com/image/admin/1639377798_ca-phe-den-da_400x400.jpg");
  // static const milkTea = MenuOption(
  //     name: "Milk tea",
  //     nameVi: "Trà sữa",
  //     type: "drink",
  //     basePrice: 2.25,
  //     imageUrl:
  //         "https://minio.thecoffeehouse.com/image/admin/hong-tra-sua-tran-chau_326977_400x400.jpg");
  // static const sandwich = MenuOption(
  //     name: "Sandwich",
  //     nameVi: "Bánh mì sandwich",
  //     type: "breakfast",
  //     basePrice: 3,
  //     imageUrl:
  //         "https://minio.thecoffeehouse.com/image/admin/1638440015_banh-mi-vietnam_400x400.jpg");
  // static const bagel = MenuOption(
  //     name: "Bagel",
  //     nameVi: "Bánh vòng",
  //     type: "breakfast",
  //     basePrice: 3,
  //     imageUrl:
  //         "https://minio.thecoffeehouse.com/image/admin/1669736956_banh-mi-que-pate_400x400.png");
