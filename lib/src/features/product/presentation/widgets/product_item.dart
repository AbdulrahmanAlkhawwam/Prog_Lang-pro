import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../../../shop/presentation/manger/shop_bloc.dart';
import '../../domain/entities/product.dart';
import '../manger/product_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final store = context
        .read<ShopBloc>()
        .state
        .shops
        .where((element) => element.id == product.storeId)
        .first
        .name;
    final category = context
        .read<ProductBloc>()
        .state
        .categories
        .where((element) => element.id == product.categoryId)
        .first
        .name;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(appBor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              context.read<MainCubit>().image(product.image),
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  product.name,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.category_outlined),
                        const SizedBox(width: 8),
                        Text(category)
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.door_back_door_outlined),
                        const SizedBox(width: 8),
                        Text(store)
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_money),
                        const SizedBox(width: 8),
                        Text(product.price.toString())
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
