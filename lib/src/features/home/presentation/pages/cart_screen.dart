import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/screens/empty_shops_screen.dart';
import '../../../../core/constants/styles.dart';
import '../../../product/presentation/widgets/product_item.dart';
import '../manger/cubit/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.error) {
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                if (!(state.cart?.isEmpty ?? true))
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer.withOpacity(0.3),
                      border: Border.all(
                          color: context.colors.primary.withOpacity(0.7),
                          width: 2),
                      borderRadius: BorderRadius.circular(appBor),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(width: 12),
                            Text(
                              "date",
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.lens_blur),
                            SizedBox(width: 12),
                            Text(
                              "order.status",
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
                            Text(
                              "order.price.toString()",
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                Expanded(
                    child: state.cart?.isEmpty ?? true
                        ? EmptyScreen(isShopScreen: false)
                        : ListView.separated(
                            itemBuilder: (context, index) => ProductItem(
                              product: state.cart![index],
                              inShop: false,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: state.cart?.length ?? 0,
                          ))
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AppButton(
            background: context.colors.secondaryContainer,
            textColor: context.colors.onSecondaryContainer,
            splash: context.colors.secondary,
            isLoading: state.status == CartStatus.loading,
            onPressed: state.cart?.isEmpty ?? true
                ? null
                : () => print("create Order"),
            //context.read<CartCubit>().addToCart(product),
            text: "Order",
          ),
        );
      },
    );
  }
}
