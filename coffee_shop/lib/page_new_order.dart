import 'package:coffee_shop/page_new_order_item.dart';
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
    return MediaQuery.of(context).size.width > 820;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.getBaseItem().name),
      ),
      body: ListView(children: [
        isBigSize()
            ? ContentOnLarge(
                orderBase: widget.order,
              )
            : Content(
                orderBase: widget.order,
              ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: TotalButton(),
        )
      ]),
    );
  }
}

class ContentOnLarge extends StatelessWidget {
  const ContentOnLarge({super.key, required this.orderBase});

  final OrderBase orderBase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Expanded(
              child: BaseItemDisplay(
                order: orderBase,
                maxWidth: null,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (orderBase.getType() == "drink")
                    const SizedBox(
                      height: 10,
                    ),
                  if (orderBase.getType() == "drink") StyleSelector(orderBase),
                  if (orderBase.getType() == "drink") SizeSelector(orderBase),
                  ToppingSelector(orderBase),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.orderBase});

  final OrderBase orderBase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 8, 18, 8),
          child: Center(
              child: ListView(
            shrinkWrap: true,
            children: [
              BaseItemDisplay(
                order: orderBase,
                maxWidth: 800,
              ),
              if (orderBase.getType() == "drink")
                const SizedBox(
                  height: 10,
                ),
              if (orderBase.getType() == "drink") StyleSelector(orderBase),
              if (orderBase.getType() == "drink") SizeSelector(orderBase),
              ToppingSelector(orderBase),
            ],
          )),
        ),
        //       child: ListView(
        //         shrinkWrap: true,
        //         children: [
        //           BaseItemDisplay(order: orderBase, maxWidth: null),
        //           if (orderBase.getType() == "drink")
        //             const SizedBox(
        //               height: 10,
        //             ),
        //           if (orderBase.getType() == "drink") StyleSelector(orderBase),
        //           if (orderBase.getType() == "drink") SizeSelector(orderBase),
        //           ToppingSelector(orderBase),
        //           const TotalButton(),
        //         ],
        //       ),
        //     ),
        //   ],
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
