import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_image.dart';
import 'package:program_language_project/src/features/home/presentation/manger/bloc/cart/cart_bloc.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../domain/entities/product.dart';
import '../manger/product_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl.get<MainCubit>()),
        BlocProvider(create: (context) => sl.get<CartBloc>()),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state.status == SearchStatus.error) {
            context.showErrorSnackBar(massage: state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              title: Text(product.name),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: context.colors.secondary,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(appBor),
                      child: AppImage(
                          context.read<MainCubit>().image(product.image ?? '')),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.name,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.description ?? "",
                      style: context.textTheme.labelMedium,
                    ),
                    const SizedBox(height: appBor),
                    Row(
                      children: [
                        Icon(Icons.category_outlined),
                        const SizedBox(width: 8),
                        Text(
                          context
                              .read<ProductBloc>()
                              .state
                              .categories
                              .where(
                                  (element) => element.id == product.categoryId)
                              .first
                              .name,
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: appBor),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        const SizedBox(width: 8),
                        Text(
                          product.price.toString(),
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state.status == CartStatus.error) {
                  context.showErrorSnackBar(massage: state.message);
                }
              },
              builder: (context, state) {
                return AppButton(
                  background: context.colors.secondaryContainer,
                  splash: context.colors.secondary,
                  isLoading: state.status == CartStatus.loading,
                  onPressed: product.quantity == 0
                      ? null
                      : () => context
                          .read<CartBloc>()
                          .add(AddToCart(product: product)),
                  text: '',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Add to Cart",
                          style: context.textTheme.titleSmall?.copyWith(
                              color: context.colors.onSecondaryContainer),
                        )),
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: context.colors.onSecondaryContainer,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
