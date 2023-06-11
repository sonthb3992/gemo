import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:flutter/foundation.dart';

class SizeOption extends OptionBase {
  final String nameEn;
  final String nameVi;
  final double basePrice;
  final int displayOrder;

  SizeOption(
      {required this.nameEn,
      required this.nameVi,
      required this.basePrice,
      required this.displayOrder});

  @override
  String? getName() => nameEn;

  @override
  double getBasePrice() => basePrice;

  factory SizeOption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SizeOption(
        nameEn: data?['nameEn'],
        nameVi: data?['nameVi'],
        basePrice: double.parse(data?['basePrice'].toString() ?? ""),
        displayOrder: int.parse(data?['displayOrder'].toString() ?? ""));
  }

  static Map<String, dynamic> toFirestore(SizeOption type) {
    return {
      "nameEn": type.nameEn,
      "nameVi": type.nameVi,
      "basePrice": type.basePrice,
      "displayOrder": type.displayOrder
    };
  }

  static Future<String> pushToFirebase(SizeOption option) async {
    try {
      final CollectionReference<Map<String, dynamic>> sizeOptionsCollection =
          FirebaseFirestore.instance.collection('size_options');

      final QuerySnapshot<Map<String, dynamic>> existingOptionsSnapshot =
          await sizeOptionsCollection
              .where('nameEn', isEqualTo: option.nameEn)
              .get();
      if (existingOptionsSnapshot.docs.isEmpty) {
        await sizeOptionsCollection.add(toFirestore(option));
        return "success";
      } else {
        return 'Size Option with the same name already exists';
      }
    } catch (e) {
      return 'Error adding Size Option to Firestore: $e';
    }
  }

  static Future<List<SizeOption>> getAll() async {
    try {
      final Query<Map<String, dynamic>> styleOptionsCollection =
          FirebaseFirestore.instance
              .collection('size_options')
              .orderBy("displayOrder");

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await styleOptionsCollection.get();

      final List<SizeOption> sizeOptions = snapshot.docs
          .map((doc) => SizeOption.fromFirestore(doc, null))
          .toList();

      return sizeOptions;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Size Options from Firestore: $e');
      }
      return [];
    }
  }

  @override
  double getCountPrice(int count) => basePrice;

  @override
  String? getNameVi() => nameVi;
}
