import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../domain/entities/shop.dart';
import '../pages/shop_details_screen.dart';

class ShopsItem extends StatelessWidget {
  final Shop shop;

  const ShopsItem({
    super.key,
    required this.shop,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(ShopDetailsScreen(id: shop.id)),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(appBor),
          color: context.colors.surfaceContainer,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(appBor),
                  color: context.colors.outline,
                ),
                child: Image.network(
                    context.read<MainCubit>().image(shop.imagePath)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 9),
              child: Text(
                shop.name.toUpperCase(),
                style: context.textTheme.labelSmall
                    ?.copyWith(color: context.colors.onPrimaryContainer),
              ),
            )
          ],
        ),
      ),
    );
  }
}
