import 'package:coffee_shop/domain/base/oder_base.dart';
import 'package:flutter/material.dart';

class BaseItemDisplay extends StatefulWidget {
  const BaseItemDisplay(
      {super.key, required this.order, required this.maxWidth});

  final OrderBase order;
  final double? maxWidth;

  @override
  State<BaseItemDisplay> createState() => _BaseItemDisplayState();
}

class _BaseItemDisplayState extends State<BaseItemDisplay> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.maxWidth == null
          ? const BoxConstraints(maxWidth: double.infinity)
          : BoxConstraints(maxWidth: widget.maxWidth!),
      child: SingleChildScrollView(
        child: Column(children: [
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
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorited = !isFavorited;
                      });
                    },
                    icon: isFavorited
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
        ]),
      ),
    );
  }
}
