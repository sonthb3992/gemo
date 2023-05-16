import 'package:coffee_shop/page_summary.dart';
import 'package:coffee_shop/viewmodels/all_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTotal extends StatefulWidget {
  const OrderTotal({super.key});

  @override
  State<OrderTotal> createState() => _OrderTotalState();
}

class _OrderTotalState extends State<OrderTotal> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AllOrdersState>(context);
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.paid,
        color: Colors.white,
      ),
      label: Text(
          "${state.getCount()} items, \$${state.getTotal().toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: state.getCount() == 0
          ? null
          : () async {
              var resetOrder = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SummaryPage(),
                ),
              );
              if (resetOrder == true) {
                state.resetOrders();
              }
            },
    );
  }
}
