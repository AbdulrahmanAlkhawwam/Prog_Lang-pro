import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/components/screens/empty_orders_screen.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:program_language_project/src/features/home/presentation/manger/bloc/cart/cart_bloc.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/main/main_cubit.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../order/domain/entities/order.dart';
import '../../../product/presentation/widgets/product_item.dart';

class EditCartScreen extends StatefulWidget {
  final Order order;

  const EditCartScreen({super.key, required this.order});

  @override
  State<EditCartScreen> createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  double? _getPrice() {
    double sum = 0;
    for (Product product in widget.order.products as List) {
      sum += product.quantity * product.price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer.withOpacity(0.3),
                  border: Border.all(
                      color: context.colors.primary.withOpacity(0.7), width: 2),
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
                              .format(widget.order.updatedAt),
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
                          widget.order.status,
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
                  child: widget.order.products?.isEmpty ?? true
                      ? EmptyOrdersScreen(onRefresh: () async {})
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: appBor),
                          itemBuilder: (context, index) => ProductItem(
                            inCartScreen: true,
                            product: widget.order.products![index],
                            inShop: false,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: widget.order.products?.length ?? 0,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
