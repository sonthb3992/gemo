import 'package:coffee_shop_staff/viewmodels/add_drink_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_drink.dart';

class ManageDrinksPage extends StatefulWidget {
  const ManageDrinksPage({super.key, required this.title});

  final String title;

  @override
  State<ManageDrinksPage> createState() => _ManageDrinksPageState();
}

class _ManageDrinksPageState extends State<ManageDrinksPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Search',
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => AddDrinkViewModel(),
                  child: SafeArea(
                      child: AddMenuItemPage(
                    title: "Add new menu item",
                  )),
                ),
              ),
            );
            if (result != null) {}
          },
          tooltip: 'Increment',
          child: const Icon(Icons.text_snippet),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
