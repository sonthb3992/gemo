import 'package:coffee_shop/viewmodels/all_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'domain/concrete/drink_order.dart';
import 'domain/concrete/enums.dart';
import 'page_new_order.dart';

class SingleItemDisplay extends StatelessWidget {
  SingleItemDisplay(this.menuOption, {super.key});

  final MenuOption menuOption;
  final isEng = Get.locale!.languageCode == "en";

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AllOrdersState>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPage(order: DrinkOrder(menuOption)),
            ),
          );
          if (result != null) {
            state.addOrder(result);
          }
        },
        child: ListTile(
          leading: menuOption.imageUrl.isNotEmpty
              ? Image(image: NetworkImage(menuOption.imageUrl))
              : const Icon(Icons.image_not_supported),
          title: Text(
            isEng ? menuOption.name : menuOption.nameVi,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEng ? menuOption.type : menuOption.getViType(),
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                textAlign: TextAlign.start,
              ),
              Text(
                "\$${menuOption.basePrice}",
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
