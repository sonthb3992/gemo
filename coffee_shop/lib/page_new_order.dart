import 'package:coffee_shop/size_selector.dart';
import 'package:coffee_shop/style_selector.dart';
import 'package:coffee_shop/topping_selector.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/base/oder_base.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key, required this.order});

  final OrderBase order;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewOrderState(order.getBaseItem()),
      child: NewOrderContent(order: order, formKey: formKey),
    );
  }
}

class NewOrderContent extends StatefulWidget {
  const NewOrderContent({
    super.key,
    required this.order,
    required this.formKey,
  });

  final OrderBase order;
  final GlobalKey<FormState> formKey;

  @override
  State<NewOrderContent> createState() => _NewOrderContentState();
}

class _NewOrderContentState extends State<NewOrderContent> {
  bool isBigSize() {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.order.getBaseItem().name),
        ),
        body: Center(
          child: SizedBox(
            width: isBigSize() ? 800 : null,
            height: 1000,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  BaseItemDisplay(order: widget.order),
                  // if (widget.order.getType() == "drink")
                  //   const SizedBox(
                  //     height: 10,
                  //   ),
                  // if (widget.order.getType() == "drink")
                  //   StyleSelector(widget.order),
                  // if (widget.order.getType() == "drink")
                  //   SizeSelector(widget.order),
                  // ToppingSelector(widget.order),
                  // const TotalButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TotalButton extends StatefulWidget {
  const TotalButton({
    super.key,
  });

  @override
  State<TotalButton> createState() => _TotalButtonState();
}

class _TotalButtonState extends State<TotalButton> {
  @override
  Widget build(BuildContext context) {
    var orderState = Provider.of<NewOrderState>(context);

    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context, orderState.getOrder());
        },
        icon: const Icon(Icons.add),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$${orderState.getTotal()}",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class BaseItemDisplay extends StatefulWidget {
  const BaseItemDisplay({
    super.key,
    required this.order,
  });

  final OrderBase order;

  @override
  State<BaseItemDisplay> createState() => _BaseItemDisplayState();
}

class _BaseItemDisplayState extends State<BaseItemDisplay> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.order.getBaseItem().imageUrl.isNotEmpty
              ? Image(
                  image: NetworkImage(widget.order.getBaseItem().imageUrl),
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.broken_image)),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.order.getBaseItem().name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    isFavorited = !isFavorited;
                  });
                },
                child: isFavorited
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.deepOrange,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.deepOrange,
                      )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Text(
              "Price: \$${widget.order.getBaseItem().basePrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
