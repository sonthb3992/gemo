import 'package:coffee_shop/localization/locale_data.dart';
import 'package:coffee_shop/menu_page.dart';
import 'package:coffee_shop/viewmodels/all_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    ChangeNotifierProvider.value(
      value: AllOrdersState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppMessages(),
      locale: const Locale("en", "US"),
      title: "Coffee Shop Ordering system",
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SafeArea(
        child: MenuPage(),
      ),
    );
  }
}
