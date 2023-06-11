import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/foundation.dart';

class ToppingOption extends OptionBase {
  final String nameEn;
  final String nameVi;
  final double basePrice;
  final int maxCount;
  final int freeCount;

  ToppingOption(
      {required this.nameEn,
      required this.nameVi,
      required this.basePrice,
      required this.maxCount,
      required this.freeCount});

  @override
  String? getName() => nameEn;

  @override
  double getBasePrice() => basePrice;

  factory ToppingOption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    if (data == null) {
      return ToppingOption.empty;
    }
    return ToppingOption(
        nameEn: data['nameEn'],
        nameVi: data['nameVi'],
        basePrice: double.parse(data['basePrice'].toString()),
        maxCount: int.parse(data['maxCount'].toString()),
        freeCount: int.parse(data['freeCount'].toString()));
  }

  static ToppingOption empty = ToppingOption(
      nameEn: "", nameVi: "", basePrice: 0, maxCount: 0, freeCount: 0);

  static Map<String, dynamic> toFirestore(ToppingOption topping) {
    return {
      "nameEn": topping.nameEn,
      "nameVi": topping.nameVi,
      "basePrice": topping.basePrice,
      "maxCount": topping.maxCount,
      "freeCount": topping.freeCount
    };
  }

  static Future<String> pushToFirebase(ToppingOption option) async {
    try {
      final CollectionReference<Map<String, dynamic>> sizeOptionsCollection =
          FirebaseFirestore.instance.collection('toppings');

      final QuerySnapshot<Map<String, dynamic>> existingOptionsSnapshot =
          await sizeOptionsCollection
              .where('nameEn', isEqualTo: option.nameEn)
              .get();
      if (existingOptionsSnapshot.docs.isEmpty) {
        await sizeOptionsCollection.add(toFirestore(option));
        return "success";
      } else {
        return 'Topping Option with the same name already exists';
      }
    } catch (e) {
      return 'Error adding Size Option to Firestore: $e';
    }
  }

  static getAll() async {
    try {
      final Query<Map<String, dynamic>> styleOptionsCollection =
          FirebaseFirestore.instance.collection('toppings').orderBy("maxCount");

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await styleOptionsCollection.get();

      final List<ToppingOption?> menuTypeOptions = snapshot.docs
          .map((doc) => ToppingOption.fromFirestore(doc, null))
          .toList();

      return menuTypeOptions;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Topping Options from Firestore: $e');
      }
      return [];
    }
  }

  @override
  double getCountPrice(int count) {
    return max(count - freeCount, 0) * basePrice;
  }

  @override
  String? getNameVi() => nameVi;
}
