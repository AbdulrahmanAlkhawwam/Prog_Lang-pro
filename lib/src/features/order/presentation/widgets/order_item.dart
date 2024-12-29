import 'package:flutter/material.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';

import '../../domain/entities/order.dart';

class PurchaseItem extends StatelessWidget {
  final Order purchase;

  const PurchaseItem({
    super.key,
    required this.purchase,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(17),
        height: 119,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.surfaceContainer,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: context.colors.onPrimaryContainer,
                ),
                SizedBox(width: 12),
                Text(
                  "purchases date",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.storefront,
                  color: context.colors.onPrimaryContainer,
                ),
                SizedBox(width: 12),
                Text(
                  "market name",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: context.colors.onPrimaryContainer,
                ),
                SizedBox(width: 12),
                Text(
                  "purchases price",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
