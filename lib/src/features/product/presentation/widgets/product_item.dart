import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_image.dart';
import 'package:program_language_project/src/features/product/presentation/pages/product_details_screen.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../../shop/presentation/manger/shop_bloc.dart';
import '../../domain/entities/product.dart';
import '../manger/product_bloc.dart';

class ProductItem extends StatelessWidget {
  final Function()? onLongPress;
  final Product product;
  final bool inShop;

  const ProductItem({
    super.key,
    this.onLongPress,
    required this.product,
    required this.inShop,
  });

  @override
  Widget build(BuildContext context) {
    final store = context
        .read<ShopBloc>()
        .state
        .shops
        .where((element) => element.id == product.storeId)
        .firstOrNull
        ?.name;
    final category = context
        .read<ProductBloc>()
        .state
        .categories
        .where((element) => element.id == product.categoryId)
        .firstOrNull
        ?.name;
    return InkWell(
      onTap: () => context.push(ProductDetailsScreen(
        product: product,
      )),
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(appBor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AppImage(
                context.read<MainCubit>().image(product.image ?? ''),
                placeholderHeight: 75,
                height: 140,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: appBor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.category_outlined),
                        const SizedBox(width: 8),
                        Text(category ?? "category name")
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          inShop
                              ? Icons.shopping_cart_outlined
                              : Icons.door_back_door_outlined,
                        ),
                        const SizedBox(width: 8),
                        Text(inShop
                            ? product.quantity.toString()
                            : store ?? "store name")
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_money),
                        const SizedBox(width: 8),
                        Text(inShop
                            ? product.price.toString()
                            : "${product.price} × ${product.quantity}")
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
