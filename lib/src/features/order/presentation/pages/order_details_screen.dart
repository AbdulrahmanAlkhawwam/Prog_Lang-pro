import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../../../product/presentation/widgets/product_item.dart';
import '../../domain/entities/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.secondaryContainer.withOpacity(0.3),
                border: Border.all(
                    color: context.colors.secondary.withOpacity(0.7), width: 2),
                borderRadius: BorderRadius.circular(appBor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      SizedBox(width: 12),
                      Text(
                        DateFormat("MM/dd - HH:mm").format(order.updatedAt),
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
                        order.status,
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
                        order.price.toString(),
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Products :-"),
            ),
            Expanded(
                child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => ProductItem(
                inShop: false,
                product: order.products[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: order.products.length,
            ))
          ],
        ),
      ),
    );
  }
}
