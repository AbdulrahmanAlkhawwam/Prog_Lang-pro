import 'package:flutter/material.dart';

import '../../models/shop.dart';
import 'shops_item.dart';

class ShopsList extends StatelessWidget {
  final List<Shop> shops;

  const ShopsList({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: shops.length,
      itemBuilder: (context, index) => ShopsItem(
        shop: shops[index],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
