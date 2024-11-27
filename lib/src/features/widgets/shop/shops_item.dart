import 'package:flutter/material.dart';

import '../../../core/utils/app_context.dart';
import '../../models/shop.dart';

class ShopsItem extends StatelessWidget {
  final Shop shop;

  const ShopsItem({
    super.key,
    required this.shop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.onPrimary,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.outline,
              ),
              // TODO : FIX THIS
              // child: Image.network(shop.imageId),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9),
            child: Text(
              shop.name.toUpperCase(),
              style: context.textTheme.labelSmall,
            ),
          )
        ],
      ),
    );
  }
}
