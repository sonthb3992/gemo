import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/domain/base/option_base.dart';
import 'package:coffee_shop/domain/concrete/option_size.dart';
import 'package:flutter/foundation.dart';

class StyleOption extends OptionBase {
  final String nameEn;
  final String nameVi;
  final double basePrice;
  final List<SizeOption>? availableSizes;

  static List<StyleOption>? _allOptions;
  static Future<List<StyleOption>?> get allOptions async {
    _allOptions ??= await StyleOption.getAll();
    return _allOptions;
  }

  StyleOption({
    required this.nameEn,
    required this.nameVi,
    required this.basePrice,
    required this.availableSizes,
  });

  @override
  String? getName() => nameEn;

  @override
  double getBasePrice() => basePrice;

  factory StyleOption.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return StyleOption(
        nameEn: data?['nameEn'],
        nameVi: data?['nameVi'],
        basePrice: double.parse(data?['basePrice'].toString() ?? ""),
        availableSizes: data?['avalableSizes']);
  }

  static Map<String, dynamic> toFirestore(StyleOption type) {
    return {
      "nameEn": type.nameEn,
      "nameVi": type.nameVi,
      "basePrice": type.basePrice,
      "availableSizes": type.availableSizes
    };
  }

  static Future<String> pushToFirebase(StyleOption option) async {
    try {
      final CollectionReference<Map<String, dynamic>> styleOptionsCollection =
          FirebaseFirestore.instance.collection('styles_options');

      final QuerySnapshot<Map<String, dynamic>> existingOptionsSnapshot =
          await styleOptionsCollection
              .where('nameEn', isEqualTo: option.nameEn)
              .get();
      if (existingOptionsSnapshot.docs.isEmpty) {
        await styleOptionsCollection.add(toFirestore(option));
        return "success";
      } else {
        return 'Style option with the same name already exists';
      }
    } catch (e) {
      return 'Error adding Style Option to Firestore: $e';
    }
  }

  static Future<List<StyleOption>> getAll() async {
    try {
      final CollectionReference<Map<String, dynamic>> styleOptionsCollection =
          FirebaseFirestore.instance.collection('style_options');

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await styleOptionsCollection.get();

      final List<StyleOption> menuTypeOptions = snapshot.docs
          .map((doc) => StyleOption.fromFirestore(doc, null))
          .toList();

      return menuTypeOptions;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Style Option from Firestore: $e');
      }
      return [];
    }
  }

  @override
  double getCountPrice(int count) => basePrice;

  @override
  String? getNameVi() => nameVi;
  // void saveStyleToFirestore(Style style) {
  //   // Get the Firestore instance.
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Create a document reference for the style.
  //   DocumentReference styleRef = firestore.collection("styles").doc(style.id);

  //   // Save the style to the document.
  //   styleRef.set(style.toJson());
  // }

  // Style readStyleFromFirestore(String id) {
  //   // Get the Firestore instance.
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Get the document reference for the style.
  //   DocumentReference styleRef = firestore.collection("styles").doc(id);

  //   // Get the style from the document.
  //   Style style = styleRef.get().data() as Style;

  //   return style;
  // }
}
