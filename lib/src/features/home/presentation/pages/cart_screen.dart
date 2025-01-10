import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:program_language_project/src/features/home/presentation/manger/bloc/cart/cart_bloc.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/main/main_cubit.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/screens/empty_shops_screen.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../product/presentation/widgets/product_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(GetCart());
    super.initState();
  }

  double? _getPrice() {
    double sum = 0;
    for (Product product in context.read<CartBloc>().state.cart as List) {
      sum += product.quantity * product.price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocConsumer<CartBloc, CartState>(
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
                                DateFormat("yyyy/MM/dd - HH:mm")
                                    .format(DateTime.now()),
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
                                "NOT CREATED",
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
                                "${_getPrice() ?? 0.0}",
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
                              padding: EdgeInsets.symmetric(horizontal: appBor),
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
                  : () => context.read<CartBloc>().add(CreateOrder()),
              text: "Order",
            ),
          );
        },
      ),
    );
  }
}
