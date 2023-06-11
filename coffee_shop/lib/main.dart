import 'package:coffee_shop/localization/locale_data.dart';
import 'package:coffee_shop/menu_page.dart';
import 'package:coffee_shop/viewmodels/all_orders_viewmodel.dart';
import 'package:coffee_shop/viewmodels/menu_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: ChangeNotifierProvider(
        create: (BuildContext context) => MenuPageViewmodel(context),
        child: const SafeArea(
          child: MenuPage(),
        ),
      ),
    );
  }
}
