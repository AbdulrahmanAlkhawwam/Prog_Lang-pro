import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/components/dialogs/cancelled_dialog.dart';
import 'package:program_language_project/src/features/home/presentation/pages/edit_cart_screen.dart';
import 'package:program_language_project/src/features/order/presentation/manger/order_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/components/skeleton.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/entities/order.dart';
import '../pages/order_details_screen.dart';

class PurchaseItem extends StatelessWidget {
  final Order order;
  final bool isLoading;

  const PurchaseItem({
    super.key,
    required this.order,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading
          ? null
          : () => context.push(OrderDetailsScreen(order: order)),
      onLongPress: order.status == "PENDING"
          ? () async {
              final result = await showDialog(
                  context: context, builder: (context) => CancelledDialog());
              if (result == true) {
                context.push(EditCartScreen(order: order));
              } else if (result == false) {
                context.read<OrderBloc>().add(CancelledOrder(id: order.id));
              }
            }
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.all(16),
        height: 120,
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
                isLoading
                    ? Expanded(
                        child: Shimmer.fromColors(
                          baseColor: context.colors.outline.withOpacity(0.3),
                          highlightColor: context.colors.surface,
                          child: Skeleton(height: 10),
                        ),
                      )
                    : Text(
                        DateFormat("MM/dd - HH:mm").format(order.updatedAt),
                        style: context.textTheme.bodySmall,
                      ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.storefront,
                  color: context.colors.onPrimaryContainer,
                ),
                SizedBox(width: 12),
                isLoading
                    ? Expanded(
                        child: Shimmer.fromColors(
                          baseColor: context.colors.outline.withOpacity(0.3),
                          highlightColor: context.colors.surface,
                          child: Skeleton(height: 10),
                        ),
                      )
                    : Text(
                        "${order.products!.length} products",
                        style: context.textTheme.bodySmall,
                      ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: context.colors.onPrimaryContainer,
                ),
                SizedBox(width: 12),
                isLoading
                    ? Expanded(
                        child: Shimmer.fromColors(
                          baseColor: context.colors.outline.withOpacity(0.3),
                          highlightColor: context.colors.surface,
                          child: Skeleton(height: 10),
                        ),
                      )
                    : Text(
                        order.price.toString(),
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
