import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MenuItemTypeOption {
  final String nameEn;
  final String nameVi;

  MenuItemTypeOption({
    required this.nameEn,
    required this.nameVi,
  });

  factory MenuItemTypeOption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MenuItemTypeOption(
      nameEn: data?['nameEn'],
      nameVi: data?['nameVi'],
    );
  }

  static Map<String, dynamic> toFirestore(MenuItemTypeOption type) {
    return {"nameEn": type.nameEn, "nameVi": type.nameVi};
  }

  static Future<void> addMenuTypeOption(MenuItemTypeOption option) async {
    try {
      final CollectionReference<Map<String, dynamic>> menuOptionsCollection =
          FirebaseFirestore.instance.collection('menu_item_types');

      await menuOptionsCollection.add(toFirestore(option));
    } catch (e) {
      if (kDebugMode) {
        print('Error adding MenuTypeOption to Firestore: $e');
      }
    }
  }

  static Future<List<MenuItemTypeOption>> getAllMenuTypeOptions() async {
    try {
      final CollectionReference<Map<String, dynamic>> menuOptionsCollection =
          FirebaseFirestore.instance.collection('menu_item_types');

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await menuOptionsCollection.get();

      final List<MenuItemTypeOption> menuTypeOptions = snapshot.docs
          .map((doc) => MenuItemTypeOption.fromFirestore(doc, null))
          .toList();

      return menuTypeOptions;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting MenuTypeOptions from Firestore: $e');
      }
      return [];
    }
  }
}
