import 'package:coffee_shop/controls/page_new_order_base_item.dart';
import 'package:coffee_shop/controls/size_selector.dart';
import 'package:coffee_shop/style_selector.dart';
import 'package:coffee_shop/topping_selector.dart';
import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  bool isEn = Get.locale!.languageCode == "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEn
            ? widget.order.getBaseItem().name
            : widget.order.getBaseItem().nameVi),
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
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: BaseItemDisplay(
                order: orderBase,
                maxWidth: null,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (orderBase.getType() == "drink")
                    SizedBox(
                      width: 400,
                      child: StyleSelector(orderBase),
                    ),
                  if (orderBase.getType() == "drink")
                    SizedBox(
                      width: 400,
                      child: SizeSelector(orderBase),
                    ),
                  SizedBox(
                    width: 400,
                    child: ToppingSelector(orderBase),
                  ),
                ],
              ),
            ),
          ],
        ),
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
              child: Column(
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
