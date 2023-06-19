import 'package:flutter/material.dart';

import 'package:rse/presentation/all.dart';

class IndicatorItem extends StatelessWidget {
  final String title;
  final double price;

  const IndicatorItem(this.price, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(
            formatMoney(price.toString()),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
