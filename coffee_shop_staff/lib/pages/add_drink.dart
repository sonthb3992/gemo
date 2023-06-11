import 'package:coffee_shop_staff/controls/size_support_selector.dart';
import 'package:coffee_shop_staff/controls/topping_support_selector.dart';
import 'package:coffee_shop_staff/viewmodels/add_drink_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controls/input_field_with_validator.dart';
import '../controls/style_support_selector.dart';
import '../controls/type_of_menu_item_selector.dart';

class AddMenuItemPage extends StatelessWidget {
  AddMenuItemPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const bold = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const normal = TextStyle(fontSize: 18);
  static const sub = TextStyle(fontSize: 14);
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameViController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  String? nullOrEmptyStringValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? doubleNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }

    return null;
  }

  void showMessageDialog(
      AddDrinkViewModel viewmodel, String title, String message) {
    showDialog(
        context: viewmodel.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddDrinkViewModel>(builder: (context, viewmodel, _) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                onPressed: () async {
                  if (formKey.currentState == null) {
                    return;
                  }
                  viewmodel.context = context;

                  if (formKey.currentState!.validate()) {
//               // Get the field values from the controllers
                    final name = nameController.text;
                    final nameVi = nameViController.text;
                    final basePrice = double.parse(basePriceController.text);
                    final imageUrl = imageUrlController.text;

                    if (viewmodel.selectedMenuItemType == null) {
                      showMessageDialog(viewmodel, "Warning",
                          "Please select a menu item type.");
                    }

                    if (viewmodel.supportStyle &&
                        !viewmodel.allStyles!
                            .any((element) => element.values.first == true)) {
                      showMessageDialog(viewmodel, "Warning",
                          "Please select available styles.");
                    }
                    if (viewmodel.supportSize &&
                        !viewmodel.allSizes!
                            .any((element) => element.values.first == true)) {
                      showMessageDialog(viewmodel, "Warning",
                          "Please select available sizes.");
                    }
                    if (viewmodel.supportTopping &&
                        !viewmodel.allToppings!
                            .any((element) => element.values.first == true)) {
                      showMessageDialog(viewmodel, "Warning",
                          "Please select available toppings.");
                    }

                    String? result = await viewmodel.createMenuOption(
                        name, nameVi, basePrice, imageUrl);

                    result = result ?? "Unexpected error.";
                    if (result == "success") {
                      showMessageDialog(viewmodel, "Success",
                          "New menu option has been added to the database.");
                    }
                  }
                },
                tooltip: 'Search',
                icon: const Icon(Icons.check),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Form(
              key: formKey,
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Type of new item:",
                      style: bold,
                    ),
                    if (viewmodel.allMenuItemTypes != null)
                      const TypeOfItemSelector(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Basic information:",
                      style: bold,
                    ),
                    InputFieldWidthValidator(
                        controller: nameController,
                        label: "Name",
                        validator: nullOrEmptyStringValidator),
                    const SizedBox(
                      height: 8,
                    ),
                    InputFieldWidthValidator(
                        controller: nameViController,
                        label: "Name (Vietnamese)",
                        validator: nullOrEmptyStringValidator),
                    const SizedBox(
                      height: 8,
                    ),
                    InputFieldWidthValidator(
                        controller: imageUrlController,
                        label: "Image Url",
                        validator: nullOrEmptyStringValidator),
                    const SizedBox(
                      height: 8,
                    ),
                    InputFieldWidthValidator(
                        controller: basePriceController,
                        label: "Base price",
                        validator: doubleNumberValidator),
                    const SizedBox(
                      height: 8,
                    ),
                    const StyleSupportSelector(),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizeSupportSelector(),
                    const SizedBox(
                      height: 8,
                    ),
                    const ToppingSupportSelector(),
                  ],
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }
}


// class AddDrinkPage extends StatefulWidget {
//   const AddDrinkPage({super.key, required this.title});

//   final String title;

//   @override
//   State<AddDrinkPage> createState() => _AddDrinkPageState();
// }

// class _AddDrinkPageState extends State<AddDrinkPage> {
//   @override
//   Widget build(BuildContext context) {
//     var viewmodel = Provider.of<AddDrinkViewModel>(context);

//     MenuItemTypeOption? type;
//     List<StyleOption>? availableStyles;
//     List<SizeOption>? availableSizes;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               tooltip: 'Search',
//               icon: const Icon(Icons.check),
//             )
//           ],
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: TextFormField(
//                       controller: nameController,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: TextFormField(
//                       controller: nameViController,
//                       decoration:
//                           const InputDecoration(labelText: 'Name (Vietnamese)'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a name in Vietnamese';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: TextFormField(
//                       decoration:
//                           const InputDecoration(labelText: 'Base Price'),
//                       controller: basePriceController,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             double.tryParse(value) == null) {
//                           return 'Please enter a base price';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: TextFormField(
//                       controller: imageUrlController,
//                       decoration: const InputDecoration(labelText: 'Image URL'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter an image URL';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   if (viewmodel.allMenuItemTypes != null)
//                     Row(
//                       children: [
//                         InkWell(
//                           child: Row(
//                             children: [
//                               Radio<MenuItemTypeOption?>(
//                                 value: viewmodel.allMenuItemTypes![0],
//                                 groupValue: type,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     type = value;
//                                   });
//                                 },
//                               ),
//                               Text(viewmodel.allMenuItemTypes![0].nameEn),
//                             ],
//                           ),
//                         ),
//                         InkWell(
//                           child: Row(
//                             children: [
//                               Radio<MenuItemTypeOption>(
//                                 value: viewmodel.allMenuItemTypes![1],
//                                 groupValue: type,
//                                 onChanged: (value) {
//                                   print(value!.nameEn);
//                                   print(type?.nameEn);
//                                   setState(() {
//                                     type = value;
//                                   });
//                                 },
//                               ),
//                               Text(viewmodel.allMenuItemTypes![1].nameEn),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               // Get the field values from the controllers
//               final name = nameController.text;
//               final nameVi = nameViController.text;
//               final basePrice = double.parse(basePriceController.text);
//               final imageUrl = imageUrlController.text;

//               // Create a new MenuOption object with the inputted values
//               MenuOption newMenuOption = MenuOption(
//                 name: name,
//                 nameVi: nameVi,
//                 type: type!,
//                 basePrice: basePrice,
//                 imageUrl: imageUrl,
//                 availableStyles: availableStyles,
//                 availableSizes: availableSizes,
//               );

//               // Clear the input fields
//               nameController.clear();
//               nameViController.clear();
//               basePriceController.clear();
//               imageUrlController.clear();
//             }
//           },
//           tooltip: 'Increment',
//           child: const Icon(Icons.add),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
// }
