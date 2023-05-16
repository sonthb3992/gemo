import 'package:coffee_shop/viewmodels/all_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/base/oder_base.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllOrdersState(),
      child: const SummaryContent(),
    );
  }
}

class SummaryContent extends StatefulWidget {
  const SummaryContent({
    super.key,
  });

  @override
  State<SummaryContent> createState() => _SummaryContentState();
}

class _SummaryContentState extends State<SummaryContent> {
  bool isBigSize() {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    var allOrderState = Provider.of<AllOrdersState>(context);
    var allOrders = allOrderState.getAllOrders();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Selected Items"),
        ),
        body: Center(
          child: SizedBox(
            width: isBigSize() ? 600 : null,
            child: ListView.builder(
                itemCount: allOrders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FinalItemDisplay(order: allOrders[index]),
                  );
                }),
          ),
        ),
        bottomNavigationBar: const TotalButton(),
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
  bool isBigSize() {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    var allOrderState = Provider.of<AllOrdersState>(context);
    const style1 = TextStyle(fontSize: 18);
    var style2 = style1.copyWith(fontWeight: FontWeight.bold);

    return SizedBox(
      height: 180,
      child: Center(
        child: SizedBox(
          width: isBigSize() ? 600 : null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total before tax",
                        style: style1,
                      ),
                      Text(
                        "\$${allOrderState.getTotal().toStringAsFixed(2)}",
                        style: style1,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tax",
                        style: style1,
                      ),
                      Text(
                        "\$${allOrderState.getTax().toStringAsFixed(2)}",
                        style: style1,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total after tax",
                        style: style2,
                      ),
                      Text(
                        "\$${allOrderState.getGrandTotal().toStringAsFixed(2)}",
                        style: style2,
                      )
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.add),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Pay \$${allOrderState.getGrandTotal().toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FinalItemDisplay extends StatefulWidget {
  const FinalItemDisplay({
    super.key,
    required this.order,
  });

  final OrderBase order;

  @override
  State<FinalItemDisplay> createState() => _FinalItemDisplayState();
}

class _FinalItemDisplayState extends State<FinalItemDisplay> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: widget.order.getBaseItem().imageUrl.isNotEmpty
              ? Image(
                  image: NetworkImage(widget.order.getBaseItem().imageUrl),
                  fit: BoxFit.contain,
                )
              : const Icon(Icons.broken_image),
        ),
        title: Row(
          children: [
            Expanded(child: Text(widget.order.getBaseItem().name)),
            Text("\$${widget.order.getPrice().toStringAsFixed(2)}")
          ],
        ),
        subtitle: Text(widget.order.getDescription()),
      ),
    );
  }
}
