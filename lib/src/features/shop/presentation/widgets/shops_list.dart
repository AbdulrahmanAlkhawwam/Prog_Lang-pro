import 'package:flutter/material.dart';

import '../../domain/entities/shop.dart';
import 'shops_item.dart';

class ShopsList extends StatelessWidget {
  final List<Shop> shops;
  final bool isHorizontal;

  const ShopsList({
    super.key,
    required this.shops,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? GridView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) => ShopsItem(
              shop: shops[index],
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          )
        : SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ShopsItem(shop: shops[index]),
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: shops.length,
            ),
          );
  }
}
